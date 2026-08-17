import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart'
    show SpotDetail;
import 'package:dalbit_suwon/features/spot/data/models/spot_summary.dart'
    show SpotSummary;

abstract class SpotRepository {
  Future<SpotDetail> fetchSpotDetailAsync(String spotId);
}

abstract class NowGoodSpotsRepository {
  Future<List<SpotSummary>> fetchNowGoodSpotsAsync();
}
