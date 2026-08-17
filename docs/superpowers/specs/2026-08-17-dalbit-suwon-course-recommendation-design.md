# 데이트 코스 추천 — Supabase RPC 및 Flutter 연동 설계

## 배경

`docs/superpowers/specs/2026-06-17-dalbit-suwon-db-schema.md`의 "미결 사항" 목록은 `get_course_detail` RPC 본문이 미작성 상태라고 기록하지만, 실제 `supabase/migrations/009_functions_rpc.sql`을 확인한 결과 `get_course_detail(p_course_id uuid)`와 `get_course_by_slug(p_slug text)`는 이미 완전한 SQL 본문으로 구현되어 있다 (스펙 문서가 최신 상태를 반영하지 못한 것). `serving.v_home_courses`, `serving.v_course_detail` 뷰도 `007_serving_views.sql`에 이미 존재한다.

실제로 비어 있는 부분은 다음 세 가지다.

1. **홈 코스 목록을 노출하는 RPC가 없다.** `serving.v_home_courses` 뷰는 존재하지만, 앱에서 호출 가능한 `public.*` RPC로 감싸져 있지 않다. `get_now_good_spots`가 `serving.v_now_good_spot_candidates`를 감싸는 것과 동일한 패턴이 코스 쪽에는 빠져 있다.
2. **코스 시드 데이터가 전혀 없다.** `core.courses`, `core.course_places`, `editorial.course_copy`, `editorial.course_publish_state`에 행이 하나도 없다 (전체 마이그레이션 grep으로 확인).
3. **Flutter가 여전히 Mock을 사용한다.** `course_provider.dart`는 `CourseRepositoryMock()`을 무조건 주입하며, `CourseRepositorySupabase`가 존재하지 않는다.

Flutter UI(`home_page.dart`의 코스 카드, `course_detail_page.dart`)는 Stitch 디자인과 이미 일치하며 Mock 데이터로 완성되어 있으므로, 이번 작업은 **백엔드 RPC 추가 + 시드 데이터 작성 + Repository 교체**에 집중한다. UI/Provider 시그니처는 변경하지 않는다.

## 범위

**포함:**
- `public.get_home_courses(p_limit integer DEFAULT 10)` RPC 신규 작성 (`serving.v_home_courses` 래핑)
- 코스 2~3개 시드 데이터 작성 (`core.courses` + `core.course_places` + `editorial.course_copy` + `editorial.course_publish_state.is_published = true`)
- `CourseRepositorySupabase` + 관련 DTO 구현 (`get_home_courses`, `get_course_detail` RPC 호출)
- `course_provider.dart` Repository 교체 (spot 기능과 동일한 이중 provider 패턴: mock id는 Mock, 실제 UUID는 Supabase)
- 단위 테스트 (DTO 파싱, Repository HTTP 경계 테스트)

**제외 (Out of scope):**
- `get_course_by_slug` (웹 SSR 전용) — 이미 구현되어 있고 이번 작업 대상 아님
- 코스 진행(`course_progress_page.dart`)·완료 화면 연동 — 이미 Mock 기반으로 동작 중이며 이번 스코프 아님
- `checkin_place` RPC — 이미 구현되어 있고 변경 불필요
- 반려동물 필터 등 MVP 제외 기능

## 아키텍처

### 1. `public.get_home_courses` RPC

`get_now_good_spots` 패턴을 그대로 따른다 (`supabase/migrations/20260817185031_add_now_good_spots_rpc.sql` 참고):

```sql
CREATE OR REPLACE FUNCTION public.get_home_courses(p_limit integer DEFAULT 10)
RETURNS TABLE (
  id                      uuid,
  slug                    text,
  theme_tags              text[],
  estimated_duration_min  int,
  walking_distance_km     numeric,
  recommended_start_time  text,
  pet_ready_flag          boolean,
  hero_title              text,
  subtitle                text,
  route_summary           text,
  spot_count              bigint,
  hero_image_url          text
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = ''
AS $function$
  SELECT
    id, slug, theme_tags, estimated_duration_min, walking_distance_km,
    recommended_start_time, pet_ready_flag, hero_title, subtitle, route_summary,
    spot_count, hero_image_url
  FROM serving.v_home_courses
  ORDER BY display_priority ASC
  LIMIT LEAST(50, GREATEST(1, COALESCE(p_limit, 10)));
$function$;
```

