import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot.freezed.dart';
part 'spot.g.dart';

enum SpotProgressStatus { pending, current, completed }

@freezed
abstract class Spot with _$Spot {
  const factory Spot({
    required String id,
    required String name,
    required String summary,
    required String imageUrl,
    required double lat,
    required double lng,
    required int missionRadiusM,
    required String missionPrompt,
    @Default(SpotProgressStatus.pending) SpotProgressStatus status,
    @Default('partial') String petPolicy,
    @Default('') String petNote,
  }) = _Spot;

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);
}
