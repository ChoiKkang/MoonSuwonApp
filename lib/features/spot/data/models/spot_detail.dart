import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_detail.freezed.dart';
part 'spot_detail.g.dart';

@freezed
class LocalSpot with _$LocalSpot {
  const factory LocalSpot({
    required String id,
    required String name,
    required String type,
    required String summary,
    required String imageUrl,
    required int walkingMinutes,
    @Default(false) bool petFriendly,
  }) = _LocalSpot;

  factory LocalSpot.fromJson(Map<String, dynamic> json) =>
      _$LocalSpotFromJson(json);
}

@freezed
class SpotDetail with _$SpotDetail {
  const factory SpotDetail({
    required String id,
    required String name,
    required String category,
    required String intro,
    required String heroImageUrl,
    required double lat,
    required double lng,
    required String nightHighlight,
    required String photoTip,
    required String romanticMoment,
    required String missionPrompt,
    required int missionRadiusM,
    required List<LocalSpot> nearbySpots,
    @Default('partial') String petPolicy,
    @Default('') String petNote,
  }) = _SpotDetail;

  factory SpotDetail.fromJson(Map<String, dynamic> json) =>
      _$SpotDetailFromJson(json);
}
