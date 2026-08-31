import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' show MapController;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' show LatLng;

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_search_origin.dart'
    show NearbySearchOrigin;
import 'package:dalbit_suwon/features/nearby/provider/nearby_provider.dart'
    show
        nearbyFiltersControllerProvider,
        nearbyPlacesProvider,
        nearbySearchOriginProvider;
import 'package:dalbit_suwon/features/nearby/ui/widgets/nearby_active_filters_row.dart'
    show NearbyActiveFiltersRow;
import 'package:dalbit_suwon/features/nearby/ui/widgets/nearby_filter_sheet.dart'
    show NearbyFilterSheet;
import 'package:dalbit_suwon/features/nearby/ui/widgets/nearby_map_view.dart'
    show NearbyMapView;
import 'package:dalbit_suwon/features/nearby/ui/widgets/nearby_place_card.dart'
    show NearbyPlaceCard;
import 'package:dalbit_suwon/shared/widgets/app_bottom_nav.dart'
    show AppBottomNav, AppBottomNavTab;

/// '내 주변' 탭 메인 페이지.
///
/// 화면 상단 40%는 지도, 하단은 스팟 리스트로 구성한다. 리스트와 마커가
/// 서로 연동되어 어느 쪽을 탭해도 다른 쪽이 강조된다. 카드를 다시 탭하면
/// 해당 스팟 상세로 이동한다.
class NearbyPage extends ConsumerStatefulWidget {
  const NearbyPage({super.key});

  @override
  ConsumerState<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends ConsumerState<NearbyPage> {
  String? _selectedPlaceId;
  final ScrollController _listScrollController = ScrollController();
  final Map<String, GlobalKey> _cardKeys = {};
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _listScrollController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _handleMarkerTap(NearbyPlace place) {
    setState(() => _selectedPlaceId = place.id);
    // 카드 위치로 스크롤
    final key = _cardKeys[place.id];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        alignment: 0.1,
      );
    }
  }

  void _handleCardTap(NearbyPlace place) {
    if (_selectedPlaceId == place.id) {
      // 두 번 탭 → 스팟 상세로 이동.
      context.push('/spot/${place.slug}');
      return;
    }
    setState(() => _selectedPlaceId = place.id);
  }

  /// 지도 목록 refresh용. 원점 provider를 다시 계산하고, 결과 좌표로 카메라를
  /// 명시적으로 이동한다. 좌표가 그대로여도 카메라는 무조건 원점으로 리센터링해
  /// "내 위치로 이동" UX가 항상 동작하게 만든다.
  Future<void> _handleRecenter() async {
    // 선택 해제해서 카드 하이라이트도 초기화 → 사용자가 자기 위치를 인지하기 쉽도록.
    setState(() => _selectedPlaceId = null);

    ref.invalidate(nearbySearchOriginProvider);
    final origin = await ref.read(nearbySearchOriginProvider.future);
    if (!mounted) return;

    _mapController.move(LatLng(origin.lat, origin.lng), 15);

    if (origin.isFallback) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치 권한이 없어 수원화성 기준으로 보여드려요.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final originAsync = ref.watch(nearbySearchOriginProvider);
    final placesAsync = ref.watch(nearbyPlacesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('내 주변', style: AppTextStyles.headlineMd),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: '내 위치로 이동',
            icon: const Icon(Icons.my_location, color: AppColors.onSurface),
            onPressed: _handleRecenter,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: originAsync.when(
          loading: () => const _LoadingView(),
          error: (error, _) => _ErrorView(
            message: '위치를 확인하지 못했어요',
            detail: '$error',
            onRetry: _handleRecenter,
          ),
          data: (origin) => _NearbyBody(
            mapController: _mapController,
            origin: origin,
            placesAsync: placesAsync,
            selectedPlaceId: _selectedPlaceId,
            listScrollController: _listScrollController,
            cardKeys: _cardKeys,
            onMarkerTap: _handleMarkerTap,
            onCardTap: _handleCardTap,
            onRefresh: _handleRecenter,
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(
        currentTab: AppBottomNavTab.nearby,
      ),
    );
  }
}

class _NearbyBody extends StatelessWidget {
  const _NearbyBody({
    required this.mapController,
    required this.origin,
    required this.placesAsync,
    required this.selectedPlaceId,
    required this.listScrollController,
    required this.cardKeys,
    required this.onMarkerTap,
    required this.onCardTap,
    required this.onRefresh,
  });

  final MapController mapController;
  final NearbySearchOrigin origin;
  final AsyncValue<List<NearbyPlace>> placesAsync;
  final String? selectedPlaceId;
  final ScrollController listScrollController;
  final Map<String, GlobalKey> cardKeys;
  final ValueChanged<NearbyPlace> onMarkerTap;
  final ValueChanged<NearbyPlace> onCardTap;
  final Future<void> Function() onRefresh;

  // 바텀시트 3단계 스냅 지점.
  //  - tip: 15% (지도가 거의 다 보이는 상태. 상단 핸들과 정렬 헤더 정도만 노출)
  //  - middle: 50% (지도와 리스트 반반)
  //  - top: 92% (리스트가 화면을 거의 다 차지, 상단 앱바 여백만 노출)
  static const double _snapTip = 0.15;
  static const double _snapMiddle = 0.5;
  static const double _snapTop = 0.92;

  @override
  Widget build(BuildContext context) {
    // 지도는 배경으로 화면 전체를 채우고, 리스트는 위에서 오버레이 되는
    // DraggableScrollableSheet으로 얹어 3단계 높이 조절이 가능하게 한다.
    return Stack(
      children: [
        Positioned.fill(
          child: NearbyMapView(
            mapController: mapController,
            originLat: origin.lat,
            originLng: origin.lng,
            isOriginFallback: origin.isFallback,
            places: placesAsync.maybeWhen(
              data: (list) => list,
              orElse: () => const <NearbyPlace>[],
            ),
            selectedPlaceId: selectedPlaceId,
            onMarkerTap: onMarkerTap,
          ),
        ),
        if (origin.isFallback)
          const Positioned(
            left: 16,
            right: 16,
            top: 12,
            child: _FallbackBanner(),
          ),
        DraggableScrollableSheet(
          initialChildSize: _snapMiddle,
          minChildSize: _snapTip,
          maxChildSize: _snapTop,
          snap: true,
          snapSizes: const [_snapTip, _snapMiddle, _snapTop],
          builder: (context, sheetScrollController) {
            return _NearbySheet(
              placesAsync: placesAsync,
              selectedPlaceId: selectedPlaceId,
              // 시트 내부 스크롤은 DraggableScrollableSheet가 넘겨준 컨트롤러를
              // 반드시 사용해야 위/아래 드래그가 시트 높이 조절과 연동된다.
              // 기존 listScrollController(카드 위치 스크롤용)는 카드 GlobalKey
              // 기반 ensureVisible로 대체된다.
              scrollController: sheetScrollController,
              cardKeys: cardKeys,
              onCardTap: onCardTap,
              onRefresh: onRefresh,
            );
          },
        ),
      ],
    );
  }
}

/// DraggableScrollableSheet 내부에 표시되는 리스트/헤더 시트 콘텐츠.
///
/// 시트 최상단 grabbar → 정렬/필터 헤더 → 활성 필터 칩 → 실제 스팟 리스트
/// 순서로 배치되며, 모두 [scrollController]에 바인딩된 [CustomScrollView] 내부에
/// 놓여 드래그 제스처가 시트 높이 조절로 자연스럽게 이어진다.
class _NearbySheet extends StatelessWidget {
  const _NearbySheet({
    required this.placesAsync,
    required this.selectedPlaceId,
    required this.scrollController,
    required this.cardKeys,
    required this.onCardTap,
    required this.onRefresh,
  });

  final AsyncValue<List<NearbyPlace>> placesAsync;
  final String? selectedPlaceId;
  final ScrollController scrollController;
  final Map<String, GlobalKey> cardKeys;
  final ValueChanged<NearbyPlace> onCardTap;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: AppColors.glassBorder, width: 1),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ListHeader(placesAsync: placesAsync),
                  const SizedBox(height: 8),
                  const NearbyActiveFiltersRow(),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            _NearbySheetBody(
              placesAsync: placesAsync,
              selectedPlaceId: selectedPlaceId,
              cardKeys: cardKeys,
              onCardTap: onCardTap,
              onRefresh: onRefresh,
            ),
          ],
        ),
      ),
    );
  }
}

