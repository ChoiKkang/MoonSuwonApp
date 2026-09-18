# Now Good Spots RPC and Flutter Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Supabase의 실데이터를 점수화하는 `public.get_now_good_spots` RPC를 추가하고 달빛수원 Flutter 홈의 “지금 가기 좋은 스팟” 카드에 연결한다.

**Architecture:** 원천·정규화 테이블은 클라이언트에서 직접 읽지 않는다. `serving.v_now_good_spot_candidates`가 공개 가능한 후보만 투영하고, `public.get_now_good_spots`가 KST 기준 혼잡도·야간 적합도·거리·운영자 보정 점수를 계산한다. Flutter는 `SpotRepositorySupabase`와 DTO를 통해 RPC만 호출하며 UI와 Provider는 Repository 인터페이스만 의존한다.

**Tech Stack:** PostgreSQL 17, PostGIS, Supabase Data API/PostgREST RPC, Flutter, Riverpod, Freezed/json_serializable, `supabase_flutter` 2.9.x.

## Global Constraints

- 공개 RPC 이름은 `public.get_now_good_spots(p_lat numeric DEFAULT NULL, p_lng numeric DEFAULT NULL, p_limit integer DEFAULT 2)`이다.
- 점수는 혼잡 45%, 야간 적합도 35%, 거리 20%와 `recommendation_boost`를 사용한다.
- `crowd_score = 100 - forecast_score`, `distance_score = greatest(0, 100 - distance_m / 30)`이며 3km 이상은 0점이다.
- 위치가 없거나 수원화성행궁 중심 `(37.2836, 127.0093)` 반경 10km 밖이면 거리 가중치를 제외하고 남은 가중치를 재정규화한다.
- 오늘 날짜와 시간 판정은 `Asia/Seoul`을 사용한다.
- 추천 시간이 둘 다 NULL이면 상시, 시작 이하 종료이면 당일 구간, 시작 초과 종료이면 자정을 넘는 구간이다.
- 예측이 없으면 야간 적합도와 유효한 거리만 재정규화하고 `forecast_status = 'forecast_unavailable'`, `crowd_level = NULL`을 반환한다.
- 반환 열은 `place_id`, `slug`, `display_name`, `hero_image_url`, `crowd_level`, `distance_m`, `reason_label`, `recommendation_score`, `forecast_status` 순서다.
- 후보는 활성·게시·지금 추천 활성·hero 이미지 보유 스팟으로 제한한다.
- 앱은 `core`, `raw`, `editorial`을 직접 조회하지 않고 RPC만 호출한다.
- 현재 홈 UI에서는 위치 권한을 새로 요청하지 않고 `p_lat/p_lng = NULL`로 호출한다. RPC는 좌표가 제공되는 미래 호출에도 같은 계약으로 동작한다.
- 내부 앱 import는 반드시 `show`를 사용하고, Supabase JSON은 DTO의 `fromJson`/`toJson`으로만 변환한다.
- 현재 브랜치의 기존 미커밋 변경을 보존하며 작업 파일 외 변경을 되돌리지 않는다.

---

### Task 1: Supabase 추천 후보와 점수화 RPC

**Files:**
- Create: `supabase/migrations/20260817185031_add_now_good_spots_rpc.sql`
- Modify: `/Users/nunu/Desktop/10-19 개발/15 공모전/docs/superpowers/specs/2026-05-25-dalbit-suwon-mvp-design.md`
- Modify: `/Users/nunu/Desktop/10-19 개발/15 공모전/docs/superpowers/specs/2026-06-17-dalbit-suwon-db-schema.md`

**Interfaces:**
- Consumes: `core.places`, `core.place_images`, `core.place_crowd_forecasts`, `editorial.place_copy`, `editorial.place_publish_state`.
- Produces: `public.get_now_good_spots(numeric, numeric, integer)` returning the nine-column contract in Global Constraints.

- [x] **Step 1: Verify the missing-function RED state**

Run against project `feifvxhltehhsugizrob`:

```sql
select * from public.get_now_good_spots(null::numeric, null::numeric, 2);
```

Expected: PostgreSQL `42883`, function does not exist.

- [x] **Step 2: Create the migration file**

The Supabase CLI is unavailable in this environment, so create the repository-convention timestamped file directly with `apply_patch`:

```bash
supabase/migrations/20260817185031_add_now_good_spots_rpc.sql
```

