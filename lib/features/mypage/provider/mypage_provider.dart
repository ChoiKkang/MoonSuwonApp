import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:dalbit_suwon/features/mypage/data/mypage_repository.dart' show MyPageRepository;
import 'package:dalbit_suwon/features/mypage/data/mypage_repository_mock.dart' show MyPageRepositoryMock;
import 'package:dalbit_suwon/features/mypage/data/models/mypage_summary.dart' show MyPageSummary;

part 'mypage_provider.g.dart';

@riverpod
MyPageRepository myPageRepository(Ref ref) => MyPageRepositoryMock();

@riverpod
Future<MyPageSummary> myPageSummary(Ref ref) =>
    ref.read(myPageRepositoryProvider).fetchSummaryAsync();
