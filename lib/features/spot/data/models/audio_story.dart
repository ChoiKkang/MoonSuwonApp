import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_story.freezed.dart';
part 'audio_story.g.dart';

/// 오디오 해설(오디오북) 한 건.
///
/// 한국관광공사 오디(Odii) 오디오 가이드에서 온다. 두 종류가 섞여 있다.
/// 재생 파일이 있는 항목(playable)과, 오디 앱 안에서만 들을 수 있어 본문만
/// 공개된 항목(readable)이다. 수원화성 성곽 해설이 후자인데, 밤에 성곽을
/// 걸으며 읽기에는 오히려 낫다. 웹(`src/lib/places/audio-stories.ts`)의 계약을
/// 그대로 옮겨 왔다.
@freezed
abstract class AudioStory with _$AudioStory {
  const AudioStory._();

  const factory AudioStory({
    required String id,
    String? spotTitle,
    required String audioTitle,
    String? script,
    int? playSeconds,
    String? audioUrl,
    int? distanceM,
  }) = _AudioStory;

  factory AudioStory.fromJson(Map<String, dynamic> json) =>
      _$AudioStoryFromJson(json);

  /// 재생 파일이 있으면 들을 수 있는 해설이다.
  bool get isPlayable => audioUrl != null && audioUrl!.trim().isNotEmpty;

  /// 재생 파일은 없고 본문만 있으면 읽을 수 있는 해설이다.
  bool get isReadable =>
      !isPlayable && script != null && script!.trim().isNotEmpty;

  /// 재생 길이를 "3분 12초" 형태로. 값이 없으면 null.
  String? get playTimeLabel => formatPlaySeconds(playSeconds);
}

/// 재생 길이를 "3분 12초" 형태의 한국어 라벨로. 0 이하이거나 없으면 null.
String? formatPlaySeconds(int? seconds) {
  if (seconds == null || seconds <= 0) return null;
  final minutes = seconds ~/ 60;
  final rest = seconds % 60;
  if (minutes == 0) return '$rest초';
  if (rest == 0) return '$minutes분';
  return '$minutes분 $rest초';
}

/// 들을 수 있는 해설과 읽을 수 있는 해설로 나눈다.
///
/// 같은 지점 해설이 제목만 다르게 중복되는 경우가 있어 제목 기준으로 한 번
/// 접는다. 입력 순서(대개 가까운 순)를 유지한다.
({List<AudioStory> playable, List<AudioStory> readable}) splitAudioStories(
  List<AudioStory> stories,
) {
  final seen = <String>{};
  final unique = stories.where((story) => seen.add(story.audioTitle)).toList();

  return (
    playable: unique.where((story) => story.isPlayable).toList(),
    readable: unique.where((story) => story.isReadable).toList(),
  );
}