Expected: exactly one new migration file under `supabase/migrations/`; remote application records the same migration name.

- [x] **Step 3: Add recommendation controls and constraints**

The migration adds these columns to `editorial.place_publish_state`:

```sql
is_now_good_enabled boolean not null default false,
night_suitability_score numeric not null default 0,
recommended_from time,
recommended_until time,
recommendation_boost numeric not null default 0
```

Add checks for `night_suitability_score between 0 and 100`, `recommendation_boost between -100 and 100`, and create a partial candidate index covering rows where `is_published and is_now_good_enabled`.

- [x] **Step 4: Add the internal candidate view**

Create `serving.v_now_good_spot_candidates` from the five source relations. It must expose one hero image per place, today’s forecast by laterally joining `core.place_crowd_forecasts`, and exclude inactive, unpublished, disabled, or hero-less rows. The view must expose only fields required by the RPC and order nothing.

- [x] **Step 5: Add the public scoring RPC and permissions**

Implement a `LANGUAGE sql STABLE SECURITY INVOKER` function with `SET search_path = ''`. It must:

```sql
-- valid location only when both coordinates exist and the user is within 10km
ST_DWithin(
  ST_SetSRID(ST_MakePoint(p_lng::float8, p_lat::float8), 4326)::geography,
  ST_SetSRID(ST_MakePoint(127.0093, 37.2836), 4326)::geography,
  10000
)
```

Compute distance only for a valid location, clamp the final score to `0..100`, round `distance_m` to one decimal and score to two decimals, sort by score descending then display priority descending then display name ascending, and clamp `p_limit` to `1..20` with NULL defaulting to 2. Use `forecast_available` when a forecast row exists and `forecast_unavailable` otherwise.

Grant only the minimum bridge access required for the invoker function:

```sql
grant usage on schema serving to anon, authenticated;
grant select on serving.v_now_good_spot_candidates to anon, authenticated;
revoke all on function public.get_now_good_spots(numeric, numeric, integer) from public;
grant execute on function public.get_now_good_spots(numeric, numeric, integer) to anon, authenticated;
```

- [x] **Step 6: Seed operational values without raw-table changes**

Publish and enable the seven forecast-backed places that have hero images: `banghwasuryujeong`, `yeonmudae`, `janganmun`, `changnyongmun`, `hwaseong-haenggung`, `hwahongmun`, `seojangdae`. Assign explicit night suitability scores in the range `80..95`, leave both recommendation time fields NULL, and use zero boost unless an explicit tie-break is required.

- [x] **Step 7: Apply and verify the migration**

Apply the migration to `feifvxhltehhsugizrob`, then run:

```sql
select * from public.get_now_good_spots(null::numeric, null::numeric, 2);
select * from public.get_now_good_spots(37.2836, 127.0093, 2);
select has_function_privilege('anon', 'public.get_now_good_spots(numeric,numeric,integer)', 'EXECUTE');
select has_function_privilege('public', 'public.get_now_good_spots(numeric,numeric,integer)', 'EXECUTE');
```

Expected: both calls return exactly two image-backed rows; the first call has NULL distances; the second has non-NULL distances; `anon` is true and `public` is false. Run Supabase security and performance advisors and inspect only findings introduced by this migration.

- [x] **Step 8: Align the specs to the implemented public contract**

Replace references to `serving.get_now_good_spots` with `public.get_now_good_spots`, document the internal candidate view, default publication behavior, score fallback, and Flutter’s initial NULL-location behavior.

### Task 2: Flutter RPC repository and home-card mapping

**Files:**
- Create: `lib/features/spot/data/models/now_good_spots_query_dto.dart`
- Create: `lib/features/spot/data/models/now_good_spot_dto.dart`
- Create: `lib/features/spot/data/spot_repository_supabase.dart`
- Modify: `lib/features/spot/data/models/spot_summary.dart`
- Modify: `lib/features/spot/data/spot_repository_mock.dart`
- Modify: `lib/features/spot/provider/spot_provider.dart`
- Modify: `lib/features/home/ui/home_page.dart`
- Generate: `lib/features/spot/data/models/spot_summary.freezed.dart`
- Generate: `lib/features/spot/data/models/spot_summary.g.dart`
- Generate: `lib/features/spot/provider/spot_provider.g.dart`
- Test: `test/features/spot/data/now_good_spot_dto_test.dart`
- Test: `test/features/spot/data/spot_repository_supabase_test.dart`

