import 'package:flutter/material.dart';

/// 카카오 공식 로그인 버튼.
///
/// 카카오 로그인 디자인 가이드
/// (https://developers.kakao.com/docs/latest/ko/kakaologin/design-guide)
/// 에서 제공하는 표준 리소스(완성형 "카카오 로그인", wide)를 그대로 사용한다.
///
/// 자산 밀도 매핑:
/// - `assets/kakao/kakao_login_medium_wide.png` (300 x 45 px, 1.0x)
/// - `assets/kakao/2.0x/kakao_login_medium_wide.png` (600 x 90 px, 2.0x)
///
/// 컨테이너 색상은 카카오가 지정한 `#FEE500` 을 사용한다.
/// 컨테이너 radius 는 자산 자체(12 px)와 동일하게 유지한다.
class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({
    super.key,
    required this.onPressed,
    this.height = 52,
    this.semanticLabel = '카카오 로그인',
  });

  /// 카카오 공식 컨테이너 색상.
  static const Color containerColor = Color(0xFFFEE500);

  /// 카카오 공식 컨테이너 radius (px).
  static const double containerRadius = 12;

  /// 카카오 공식 완성형 wide 버튼 자산의 종횡비 (300 : 45).
  static const double assetAspectRatio = 300 / 45;

  static const String _assetPath = 'assets/kakao/kakao_login_medium_wide.png';

  final VoidCallback? onPressed;
  final double height;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    // 카카오 가이드: 가로 확장 시 심볼/레이블 영역은 유지하고 컨테이너 좌·우로만
    // 확장한다. 이를 흉내내기 위해 컨테이너를 폭 전체로 그리고, 심볼+레이블이
    // 포함된 공식 자산은 자산 원본 비율을 유지한 채 가운데 정렬한다. 컨테이너와
    // 자산의 배경색이 모두 `#FEE500` 이므로 이음매가 보이지 않는다.
    return Semantics(
      button: true,
      label: semanticLabel,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Material(
          color: containerColor,
          borderRadius: BorderRadius.circular(containerRadius),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Image.asset(
                _assetPath,
                fit: BoxFit.fitHeight,
                height: height,
                excludeFromSemantics: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
