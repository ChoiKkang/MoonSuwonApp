# 달빛수원 (Dalbit Suwon) — GEMINI.md

이 파일은 Gemini CLI가 이 프로젝트에서 코드를 작성할 때 반드시 따라야 하는 아키텍처와 코딩 스타일 가이드입니다.

---

## 프로젝트 개요

- 앱명: 달빛수원 (Dalbit Suwon)
- 설명: 수원화성 야간 데이트 코스 앱 (앱 퍼스트, 비회원 우선)
- 단계: UI/UX 우선 구현 → 이후 Supabase 기능 연동

---

## 아키텍처

**Feature-first + Repository Pattern + Riverpod (옵션 A)**

- Data + Provider + UI 2레이어 구조 (UseCase 레이어 없음)
- Repository 추상 인터페이스를 정의하고 Mock 구현체로 시작
- 기능 추가 시 Supabase 구현체로 교체만 하면 됨 (UI/Provider 변경 없음)

```
features/home/
├── data/
│   ├── home_repository.dart         # abstract interface
│   ├── home_repository_mock.dart    # Mock 구현체 (현재)
│   └── models/                      # Freezed 모델
├── provider/
│   └── home_provider.dart           # Riverpod Provider
└── ui/
    ├── home_page.dart
    └── widgets/
```

---

## 코딩 스타일 가이드

참고: https://github.com/crossplatformkorea/style-guide/blob/main/docs/ko/FLUTTER.md

### 네이밍 규칙

| 대상 | 규칙 | 예시 |
|------|------|------|
| 파일 | `lower_snake_case.dart` | `course_detail_page.dart` |
| 클래스 | `PascalCase` | `CourseDetailPage` |
| 변수/함수 | `camelCase` | `selectedCourse` |
| 상수 | `camelCase` | `defaultRadius` |
| 에셋 파일 | `lower_snake_case.png` | `spot_banner.png` |

### Prefix / Suffix 규칙

- **파일 도메인 prefix**: 도메인명을 앞에 붙임
  - O: `course_add.dart`, `spot_detail_page.dart`
  - X: `add_course.dart`, `detail_spot_page.dart`

- **함수 도메인 suffix**: 동사 먼저, 도메인은 뒤에
  - O: `onAddCourse()`, `onDeleteSpot()`
  - X: `onCourseAdd()`, `onSpotDelete()`

- **Boolean prefix**: 상황에 맞게 사용, 명확하면 생략 가능
  - `is`: 상태 (예: `isLoading`, `isCompleted`)
  - `has`: 존재 여부 (예: `hasFavorite`)
  - `should`: 조건 (예: `shouldShowLogin`)
  - 접두사 없이도 명확한 경우: `loading`, `disabled`, `checked`

- **Async suffix**: Future 반환 함수에 `Async` 붙임
  - O: `fetchCoursesAsync()`, `getSpotDetailAsync()`
  - X: `fetchCourses()` (비동기인데 suffix 없음)

### Import 규칙

외부 패키지는 그대로, 현재 앱 패키지는 반드시 `show` 활용:

```dart
// 외부 패키지 — show 없이
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 현재 앱 패키지 — show 필수
import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/shared/widgets/moonlight_cta_button.dart' show MoonlightCtaButton;
import 'package:dalbit_suwon/features/course/data/models/course.dart' show Course;
```

### 비동기 처리 규칙

- async 호출 이후 반드시 `context.mounted` 확인:
```dart
await someFunctionAsync();
if (context.mounted) {
  setState(() { ... });
}
```

- UI 렌더링 시점에서 future 데이터 필요 시 `FutureBuilder` 사용 (최상위 위젯 제외)
- `StreamBuilder`는 사용 금지 (익숙하지 않은 경우)

### 위젯 파일 규칙

- 스크린/재사용 위젯은 파일 하나에 클래스 하나
- 단, 보조 UI 위젯(레이아웃 전용)은 같은 파일 내 허용

---

### 커밋 컨벤션
> 모든 커밋에는 '[접두어]: 개발한 내용' 형식으로 진행한다
> 개발한 내용은 제 3자가 알아 볼 수 있도록 요약하여 적되 내용이 많은 경우 본문에 추가 기재한다
> 커밋은 개발한 내용에 맞는 내용만 커밋을 진행한다. 
>> ex. 디자인 수정 커밋에 실제 비즈니스 로직을 추가한 경우