**Interfaces:**
- Consumes: Supabase RPC rows from Task 1.
- Produces: `SpotRepositorySupabase.fetchNowGoodSpotsAsync()` and `SpotSummary` instances rendered by `nowGoodSpotsProvider`.

- [x] **Step 1: Write DTO and repository RED tests**

The DTO test parses this independent fixture and asserts every mapped value:

```dart
{
  'place_id': 'c2dd085a-dff6-40fc-9560-2376f89cc65e',
  'slug': 'banghwasuryujeong',
  'display_name': '방화수류정(동북각루)',
  'hero_image_url': 'https://example.com/hero.jpg',
  'crowd_level': '여유',
  'distance_m': 321.4,
  'reason_label': '지금 비교적 여유로워요',
  'recommendation_score': 82.35,
  'forecast_status': 'forecast_available',
}
```

The repository test uses a `SupabaseClient` with a test HTTP client, returns the complete RPC JSON array, and asserts that the request targets `/rest/v1/rpc/get_now_good_spots` and the real repository maps the response into `SpotSummary`.

- [x] **Step 2: Run tests and confirm expected RED failures**

Run:

```bash
flutter test test/features/spot/data/now_good_spot_dto_test.dart test/features/spot/data/spot_repository_supabase_test.dart
```

Expected: imports or types are missing because DTO and Supabase repository do not exist.

- [x] **Step 3: Implement DTOs and repository**

`NowGoodSpotsQueryDto` is a write DTO with nullable `lat/lng`, `limit = 2`, and `toJson()` mapping to `p_lat`, `p_lng`, `p_limit`. `NowGoodSpotDto` is a read DTO with typed fields matching all nine response columns and a `fromJson` factory. `SpotRepositorySupabase` receives a `SupabaseClient`, calls `rpc('get_now_good_spots', params: query.toJson())`, converts each row with `NowGoodSpotDto.fromJson`, and maps it to `SpotSummary`.

- [x] **Step 4: Extend the presentation model and mock**

Add `slug`, nullable `crowdLevel`, nullable `distanceM`, `reasonLabel`, `recommendationScore`, and `forecastStatus` to `SpotSummary`. Update `SpotRepositoryMock` fixtures with real-looking values so mock-only tests and previews remain valid.

- [x] **Step 5: Switch only the now-good list to Supabase**

Keep `SpotRepositoryMock` available for spot detail until a separate detail-RPC task. Inject `SpotRepositorySupabase(Supabase.instance.client)` for the repository used by `nowGoodSpotsProvider`; if a split provider is required to keep `spotDetailProvider` working, define separate repository providers rather than introducing a UseCase layer.

- [x] **Step 6: Render the RPC metadata in the existing card**

Keep the existing two-card layout and hero image. Navigate by `spot.slug` to `/spot/{slug}`. Add a compact `reasonLabel` line and crowd chip; render distance only when `distanceM != null`. Use `forecast_status` to suppress crowd text when forecast is unavailable. Loading, error, empty, one-row, and two-row states must not overflow.

