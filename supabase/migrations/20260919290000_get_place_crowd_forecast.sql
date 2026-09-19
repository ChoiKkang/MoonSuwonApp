-- ================================================================
-- 20260919290000_get_place_crowd_forecast.sql
-- 장소의 "날짜별" 예측 혼잡도 시리즈를 반환하는 RPC.
--
-- 배경
--   core.place_crowd_forecasts는 (place_id, forecast_date) 단위의 "일별" 예측이다
--   (시간대/hour 없음, rate<40 여유·<70 보통·else 혼잡). get_place_by_slug의
--   crowd_forecast는 core.current_place_forecast로 "오늘(또는 가장 가까운 날)"
--   1건만 준다. 앱 스팟 상세에서 오늘/내일/… 여러 날의 예측을 보여주려면 날짜
--   시리즈가 필요하므로 전용 RPC를 둔다.
--
-- 계약
--   입력: p_place_id (core.places.id)
--   출력: (forecast_date, forecast_score, crowd_level, data_status) 행들.
--     • 오늘(Asia/Seoul) 이후 날짜만, 날짜 오름차순, 최대 7건.
--     • data_status: source_updated_at 기준 48h 이내면 'fresh', 아니면 'stale'.
--     • 과거만 있거나 데이터가 없으면 0행 → 앱은 섹션을 감춘다.
--
-- 안전성
--   core.place_crowd_forecasts는 RLS로 anon 접근이 막혀 있어 SECURITY DEFINER로
--   소유자(postgres) 권한으로 읽는다. published 장소만 노출(is_published_place).
--   p_place_id는 바인딩 파라미터로 비교만 하며 동적 SQL이 없어 주입 위험이 없다.
--   search_path는 pg_catalog로 고정하고 객체를 스키마 한정한다.
-- ================================================================

create or replace function public.get_place_crowd_forecast(p_place_id uuid)
returns table (
  forecast_date date,
  forecast_score numeric,
  crowd_level text,
  data_status text
)
language sql
stable
security definer
set search_path = pg_catalog
as $$
  select
    f.forecast_date,
    f.forecast_score,
    f.crowd_level,
    case
      when f.source_updated_at < pg_catalog.now() - pg_catalog.make_interval(hours => 48)
        then 'stale'
      else 'fresh'
    end as data_status
  from core.place_crowd_forecasts f
  where f.place_id = p_place_id
    and public.is_published_place(p_place_id)
    and f.forecast_date >= (pg_catalog.now() at time zone 'Asia/Seoul')::date
  order by f.forecast_date
  limit 7;
$$;

revoke all on function public.get_place_crowd_forecast(uuid) from public;
grant execute on function public.get_place_crowd_forecast(uuid) to anon, authenticated;
