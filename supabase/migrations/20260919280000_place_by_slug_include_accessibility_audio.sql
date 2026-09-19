-- ================================================================
-- 20260919280000_place_by_slug_include_accessibility_audio.sql
-- get_place_by_slug RPC가 무장애(접근성)와 오디오 해설까지 한 번에 반환하도록 확장.
--
-- 배경
--   웹은 v_published_places / v_published_place_audio_stories 뷰를 직접 읽어
--   접근성·오디오를 보여주지만, 모바일 앱이 쓰는 get_place_by_slug RPC는 이 값을
--   반환하지 않아 앱에서만 두 섹션이 항상 비어(숨김) 보였다. 스팟 상세에 필요한
--   데이터를 RPC 한 번으로 받도록 access_* 필드와 audio_stories 배열을 추가한다.
--
-- 기준/안전성
--   • 배포본(20260919110000_normalize_hangul_slugs.sql)의 get_place_by_slug 본문을
--     그대로 유지하고(코어/에디토리얼/pet/crowd/images/slug 매칭 로직 보존)
--     access_*와 audio_stories만 덧붙인다.
--   • 함수는 SECURITY DEFINER(소유자 postgres)라 RLS가 걸린
--     core.place_accessibility / core.place_audio_stories를 읽을 수 있다.
--   • 반환 shape 변화는 "키 추가"뿐이라 기존 클라이언트(웹 SSR/구버전 앱)는
--     추가 키를 무시하므로 영향 없음. 컬럼 순서 계약(평면 뷰)과 무관하다.
--   • 오디오는 장소당 여러 건이라 json 배열(audio_stories)로 중첩한다.
--
-- 적용
--   이 DB는 웹 저장소 마이그레이션이 소유(source of truth)한다. 이 파일은
--   순수 CREATE OR REPLACE라 Supabase SQL Editor에서 단독 실행하거나, DB를
--   관리하는 저장소의 마이그레이션 흐름에 추가해 적용할 수 있다. 참조하는
--   core.place_accessibility / core.place_audio_stories 는 원격에 이미 존재한다.
-- ================================================================

create or replace function public.get_place_by_slug(p_slug text)
 RETURNS json
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $$
declare
  v_result json;
begin
  select pg_catalog.json_build_object(
    'id', p.id,
    'slug', p.slug,
    'official_name', p.official_name,
    'address_full', p.address_full,
    'lat', p.lat,
    'lng', p.lng,
    'contact_phone', p.contact_phone,
    'short_description', p.short_description,
    'recommended_stay_min', p.recommended_stay_min,
    'category', p.category,
    'display_name', coalesce(pc.display_name, p.official_name),
    'mission_radius_m', coalesce(pc.mission_radius_m, 80),
    'night_highlight', pc.night_highlight,
    'photo_tip', pc.photo_tip,
    'mission_type', pc.mission_type,
    'mission_prompt', pc.mission_prompt,
    'couple_question', pc.couple_question,
    'short_story', pc.short_story,
    'og_title', coalesce(pc.og_title, pc.display_name, p.official_name),
    'og_description', pc.og_description,
    'og_image_url', pc.og_image_url,
    'pet_policy', coalesce(ppp.pet_policy, 'unknown'),
    'pet_note', coalesce(ppp.pet_note_short, ppp.pet_note_raw),
    'pet_data_status', coalesce(ppp.data_status, 'unknown'),
    'pet_source_updated_at', ppp.source_updated_at,
    'crowd_forecast', (
      select pg_catalog.json_build_object(
        'forecast_date', f.forecast_date,
        'rate', f.forecast_score,
        'level', f.crowd_level
      )
      from core.current_place_forecast(p.id) f
    ),
    'crowd_data_status', (
      select case
        when f.id is null then 'unknown'
        when f.source_updated_at < pg_catalog.now() - pg_catalog.make_interval(hours => 48) then 'stale'
        else 'fresh'
      end
      from core.current_place_forecast(p.id) f
    ),
    -- 무장애(접근성) — core.place_accessibility. v_published_places와 동일 매핑.
    -- 값이 없는 항목은 null이며, 앱은 값이 있는 항목만 표시한다.
    'access_route', pa.route_note,
    'access_exit', pa.exit_note,
    'access_elevator', pa.elevator_note,
    'access_parking', pa.parking_note,
    'access_public_transport', pa.public_transport_note,
    'access_wheelchair', pa.wheelchair_note,
    'access_braille_block', pa.braille_block_note,
    'access_braille_promotion', pa.braille_promotion_note,
    'access_audio_guide', pa.audio_guide_note,
    'access_big_print', pa.big_print_note,
    'access_help_dog', pa.help_dog_note,
    'access_restroom', pa.restroom_note,
    'access_lactation_room', pa.lactation_room_note,
    'access_stroller', pa.stroller_note,
    'access_infants_family', pa.infants_family_note,
    'access_etc', pa.etc_note,
    'access_source_updated_at', pa.source_updated_at,
    'images', (
      select pg_catalog.json_agg(
        pg_catalog.json_build_object(
          'id', pi.id,
          'image_url', pi.image_url,
          'is_hero', pi.is_hero,
          'display_order', pi.display_order
        ) order by pi.display_order
      )
      from core.place_images pi
      where pi.place_id = p.id
    ),
    -- 오디오 해설 — core.place_audio_stories. 가까운 순(distance_m).
    'audio_stories', (
      select pg_catalog.json_agg(
        pg_catalog.json_build_object(
          'story_lang_id', pas.story_lang_id,
          'spot_title', pas.spot_title,
          'audio_title', pas.audio_title,
          'script', pas.script,
          'play_seconds', pas.play_seconds,
          'audio_url', pas.audio_url,
          'distance_m', pas.distance_m
        ) order by pas.distance_m nulls last, pas.audio_title
      )
      from core.place_audio_stories pas
      where pas.place_id = p.id
    )
  )
  into v_result
  from core.places p
  join editorial.place_publish_state pps on pps.place_id = p.id and pps.is_published = true
  left join editorial.place_copy pc on pc.place_id = p.id
  left join core.place_pet_policies ppp on ppp.place_id = p.id
  left join core.place_accessibility pa on pa.place_id = p.id
  where (
      p.slug = p_slug
      or normalize(p.slug, nfc) = normalize(p_slug, nfc)
      or p.id::text = p_slug
    )
    and p.is_active = true
  limit 1;

  return v_result;
end;
$$
;

grant execute on function public.get_place_by_slug(text) to anon, authenticated;
