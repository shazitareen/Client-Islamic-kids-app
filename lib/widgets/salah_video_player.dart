import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../app_theme.dart';

class SalahVideoPlayer extends StatefulWidget {
  final String videoPath;

  const SalahVideoPlayer({super.key, required this.videoPath});

  @override
  State<SalahVideoPlayer> createState() => _SalahVideoPlayerState();
}

class _SalahVideoPlayerState extends State<SalahVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  double _currentSpeed = 1.0;

  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.asset(widget.videoPath);
    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
      // _controller.play(); // Auto-play disabled as per user request
      _controller.setLooping(true);
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setSpeed(double speed) {
    setState(() {
      _currentSpeed = speed;
      _controller.setPlaybackSpeed(speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.red.withValues(alpha: 0.3), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
            SizedBox(height: 12),
            Text(
              'Video failed to load.\nThis device might not support 60fps video playback.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryGreen),
      );
    }

    return Column(
      children: [
        // ── Video Display ───────────────────────────────────────────
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: VideoPlayer(_controller),
              ),
              // Play/Pause overlay
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: AnimatedOpacity(
                  opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Progress Bar ────────────────────────────────────────────
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
            playedColor: AppTheme.primaryGreen,
            bufferedColor: AppTheme.lightGreen.withValues(alpha: 0.5),
            backgroundColor: Colors.grey[200]!,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),

        const SizedBox(height: 20),

        // ── Speed Selector ──────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Playback Speed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_currentSpeed}x',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppTheme.primaryGreen,
                  inactiveTrackColor: Colors.grey[200],
                  thumbColor: AppTheme.primaryGreen,
                  overlayColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  valueIndicatorTextStyle: const TextStyle(color: Colors.black87),
                  valueIndicatorColor: AppTheme.primaryGreen,
                ),
                child: Slider(
                  value: _currentSpeed,
                  min: 0.5,
                  max: 2.0,
                  divisions: 6, // 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0
                  label: '${_currentSpeed}x',
                  onChanged: (value) => _setSpeed(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Slow', style: TextStyle(fontSize: 12, color: Colors.black45)),
                    Text('Normal', style: TextStyle(fontSize: 12, color: Colors.black45)),
                    Text('Fast', style: TextStyle(fontSize: 12, color: Colors.black45)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
