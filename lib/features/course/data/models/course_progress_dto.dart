/// 코스 진행/체크인/완료 RPC 호출 DTO.
///
/// Supabase 원격 스키마 계약:
/// - `public.start_course_progress(p_course_id uuid)`
/// - `public.complete_course_progress(p_progress_id uuid)`
/// - `public.abandon_course_progress(p_progress_id uuid)`
/// - `public.get_active_course_progress(p_course_id uuid)`
/// - `public.checkin_place(p_progress_id, p_place_id, p_lat, p_lng, p_mode)`
/// - `public.list_user_course_history(p_limit int)`
library;

/// 체크인 판정 방식.
enum CheckinMode {
  auto('auto'),
  manual('manual');

  const CheckinMode(this.wire);

  final String wire;
}

/// checkin_place RPC 반환 문자열.
enum CheckinResult {
  success,
  outOfRange,
  alreadyChecked,
  unknown;

  static CheckinResult fromWire(String value) {
    switch (value) {
      case 'success':
        return CheckinResult.success;
      case 'out_of_range':
        return CheckinResult.outOfRange;
      case 'already_checked':
        return CheckinResult.alreadyChecked;
      default:
        return CheckinResult.unknown;
    }
  }
}

class StartCourseProgressQueryDto {
  const StartCourseProgressQueryDto(this.courseId);

  final String courseId;

  Map<String, dynamic> toJson() => {'p_course_id': courseId};
}

class ProgressIdQueryDto {
  const ProgressIdQueryDto(this.progressId);

  final String progressId;

  Map<String, dynamic> toJson() => {'p_progress_id': progressId};
}

class CourseIdQueryDto {
  const CourseIdQueryDto(this.courseId);

  final String courseId;

  Map<String, dynamic> toJson() => {'p_course_id': courseId};
}

class CheckinPlaceQueryDto {
  const CheckinPlaceQueryDto({
    required this.progressId,
    required this.placeId,
    required this.mode,
    this.lat,
    this.lng,
  });

  final String progressId;
  final String placeId;
  final CheckinMode mode;
  final double? lat;
  final double? lng;

  Map<String, dynamic> toJson() => {
        'p_progress_id': progressId,
        'p_place_id': placeId,
        'p_lat': lat,
        'p_lng': lng,
        'p_mode': mode.wire,
      };
}

class UserCourseHistoryQueryDto {
  const UserCourseHistoryQueryDto({this.limit = 20});

  final int limit;

  Map<String, dynamic> toJson() => {'p_limit': limit};
}

/// start_course_progress / get_active_course_progress / complete_course_progress
/// 공통으로 반환하는 진행 세션 스냅샷.
class CourseProgressSessionDto {
  const CourseProgressSessionDto({
    required this.progressId,
    required this.courseId,
    required this.status,
    this.startedAt,
    this.completedAt,
    this.checkinCount = 0,
    this.spotCount = 0,
    this.isPerfect = false,
  });

  factory CourseProgressSessionDto.fromJson(Map<String, dynamic> json) {
    return CourseProgressSessionDto(
      progressId: json['progress_id'] as String,
      courseId: json['course_id'] as String,
      status: json['status'] as String? ?? 'in_progress',
      startedAt: _parseDate(json['started_at']),
      completedAt: _parseDate(json['completed_at']),
      checkinCount: (json['checkin_count'] as num?)?.toInt() ?? 0,
      spotCount: (json['spot_count'] as num?)?.toInt() ?? 0,
      isPerfect: json['is_perfect'] as bool? ?? false,
    );
  }

  final String progressId;
  final String courseId;
  final String status; // 'in_progress' | 'completed' | 'abandoned'
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int checkinCount;
  final int spotCount;
  final bool isPerfect;

  bool get inProgress => status == 'in_progress';
  bool get isCompleted => status == 'completed';
  bool get isAbandoned => status == 'abandoned';

  static DateTime? _parseDate(Object? value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}

/// list_user_course_history 반환 row.
class CourseHistoryEntryDto {
  const CourseHistoryEntryDto({
    required this.progressId,
    required this.courseId,
    required this.courseSlug,
    required this.heroTitle,
    required this.status,
    this.subtitle,
    this.routeSummary,
    this.heroImageUrl,
    this.startedAt,
    this.completedAt,
    this.checkinCount = 0,
    this.spotCount = 0,
    this.walkingDistanceKm = 0,
    this.estimatedDurationMin = 0,
  });

  factory CourseHistoryEntryDto.fromJson(Map<String, dynamic> json) {
    return CourseHistoryEntryDto(
      progressId: json['progress_id'] as String,
      courseId: json['course_id'] as String,
      courseSlug: json['course_slug'] as String? ?? '',
      heroTitle: json['hero_title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      routeSummary: json['route_summary'] as String?,
      heroImageUrl: json['hero_image_url'] as String?,
      status: json['status'] as String? ?? 'in_progress',
      startedAt: CourseProgressSessionDto._parseDate(json['started_at']),
      completedAt: CourseProgressSessionDto._parseDate(json['completed_at']),
      checkinCount: (json['checkin_count'] as num?)?.toInt() ?? 0,
      spotCount: (json['spot_count'] as num?)?.toInt() ?? 0,
      walkingDistanceKm:
          (json['walking_distance_km'] as num?)?.toDouble() ?? 0,
      estimatedDurationMin:
          (json['estimated_duration_min'] as num?)?.toInt() ?? 0,
    );
  }

  final String progressId;
  final String courseId;
  final String courseSlug;
  final String heroTitle;
  final String? subtitle;
  final String? routeSummary;
  final String? heroImageUrl;
  final String status;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int checkinCount;
  final int spotCount;
  final double walkingDistanceKm;
  final int estimatedDurationMin;
}
