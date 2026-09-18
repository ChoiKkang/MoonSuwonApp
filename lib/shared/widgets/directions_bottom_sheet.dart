import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'
    show LaunchMode, canLaunchUrl, launchUrl;

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;

/// 외부 지도 앱으로 길찾기를 여는 공통 유틸리티.
///
/// 카카오맵/네이버맵/구글맵 중 사용자가 선택한 앱으로 목적지 좌표를 전달한다.
/// 프로필 편집의 "사진 선택" 시트와 동일한 톤의 [showModalBottomSheet]를 사용해
/// 3개 옵션(카카오/네이버/구글)을 보여준다.
///
/// 각 옵션은 우선 앱 딥링크 스킴을 시도하고, 실패하면 웹 URL로 폴백한다.
class DirectionsBottomSheet {
  const DirectionsBottomSheet._();

  /// 길찾기 옵션 시트를 띄운다.
  ///
  /// - [destinationName]: 지도에서 표시할 목적지 이름
  /// - [lat], [lng]: 목적지 좌표 (WGS84)
  static Future<void> showAsync(
    BuildContext context, {
    required String destinationName,
    required double lat,
    required double lng,
  }) async {
    // 시트 dismiss 이후에 스낵바를 띄우기 위해 async gap 이전에 미리 캡처.
    final messenger = ScaffoldMessenger.maybeOf(context);
    final choice = await showModalBottomSheet<_DirectionsProvider>(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_outlined,
                    color: AppColors.moonlightGold,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '길찾기 앱 선택',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _DirectionsOptionTile(
              label: '카카오맵으로 길찾기',
              icon: Icons.pin_drop_outlined,
              iconColor: const Color(0xFFFEE500),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DirectionsProvider.kakao),
            ),
            _DirectionsOptionTile(
              label: '네이버맵으로 길찾기',
              icon: Icons.place_outlined,
              iconColor: const Color(0xFF03C75A),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DirectionsProvider.naver),
            ),
            _DirectionsOptionTile(
              label: '구글맵으로 길찾기',
              icon: Icons.map_outlined,
              iconColor: const Color(0xFF4285F4),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DirectionsProvider.google),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (choice == null) return;

    try {
      await _launchAsync(
        provider: choice,
        destinationName: destinationName,
        lat: lat,
        lng: lng,
      );
    } on Object catch (e) {
      messenger?.showSnackBar(
        SnackBar(content: Text('지도 앱을 열지 못했습니다: $e')),
      );
    }
  }

  /// 사용자가 선택한 지도 앱으로 길찾기 URL을 launch한다.
  ///
  /// 앱 딥링크 스킴 → 웹 URL 순으로 폴백한다. iOS/Android 어느 쪽이든
  /// 앱이 설치돼 있으면 앱이 열리고, 없으면 브라우저가 열려 웹지도로 진입한다.
  static Future<void> _launchAsync({
    required _DirectionsProvider provider,
    required String destinationName,
    required double lat,
    required double lng,
  }) async {
    final encodedName = Uri.encodeComponent(destinationName);
    final Uri appUri;
    final Uri webFallback;

    switch (provider) {
      case _DirectionsProvider.kakao:
        // 카카오맵: 목적지 좌표 look 링크. 앱이 있으면 앱, 없으면 웹.
        // 웹은 지도 링크로 폴백해 사용자가 별도로 길찾기 조작하도록 안내.
        appUri = Uri.parse('kakaomap://look?p=$lat,$lng');
        webFallback = Uri.parse(
          'https://map.kakao.com/link/map/$encodedName,$lat,$lng',
        );
      case _DirectionsProvider.naver:
        // 네이버맵 딥링크는 dlat/dlng/dname/appname을 요구한다.
        // appname은 앱 번들 식별자에 해당하며, 요구 값이 없어도 대부분 동작한다.
        appUri = Uri.parse(
          'nmap://route/walk?dlat=$lat&dlng=$lng&dname=$encodedName'
          '&appname=com.dalbit.suwon',
        );
        webFallback = Uri.parse(
          'https://map.naver.com/v5/directions/-/-/-/walk?'
          'c=15,0,0,0,dh&destination=$encodedName,$lat,$lng',
        );
      case _DirectionsProvider.google:
        // 구글맵은 URL Scheme이 iOS 전용(comgooglemaps://)이라 별도 처리 없이
        // 표준 URL을 사용한다. iOS/Android 모두 앱이 있으면 앱이 열린다.
        appUri = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng'
          '&destination_place_id=&travelmode=walking',
        );
        webFallback = appUri;
    }

    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri, mode: LaunchMode.externalApplication);
      return;
    }
    await launchUrl(webFallback, mode: LaunchMode.externalApplication);
  }
}

/// 길찾기 옵션 리스트 아이템. 프로필 편집의 "사진 선택" 시트와 동일한 톤.
class _DirectionsOptionTile extends StatelessWidget {
  const _DirectionsOptionTile({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(label, style: AppTextStyles.bodyMd),
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: AppColors.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}

enum _DirectionsProvider { kakao, naver, google }
