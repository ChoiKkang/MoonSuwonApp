import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart' show MyPageSummary;

abstract class MyPageRepository {
  Future<MyPageSummary> fetchSummaryAsync();
}
