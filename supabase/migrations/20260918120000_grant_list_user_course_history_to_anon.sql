-- ================================================================
-- 20260918120000_grant_list_user_course_history_to_anon.sql
-- 마이페이지 비로그인 진입 시 무한 로딩 문제 수정
--
-- public.list_user_course_history(int)는 SECURITY DEFINER이며
-- auth.uid()가 NULL(anon)이면 빈 결과를 반환하도록 설계되어 있다
-- (20260831143356_add_course_progress_rpc.sql 참고).
-- 하지만 GRANT EXECUTE가 authenticated에게만 부여되어 있어,
-- 비로그인(anon) 사용자가 이 RPC를 호출하면 함수 본문이 실행되기도
-- 전에 PostgREST가 permission denied(42501)를 반환한다.
--
-- 마이페이지는 로그인 여부와 무관하게 항상 이 RPC를 호출하므로
-- (myPageSummaryProvider), 비로그인 사용자는 마이페이지 진입 시
-- 계속 에러가 반복되며 화면이 정상적으로 뜨지 않는다.
-- ================================================================

GRANT EXECUTE ON FUNCTION public.list_user_course_history(int) TO anon;