- feat: 새로운 기능을 추가
- fix: 버그 수정
- desgin: 디자인 UI/UX만 수정한 경우
- hotfix: 긴급 배포 건으로 수정한 경우 { 이 접두어는 반드시 /hofix 브랜치일 경우에만 사용 해야한다 }
- refactor: 기능 리팩토링 {기능은 동일하나 구조를 변경한 경우 }
- chore: 빌드 업무 수정, 패키지 매니저 수정, 패키지 관리자 구성 등 업데이트, Production Code 변경 없음
- test: 테스트 코드 추가 및 수정
- release({서버 명}): 배포한 서버에 대한 앱 배포 내용 ex. release(dev): 개발 서버 배포 1.1.0

---

## 디자인 토큰

```dart
// core/theme/app_colors.dart
class AppColors {
  static const background           = Color(0xFF101415);
  static const surfaceContainer     = Color(0xFF1D2022);
  static const surfaceContainerHigh = Color(0xFF272A2C);
  static const moonlightGold        = Color(0xFFFDE047); // CTA 버튼 (노란색)
  static const softAmber            = Color(0xFFF59E0B); // Night Highlights
  static const primary              = Color(0xFFBEC6E0); // Photo Tip
  static const onSurface            = Color(0xFFE0E3E5);
  static const onSurfaceVariant     = Color(0xFFC6C6CD);
  static const glassBorder          = Color(0x1FFFFFFF); // 12% white
}
```

폰트: **Manrope** (headline/body), **Hanken Grotesk** (label)

---

## 폴더 구조

```
dalbit_suwon/
├── assets/
│   ├── icons/
│   └── images/
├── lib/
│   ├── core/
│   │   ├── theme/           # app_theme.dart, app_colors.dart, app_text_styles.dart
│   │   └── router/          # app_router.dart (GoRouter)
│   ├── features/
│   │   ├── home/            # 홈 화면
│   │   ├── course/          # 코스 상세 + 진행 + 완료
│   │   ├── spot/            # 스팟 상세
│   │   └── auth/            # 로그인
│   └── shared/
│       └── widgets/         # 공통 위젯
└── test/
    └── features/
```

---

## Repository 패턴 규칙

- 모든 feature는 `data/` 안에 abstract 인터페이스 정의
- Mock 구현체는 `_mock` suffix: `course_repository_mock.dart`
- 나중에 Supabase 구현체는 `_supabase` suffix: `course_repository_supabase.dart`
- Provider에서 구현체 주입 → 교체 시 Provider 한 줄만 변경

```dart
// Provider 교체 예시
@riverpod
CourseRepository courseRepository(Ref ref) {
  return CourseRepositoryMock();        // UI 단계
  // return CourseRepositorySupabase(); // 기능 연동 단계
}
```

---

## DTO 규칙

- 외부 서비스(Supabase 등)에 데이터 전송 시 반드시 DTO 클래스 사용
- DTO 파일은 `features/{feature}/data/models/` 에 위치
- 파일명 suffix: `_dto` → `profile_dto.dart`
- 쓰기 전용 DTO: `toJson()` 메서드 포함
- 읽기 전용 DTO: `fromJson()` 팩토리 포함
- raw `Map<String, dynamic>` 직접 전달 금지

```dart
// DTO 예시
class ProfileDto {
  const ProfileDto({
    required this.id,
    this.nickname,
    required this.provider,
    required this.updatedAt,
  });

  final String id;
  final String? nickname;
  final String provider;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'provider': provider,
        'updated_at': updatedAt.toIso8601String(),
      };
}

// Repository에서 사용
await _client.from('profiles').upsert(dto.toJson()); // O
await _client.from('profiles').upsert({'id': id, ...}); // X
```

---

## 금지 사항

- `show` 없이 현재 앱 패키지 import 금지
- async 후 `context.mounted` 확인 생략 금지
- Repository를 거치지 않고 UI에서 직접 데이터 접근 금지
- 파일 하나에 스크린 위젯 2개 이상 금지
- UseCase 레이어 추가 금지 (옵션 A 유지)
- raw/core 테이블 직접 접근 금지 (추후 Supabase 연동 시, serving 뷰/RPC만 사용)
- 외부 서비스 데이터 전송 시 raw `Map<String, dynamic>` 직접 사용 금지 (DTO 사용)