- `SECURITY INVOKER` + `SET search_path = ''`을 사용한다 (스키마 전체 fully-qualified 참조는 뷰 내부에 이미 있으므로 RPC 본문 자체는 단순 SELECT).
- 권한: `serving.v_home_courses`는 `007_serving_views.sql`의 `GRANT SELECT ON ALL TABLES IN SCHEMA serving TO anon, authenticated;`로 이미 접근 가능하다. `get_place_by_slug`/`get_course_detail` 등 기존 함수에 별도 `GRANT EXECUTE`가 없어도 PostgreSQL 기본 동작상 `PUBLIC`에 EXECUTE 권한이 부여되어 있음을 확인했으므로 (관련 `REVOKE`가 어떤 마이그레이션에도 없음), `get_home_courses`도 명시적 GRANT 없이 anon 호출이 가능하다. 다만 `get_now_good_spots`와 일관성을 위해 명시적으로 `GRANT EXECUTE ON FUNCTION public.get_home_courses(integer) TO anon, authenticated;`를 추가한다.

### 2. 시드 데이터

`core.places`에 이미 존재하고 `place_copy`가 채워진 7개 장소(`banghwasuryujeong`, `yeonmudae`, `janganmun`, `changnyongmun`, `hwaseong-haenggung`, `hwahongmun`, `seojangdae`)를 재사용해 코스 2개를 구성한다.

| 코스 | slug | 스팟 순서 | 예상 소요(분) | 도보 거리(km) | 추천 시작 시각 |
|---|---|---|---|---|---|
| 야경 사진 집중 코스 (Stitch 화면명과 일치) | `course-night-photo` | `janganmun` → `hwahongmun` → `banghwasuryujeong` | 90 | 2.0 | 19:00 |
| 성곽 야간 산책 코스 | `course-fortress-walk` | `hwaseong-haenggung` → `seojangdae` → `yeonmudae` | 100 | 2.4 | 19:30 |

`pet_ready_flag`는 `core.place_pet_policies`에서 코스에 포함된 스팟이 전부 `pet_policy != 'none'`인 경우에만 `true`로 설정한다 (구현 시 실제 테이블 값으로 확인). `theme_tags`는 각각 `{'photo', 'night-view'}`, `{'walk', 'heritage'}`로 둔다.

각 코스에 대해:
```sql
INSERT INTO core.courses (slug, theme_tags, estimated_duration_min, walking_distance_km, recommended_start_time, pet_ready_flag) VALUES (...);
INSERT INTO core.course_places (course_id, place_id, order_index) SELECT ...;
INSERT INTO editorial.course_copy (course_id, hero_title, subtitle, route_summary) VALUES (...);
UPDATE editorial.course_publish_state SET is_published = true, display_priority = ... WHERE course_id = ...;
```

`core.places`/`core.courses` INSERT 시 트리거로 `editorial.course_publish_state` 행이 자동 생성되므로, UPDATE만 하면 된다 (`006_editorial_tables.sql`의 트리거 참고).

### 3. `CourseDetail.description` 매핑

`editorial.course_copy`에는 별도 장문 description 컬럼이 없다. 새 컬럼을 추가하는 대신 기존 `route_summary`를 `CourseDetail.description`으로 매핑한다 — `route_summary`는 이미 "코스 경로 요약" 문구 용도로 설계되어 있어 상세 화면의 설명 문단 역할을 그대로 수행할 수 있다. 스키마 변경 없음.

### 4. Flutter 레이어

`lib/features/spot/data/spot_repository_supabase.dart`를 그대로 참고 패턴으로 삼는다.

**신규 파일:**
- `lib/features/course/data/models/home_course_dto.dart` — `get_home_courses` 응답 행 read DTO
- `lib/features/course/data/models/course_detail_dto.dart` — `get_course_detail` JSON 응답 read DTO (중첩 `places` 배열 포함)
- `lib/features/course/data/course_repository_supabase.dart` — `CourseRepository` 구현체

**수정 파일:**
- `lib/features/course/provider/course_provider.dart` — `spot_provider.dart`와 동일한 이중 provider 패턴 적용: `course-`로 시작하는 id는 `CourseRepositoryMock`, 그 외(UUID)는 `CourseRepositorySupabase`로 라우팅. `coursesProvider`(홈 목록)는 Supabase를 사용.
- `lib/features/course/data/course_repository_mock.dart` — 기존 Mock 데이터는 유지 (제거하지 않음, 상세 페이지 등에서 계속 참조될 수 있음)

`CourseSummary`/`CourseDetail`/`Spot` freezed 모델은 필드 변경 없이 그대로 사용한다.

