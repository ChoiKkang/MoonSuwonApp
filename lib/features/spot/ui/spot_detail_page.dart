import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;
import 'package:dalbit_suwon/features/spot/data/models/spot_detail.dart' show SpotDetail, LocalSpot;
import 'package:dalbit_suwon/features/spot/provider/spot_provider.dart' show spotDetailProvider;
import 'package:dalbit_suwon/shared/widgets/glass_icon_button.dart' show GlassIconButton;
import 'package:dalbit_suwon/shared/widgets/hero_image_header.dart' show HeroImageHeader;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart' show MoonlightCtaBar;

class SpotDetailPage extends ConsumerWidget {
  const SpotDetailPage({super.key, required this.spotId});
  final String spotId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(spotDetailProvider(spotId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.moonlightGold),
        ),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (detail) => _SpotDetailContent(detail: detail),
      ),
    );
  }
}

class _SpotDetailContent extends StatelessWidget {
  const _SpotDetailContent({required this.detail});
  final SpotDetail detail;

  Future<void> _openKakaoMap(SpotDetail detail) async {
    final uri = Uri.parse(
      'kakaomap://look?p=${detail.lat},${detail.lng}',
    );
    final fallback = Uri.parse(
      'https://map.kakao.com/link/map/${Uri.encodeComponent(detail.name)},${detail.lat},${detail.lng}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(fallback, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  HeroImageHeader(imageUrl: detail.heroImageUrl, height: 400),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlassIconButton(
                          icon: Icons.arrow_back,
                          onPressed: () => context.pop(),
                        ),
                        GlassIconButton(
                          icon: Icons.favorite_outline,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top, 20, 120),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _SpotHeader(detail: detail),
                  const SizedBox(height: 24),
                  _SpotHighlightGrid(detail: detail),
                  const SizedBox(height: 16),
                  _RomanticCard(text: detail.romanticMoment),
                  const SizedBox(height: 32),
                  if (detail.nearbySpots.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.explore_outlined,
                            size: 18, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 8),
                        Text('주변 추천 스팟', style: AppTextStyles.headlineMd),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _NearbySpotList(spots: detail.nearbySpots),
                  ],
                ]),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: MoonlightCtaBar(
            label: '카카오맵으로 길찾기',
            icon: Icons.map_outlined,
            onPressed: () => _openKakaoMap(detail),
          ),
        ),
      ],
    );
  }
}

class _SpotHeader extends StatelessWidget {
  const _SpotHeader({required this.detail});
  final SpotDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 14, color: AppColors.softAmber),
              const SizedBox(width: 6),
              Text('수원 화성',
                  style: AppTextStyles.labelSm
                      .copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(detail.name, style: AppTextStyles.headlineLg),
        const SizedBox(height: 8),
        Text(
          detail.intro,
          style:
              AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _SpotHighlightGrid extends StatelessWidget {
  const _SpotHighlightGrid({required this.detail});
  final SpotDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HighlightCard(
          icon: Icons.wb_twilight,
          iconColor: AppColors.moonlightGold,
          title: 'Night Highlights',
          body: detail.nightHighlight,
        ),
        const SizedBox(height: 12),
        _HighlightCard(
          icon: Icons.photo_camera_outlined,
          iconColor: AppColors.primary,
          title: 'Photo Tip',
          body: detail.photoTip,
        ),
      ],
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 10),
              Text(title,
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 10),
          Text(body,
              style: AppTextStyles.bodyMd
                  .copyWith(color: AppColors.onSurface)),
        ],
      ),
    );
  }
}

class _RomanticCard extends StatelessWidget {
  const _RomanticCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.softAmber.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.softAmber,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.softAmber.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite,
                          color: AppColors.softAmber, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Text('낭만적인 순간',
                        style: AppTextStyles.headlineMd.copyWith(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(text,
                    style: AppTextStyles.bodyMd
                        .copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NearbySpotList extends StatelessWidget {
  const _NearbySpotList({required this.spots});
  final List<LocalSpot> spots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 172,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: spots.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _NearbySpotCard(spot: spots[index]),
      ),
    );
  }
}

class _NearbySpotCard extends StatelessWidget {
  const _NearbySpotCard({required this.spot});
  final LocalSpot spot;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              spot.imageUrl,
              height: 96,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 96,
                color: AppColors.surfaceContainerHigh,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot.type.toUpperCase(),
                  style: AppTextStyles.labelSm.copyWith(
                    color: spot.type == 'cafe'
                        ? AppColors.softAmber
                        : AppColors.primary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  spot.name,
                  style: AppTextStyles.bodyMd,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
