class NowGoodSpotsQueryDto {
  const NowGoodSpotsQueryDto({this.lat, this.lng, this.limit = 2});

  final double? lat;
  final double? lng;
  final int limit;

  Map<String, dynamic> toJson() => {
    'p_lat': lat,
    'p_lng': lng,
    'p_limit': limit,
  };
}
