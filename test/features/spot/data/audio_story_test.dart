import 'package:flutter_test/flutter_test.dart';

import 'package:dalbit_suwon/features/spot/data/models/audio_story.dart'
    show AudioStory, formatPlaySeconds, splitAudioStories;

void main() {
  group('formatPlaySeconds', () {
    test('null·0·음수는 null을 돌려준다', () {
      expect(formatPlaySeconds(null), isNull);
      expect(formatPlaySeconds(0), isNull);
      expect(formatPlaySeconds(-5), isNull);
    });

    test('분·초를 한국어 라벨로 만든다', () {
      expect(formatPlaySeconds(45), '45초');
      expect(formatPlaySeconds(60), '1분');
      expect(formatPlaySeconds(120), '2분');
      expect(formatPlaySeconds(192), '3분 12초');
    });
  });

  group('AudioStory 분류', () {
    test('audioUrl이 있으면 재생 가능, 없으면 본문으로 읽기', () {
      const playable = AudioStory(
        id: 'a',
        audioTitle: '재생본',
        script: '본문',
        audioUrl: 'https://example.com/a.mp3',
        playSeconds: 100,
      );
      const readable = AudioStory(id: 'b', audioTitle: '읽기본', script: '본문');
      const emptyUrl = AudioStory(id: 'c', audioTitle: '빈 URL', audioUrl: '  ');

      expect(playable.isPlayable, isTrue);
      expect(playable.isReadable, isFalse);
      expect(playable.playTimeLabel, '1분 40초');

      expect(readable.isPlayable, isFalse);
      expect(readable.isReadable, isTrue);

      // audioUrl이 공백뿐이면 재생 불가로 본다.
      expect(emptyUrl.isPlayable, isFalse);
    });
  });

  group('splitAudioStories', () {
    test('제목 기준 중복을 접고 재생/읽기로 나누며 순서를 유지한다', () {
      const stories = [
        AudioStory(
          id: '1',
          audioTitle: '가까운 해설',
          audioUrl: 'https://example.com/1.mp3',
        ),
        AudioStory(id: '2', audioTitle: '읽기 해설', script: '본문'),
        // 제목이 같은 중복 → 접힌다.
        AudioStory(
          id: '3',
          audioTitle: '가까운 해설',
          audioUrl: 'https://example.com/3.mp3',
        ),
        AudioStory(id: '4', audioTitle: '본문 없는 항목'),
      ];

      final split = splitAudioStories(stories);

      expect(split.playable.map((s) => s.id), ['1']);
      expect(split.readable.map((s) => s.id), ['2']);
      // 재생 URL도 본문도 없는 항목은 어느 쪽에도 포함되지 않는다.
      expect(
        split.playable.any((s) => s.id == '4') ||
            split.readable.any((s) => s.id == '4'),
        isFalse,
      );
    });
  });
}
