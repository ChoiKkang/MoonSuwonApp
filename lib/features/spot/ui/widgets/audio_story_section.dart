import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart'
    show AppTextStyles;
import 'package:dalbit_suwon/features/spot/data/models/audio_story.dart'
    show AudioStory, splitAudioStories;

/// 오디오 해설(오디오북) 섹션.
///
/// 한국관광공사 오디(Odii) 오디오 가이드를 두 갈래로 나눠 보여준다.
/// - 들을 수 있는 해설: 재생 파일(mp3)이 있어 그 자리에서 재생한다.
/// - 읽을 수 있는 해설: 본문만 공개된 항목이라 스크립트를 펼쳐 읽는다.
///
/// 재생은 [just_audio] `AudioPlayer` 하나를 공유한다. 한 번에 하나의 해설만
/// 재생되며, 다른 해설을 누르면 이전 재생은 멈춘다.
class AudioStorySection extends StatefulWidget {
  const AudioStorySection({super.key, required this.stories});

  final List<AudioStory> stories;

  @override
  State<AudioStorySection> createState() => _AudioStorySectionState();
}

class _AudioStorySectionState extends State<AudioStorySection> {
  final AudioPlayer _player = AudioPlayer();
  String? _currentId;

  @override
  void initState() {
    super.initState();
    // 재생이 끝나면 시작 지점으로 되돌려 다시 들을 수 있게 한다.
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _onTogglePlayAsync(AudioStory story) async {
    final url = story.audioUrl;
    if (url == null || url.trim().isEmpty) return;

    try {
      if (_currentId == story.id) {
        // 같은 해설을 다시 누르면 재생/일시정지 토글.
        if (_player.playing) {
          await _player.pause();
        } else {
          await _player.play();
        }
        return;
      }

      // 다른 해설로 전환: 기존 재생을 멈추고 새 소스를 건다.
      await _player.stop();
      if (!mounted) return;
      setState(() => _currentId = story.id);
      await _player.setUrl(url);
      await _player.play();
    } catch (_) {
      if (!mounted) return;
      setState(() => _currentId = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('오디오를 재생할 수 없습니다. 잠시 후 다시 시도해 주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final split = splitAudioStories(widget.stories);
    if (split.playable.isEmpty && split.readable.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.headphones_outlined,
              size: 18,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text('오디오 해설', style: AppTextStyles.headlineMd),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '한국관광공사 오디(Odii) 오디오 가이드입니다.',
          style: AppTextStyles.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        if (split.playable.isNotEmpty) ...[
          _GroupLabel(icon: Icons.play_circle_outline, text: '들을 수 있는 해설'),
          const SizedBox(height: 10),
          ...split.playable.map(
            (story) => StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final isCurrent = _currentId == story.id;
                final state = snapshot.data;
                final processing = state?.processingState;
                final isLoading =
                    isCurrent &&
                    (processing == ProcessingState.loading ||
                        processing == ProcessingState.buffering);
                final isPlaying = isCurrent && (state?.playing ?? false);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _AudioStoryTile(
                    key: ValueKey('audio-${story.id}'),
                    story: story,
                    isPlaying: isPlaying,
                    isLoading: isLoading,
                    onTogglePlay: () => _onTogglePlayAsync(story),
                  ),
                );
              },
            ),
          ),
        ],
        if (split.readable.isNotEmpty) ...[
          if (split.playable.isNotEmpty) const SizedBox(height: 8),
          _GroupLabel(icon: Icons.menu_book_outlined, text: '읽을 수 있는 해설'),
          const SizedBox(height: 10),
          ...split.readable.map(
            (story) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _AudioStoryTile(
                key: ValueKey('audio-${story.id}'),
                story: story,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.moonlightGold),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurface),
        ),
      ],
    );
  }
}

/// 오디오 해설 한 건. 재생 가능한 항목은 재생 버튼을, 본문이 있으면 펼쳐 읽기를
/// 함께 제공한다. 펼침 상태는 타일 자체가 들고 있어 부모 리빌드에도 유지된다.
class _AudioStoryTile extends StatefulWidget {
  const _AudioStoryTile({
    super.key,
    required this.story,
    this.isPlaying = false,
    this.isLoading = false,
    this.onTogglePlay,
  });

  final AudioStory story;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback? onTogglePlay;

  @override
  State<_AudioStoryTile> createState() => _AudioStoryTileState();
}

class _AudioStoryTileState extends State<_AudioStoryTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final playable = story.isPlayable;
    final script = story.script?.trim() ?? '';
    final hasScript = script.isNotEmpty;
    final meta = <String>[
      if (story.playTimeLabel != null) story.playTimeLabel!,
      if (story.distanceM != null) '약 ${story.distanceM}m',
    ].join(' · ');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (playable)
                _PlayButton(
                  isPlaying: widget.isPlaying,
                  isLoading: widget.isLoading,
                  onPressed: widget.onTogglePlay,
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.article_outlined,
                    size: 20,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.audioTitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (meta.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        meta,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (hasScript) ...[
            const SizedBox(height: 10),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Text(
                script,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMd.copyWith(
                  fontSize: 14,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              secondChild: Text(
                script,
                style: AppTextStyles.bodyMd.copyWith(
                  fontSize: 14,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _expanded ? '접기' : '해설 보기',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.moonlightGold,
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: 16,
                    color: AppColors.moonlightGold,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.isPlaying,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isPlaying;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isPlaying ? '해설 일시정지' : '해설 재생',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.moonlightGold,
            shape: BoxShape.circle,
          ),
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF283044),
                  ),
                )
              : Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: const Color(0xFF283044),
                  size: 24,
                ),
        ),
      ),
    );
  }
}