## 기존 RPC 재사용 검토

새 RPC를 추가하기 전에 기존 자산으로 대체 가능한지 점검했다.

| 필요 기능 | 기존 자산으로 충족 가능? | 결론 |
|---|---|---|
| 코스 상세 조회 (id 기반) | `public.get_course_detail(uuid)` — 이미 완전히 구현됨 | **그대로 재사용**. 신규 작성 없음. `CourseRepositorySupabase.fetchCourseDetailAsync`는 이 RPC만 호출한다. |
| 코스 상세 조회 (slug 기반, 웹 SSR) | `public.get_course_by_slug(text)` — 이미 완전히 구현됨 | 이번 스코프에서 사용하지 않지만 손댈 필요 없음 |
| 홈 코스 목록 조회 | 없음 — `get_course_detail`/`get_course_by_slug`는 단건 전용이라 목록에 재사용 불가, `get_now_good_spots`는 스팟 도메인이라 무관 | **신규 함수 1개 필요** (`get_home_courses`). 단, 그 안에서 참조하는 `serving.v_home_courses` 뷰는 `007_serving_views.sql`에 이미 존재하므로 뷰는 재사용하고 얇은 래퍼 함수만 추가한다 |
| `serving` 스키마 접근 권한 | `GRANT USAGE ON SCHEMA serving`, `GRANT SELECT ON ALL TABLES IN SCHEMA serving TO anon, authenticated` — `007_serving_views.sql`에 이미 존재 | **재사용**. `get_home_courses`를 위한 별도 스키마/뷰 권한 부여 불필요. 함수 자체에 대한 `GRANT EXECUTE`만 추가 |
| RPC 반환 형태 | `get_course_detail`은 중첩 배열(스팟 목록)이 필요해 `json`/`json_build_object`를 쓴다. 홈 목록은 평평한 행 구조(스칼라 컬럼만)라 이 패턴이 맞지 않는다 | `get_now_good_spots`와 동일하게 `RETURNS TABLE` + `SECURITY INVOKER` + `SET search_path=''` 패턴을 재사용한다. 두 반환 패턴은 대체재가 아니라 각각 단건/목록이라는 다른 요구사항에 이미 맞게 나뉘어 있다 |

결과적으로 이번 마이그레이션에서 **완전히 새로 작성하는 것은 `get_home_courses` 함수 본문과 시드 데이터뿐**이며, 뷰·권한·상세 조회 RPC·보안 패턴은 모두 기존 자산을 재사용한다.

## 에러 처리

- `get_home_courses`가 빈 배열을 반환하면 (발행된 코스 없음) `home_page.dart`의 기존 `coursesAsync.when` 패턴이 이미 `error`/`data` 분기를 처리하므로 별도 방어 코드는 불필요하다. 다만 빈 리스트일 때 `_CourseCardList`가 빈 화면을 렌더링하지 않도록 now-good-spot 섹션과 동일하게 "추천 코스가 없어요" 안내를 추가한다.
- `get_course_detail`이 `NULL`을 반환하는 경우(존재하지 않는 id) — `CourseRepositorySupabase.fetchCourseDetailAsync`에서 `row == null`이면 예외를 던져 상위 `AsyncValue.error`로 처리되게 한다 (spot 레포지토리와 동일하게 별도 커스텀 예외 없이 자연 발생 예외를 사용).

## 테스트 전략

`docs/superpowers/plans/2026-08-17-now-good-spots-rpc-flutter.md`의 TDD 패턴을 그대로 따른다.

1. DTO 단위 테스트: 독립적인 JSON fixture로 `HomeCourseDto.fromJson`, `CourseDetailDto.fromJson` 파싱 검증
2. Repository 경계 테스트: 테스트용 `SupabaseClient` HTTP 클라이언트로 `/rest/v1/rpc/get_home_courses`, `/rest/v1/rpc/get_course_detail` 요청 경로와 응답 매핑 검증
3. RED 상태 확인 → 구현 → GREEN 확인 → `flutter analyze`/`flutter test` 전체 통과

## Worktree

이번 작업은 별도 git worktree에서 진행한다. 현재 `feature/spot-page` 브랜치에는 관련 없는 커밋되지 않은 스팟 페이지 작업이 있으므로, 새 브랜치(`feature/course-recommendation` 등)를 별도 worktree 경로에 생성해 두 작업이 서로 섞이지 않도록 한다. 설계 승인 후, 구현 계획(writing-plans) 단계 진입 시점에 worktree를 생성한다.
