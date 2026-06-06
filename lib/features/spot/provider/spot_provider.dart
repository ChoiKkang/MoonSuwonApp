import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/spot/data/spot_repository.dart' show SpotRepository;
import 'package:dalbit_suwon/features/spot/data/spot_repository_mock.dart' show SpotRepositoryMock;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart' show SpotDetail;

part 'spot_provider.g.dart';

@riverpod
SpotRepository spotRepository(Ref ref) => SpotRepositoryMock();

@riverpod
Future<SpotDetail> spotDetail(Ref ref, String spotId) =>
    ref.read(spotRepositoryProvider).fetchSpotDetailAsync(spotId);
