import 'dart:convert';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;
import 'package:url_launcher/url_launcher.dart'
    show LaunchMode, canLaunchUrl, launchUrl;

/// 앱 버전 조회 및 최신 버전 확인 결과.
class AppVersionInfo {
  const AppVersionInfo({
    required this.currentVersion,
    required this.currentBuildNumber,
    required this.packageName,
    required this.latestVersion,
  });

  /// 예: `1.0.0` (pubspec.yaml `version: 1.0.0+1`의 앞부분).
  final String currentVersion;

  /// 예: `1` (pubspec.yaml `version: 1.0.0+1`의 뒷부분).
  final String currentBuildNumber;

  /// 예: iOS `team.choikkang.moonsuwon`, Android `team.choikkang.moon_suwon`.
  final String packageName;

  /// 스토어 조회에 성공한 경우 최신 버전 문자열. 실패 시 `null`.
  final String? latestVersion;

  /// 최신 버전 정보가 있고 현재 버전보다 큰 경우 `true`.
  bool get hasUpgrade {
    final latest = latestVersion;
    if (latest == null || latest.trim().isEmpty) return false;
    return _compareSemver(currentVersion, latest) < 0;
  }
}

/// 앱 현재 버전을 표시하고, iTunes Lookup으로 최신 버전을 조회한 뒤
/// 필요 시 앱스토어(iOS) 또는 Play Store(Android)로 이동시킨다.
///
/// - Android는 Play Store에 공식 버전 조회 API가 없어 `latestVersion`은 `null`이 된다.
///   이 경우 `hasUpgrade`가 항상 `false`이므로, 사용자가 명시적으로 스토어를 열면
///   `openStoreAsync`가 Play Store 앱을 실행한다.
class AppVersionService {
  AppVersionService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// 현재 버전 + 최신 버전 확인 결과를 함께 반환한다.
  Future<AppVersionInfo> fetchAsync() async {
    final info = await PackageInfo.fromPlatform();
    final latest = await _fetchLatestVersionSafeAsync(info.packageName);
    return AppVersionInfo(
      currentVersion: info.version,
      currentBuildNumber: info.buildNumber,
      packageName: info.packageName,
      latestVersion: latest,
    );
  }

  /// 앱스토어(iOS) 또는 Play Store(Android) 페이지로 이동한다.
  Future<void> openStoreAsync(String packageName) async {
    final Uri url;
    if (Platform.isIOS) {
      url = Uri.parse('itms-apps://itunes.apple.com/app/$packageName');
    } else {
      url = Uri.parse('market://details?id=$packageName');
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return;
    }
    // fallback: 웹 URL
    final web = Platform.isIOS
        ? Uri.parse('https://apps.apple.com/app/$packageName')
        : Uri.parse('https://play.google.com/store/apps/details?id=$packageName');
    await launchUrl(web, mode: LaunchMode.externalApplication);
  }

  /// iTunes Lookup으로 iOS 최신 버전 문자열을 조회한다.
  /// - 네트워크 실패/미배포/파싱 실패 → `null` (조용히 실패)
  /// - Android는 공식 API가 없어 항상 `null`
  Future<String?> _fetchLatestVersionSafeAsync(String bundleId) async {
    if (!Platform.isIOS) return null;
    try {
      final uri = Uri.parse(
        'https://itunes.apple.com/lookup?bundleId=$bundleId',
      );
      final response = await _httpClient
          .get(uri)
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) return null;
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final results = (body['results'] as List<dynamic>?) ?? const [];
      if (results.isEmpty) return null;
      final first = Map<String, dynamic>.from(results.first as Map);
      return first['version'] as String?;
    } catch (_) {
      return null;
    }
  }
}

/// `1.2.3` 스타일 semver 비교. `a<b: -1`, `a==b: 0`, `a>b: 1`.
int _compareSemver(String a, String b) {
  final pa = a.split('.').map((s) => int.tryParse(s) ?? 0).toList();
  final pb = b.split('.').map((s) => int.tryParse(s) ?? 0).toList();
  final len = pa.length > pb.length ? pa.length : pb.length;
  for (var i = 0; i < len; i++) {
    final ai = i < pa.length ? pa[i] : 0;
    final bi = i < pb.length ? pb[i] : 0;
    if (ai != bi) return ai.compareTo(bi);
  }
  return 0;
}