/// 리스트 본문. `placesAsync` 상태에 따라 로딩/에러/빈 상태/데이터 슬리버로 분기.
class _NearbySheetBody extends StatelessWidget {
  const _NearbySheetBody({
    required this.placesAsync,
    required this.selectedPlaceId,
    required this.cardKeys,
    required this.onCardTap,
    required this.onRefresh,
  });

  final AsyncValue<List<NearbyPlace>> placesAsync;
  final String? selectedPlaceId;
  final Map<String, GlobalKey> cardKeys;
  final ValueChanged<NearbyPlace> onCardTap;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return placesAsync.when(
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: _LoadingView(),
      ),
      error: (error, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: _ErrorView(
          message: '스팟을 불러오지 못했어요',
          detail: '$error',
          onRetry: onRefresh,
        ),
      ),
      data: (places) {
        if (places.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyView(),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          sliver: SliverList.separated(
            itemCount: places.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final place = places[index];
              final key = cardKeys.putIfAbsent(place.id, () => GlobalKey());
              return KeyedSubtree(
                key: key,
                child: NearbyPlaceCard(
                  place: place,
                  isSelected: place.id == selectedPlaceId,
                  onTap: () => onCardTap(place),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ListHeader extends ConsumerWidget {
  const _ListHeader({required this.placesAsync});
  final AsyncValue<List<NearbyPlace>> placesAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(nearbyFiltersControllerProvider);
    final count = placesAsync.maybeWhen(
      data: (list) => list.length,
      orElse: () => null,
    );
    final label = count == null
        ? filters.sortBy.label
        : '${filters.sortBy.label} · $count곳';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurface),
          ),
          const Spacer(),
          Semantics(
            button: true,
            label: '필터 열기',
            child: InkWell(
              onTap: () => NearbyFilterSheet.show(context),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.tune,
                      size: 16,
                      color: filters.isDefault
                          ? AppColors.onSurfaceVariant
                          : AppColors.moonlightGold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '필터',
                      style: AppTextStyles.labelMd.copyWith(
                        color: filters.isDefault
                            ? AppColors.onSurfaceVariant
                            : AppColors.moonlightGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FallbackBanner extends StatelessWidget {
  const _FallbackBanner();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              size: 18,
              color: AppColors.moonlightGold,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '위치 권한이 없어 수원화성 기준으로 보여드려요.',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.moonlightGold),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.detail,
    required this.onRetry,
  });
  final String message;
  final String detail;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: AppTextStyles.bodyMd),
            const SizedBox(height: 8),
            Text(
              detail,
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: const Text('다시 시도')),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.explore_off_outlined,
              size: 42,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              '주변에 아직 등록된 스팟이 없어요',
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '수원화성 성곽 안쪽으로 이동하면 더 많은 스팟이 보여요.',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