- [x] **Step 7: Generate code and verify GREEN**

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter test test/features/spot/data/now_good_spot_dto_test.dart test/features/spot/data/spot_repository_supabase_test.dart
flutter test
dart analyze
flutter build ios --simulator --dart-define-from-file=config/dev.json
```

Expected: tests and build exit 0. `dart analyze` may retain only the pre-existing `use_null_aware_elements` informational lint in `mypage_page.dart`; no new issue may come from changed files.

### Task 2A: Route live recommendation slugs to the matching Supabase detail

**Files:**
- Create: `lib/features/spot/data/models/place_by_slug_dto.dart`
- Modify: `lib/features/spot/data/spot_repository_supabase.dart`
- Modify: `lib/features/spot/provider/spot_provider.dart`
- Generate: `lib/features/spot/provider/spot_provider.g.dart`
- Modify: `lib/features/spot/ui/spot_detail_page.dart`
- Modify: `test/features/spot/data/spot_repository_supabase_test.dart`
- Test: `test/features/spot/ui/spot_detail_page_test.dart`

**Interfaces:**
- Consumes: existing `public.get_place_by_slug(p_slug text)` RPC and existing mock IDs prefixed by `spot-`.
- Produces: live-slug detail navigation without changing existing mock course-detail navigation.

- [x] **Step 1: Capture the runtime RED and write failing tests**

Record the observed defect: tapping the `seojangdae` live recommendation rendered the fallback `방화수류정` detail. Add a repository HTTP-boundary test whose loopback response mirrors the complete `get_place_by_slug` JSON object and expects `/rest/v1/rpc/get_place_by_slug`, body `{'p_slug':'seojangdae'}`, and a `SpotDetail` named `효원의 종·서장대` with its HTTPS hero image. Add a widget test proving sparse live copy omits empty highlight, photo-tip, and romantic sections rather than rendering empty cards.

- [x] **Step 2: Verify the new tests fail for the missing live-detail behavior**

Run:

```bash
flutter test test/features/spot/data/spot_repository_supabase_test.dart test/features/spot/ui/spot_detail_page_test.dart
```

Expected: `PlaceBySlugDto`/live detail method or sparse-section behavior is absent.

- [x] **Step 3: Implement the read DTO and repository mapping**

`PlaceBySlugDto.fromJson` and its nested image DTO parse the RPC fields with `num`-safe coordinates. `SpotRepositorySupabase` implements both `SpotRepository` and `NowGoodSpotsRepository`; `fetchSpotDetailAsync(slug)` calls `get_place_by_slug`, chooses the `is_hero=true` image, and maps nullable editorial copy safely. Intro fallback order is non-empty `short_description`, non-empty `short_story`, then `official_name`; nullable highlight/photo/couple/mission strings become empty strings, and `nearbySpots` is empty because that RPC does not return local recommendations.

- [x] **Step 4: Route only live slugs to Supabase**

Expose one typed `SpotRepositorySupabase` provider. `spotDetailProvider` keeps IDs beginning with `spot-` on `SpotRepositoryMock`, and routes every RPC slug to the Supabase repository. `nowGoodSpotsProvider` reuses the same Supabase repository instance.

- [x] **Step 5: Make sparse remote detail visually honest**

In `spot_detail_page.dart`, render Night Highlights, Photo Tip, and romantic cards only when their trimmed text is non-empty. If only one highlight field exists, render one full-width card without overflow. Do not synthesize editorial prose in Flutter.

- [x] **Step 6: Generate and verify GREEN**

Run build_runner, the two targeted tests, the full suite, changed-file analysis, and the exact format gate. Expected: all exit 0 with no new analyzer issues.

### Task 3: Runtime and visual QA

**Files:**
- No production file is expected unless runtime QA exposes a defect; any defect fix returns to a new RED→GREEN cycle.

**Interfaces:**
- Consumes: remote RPC and built Flutter app from Tasks 1–2.
- Produces: observed evidence that anonymous API calls and the home screen use live recommendations.

- [x] **Step 1: Verify the anonymous Data API contract**

Use the project URL and publishable key without printing the key, call `/rest/v1/rpc/get_now_good_spots`, and confirm HTTP 200, two rows, expected nine keys, and no raw/editorial fields.

- [x] **Step 2: Launch the configured app**

Run:

```bash
flutter run --dart-define-from-file=config/dev.json
```

Expected: app starts without mock image URLs or RPC permission errors.

- [x] **Step 3: Inspect the home screen**

On the real simulator, confirm “지금 가기 좋은 스팟” renders two remote cards with hero image, display name, recommendation reason, and crowd metadata; cards fit without overflow and tapping a card navigates using the RPC slug.

- [x] **Step 4: Reconcile documentation and final evidence**

## Completion Evidence — 2026-08-17

- Remote RPC returned 2 rows for no-location, in-range, and out-of-range calls; only the in-range call returned distances.
- RPC output contained 0 duplicate `place_id` values, and all KTO image URLs were HTTPS.
- `anon` and `authenticated` can execute the RPC; `PUBLIC` cannot.
- Targeted 4 tests and the full 27-test suite passed; `dart analyze` reported no new issue; iOS Simulator build succeeded.
- iPhone 16 Pro Simulator showed live `효원의 종·서장대` and `창룡문` cards. Opening `seojangdae` displayed the matching live detail, omitted empty editorial sections, and returned to home successfully.
- Two independent visual QA reviews passed the fresh home and detail captures with no blocking CJK or layout findings.

Re-read this plan and the two updated specs, verify the implemented signature and scoring rules match exactly, and report remote row samples, advisor results, automated test counts, build result, and manual UI observations without exposing secrets.
