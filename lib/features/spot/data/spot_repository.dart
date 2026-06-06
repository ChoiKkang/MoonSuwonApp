import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart' show SpotDetail;

abstract class SpotRepository {
  Future<SpotDetail> fetchSpotDetailAsync(String spotId);
}
