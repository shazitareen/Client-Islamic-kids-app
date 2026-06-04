import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/salah_video_player.dart';

class PrayerVideoScreen extends StatelessWidget {
  final String prayerName;
  final String videoPath;

  const PrayerVideoScreen({
    super.key,
    required this.prayerName,
    required this.videoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgCream,
      appBar: AppBar(
        title: Text('$prayerName Guide'),
        backgroundColor: AppTheme.deepTeal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.deepTeal, AppTheme.skyBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.deepTeal.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.menu_book_rounded, color: Colors.white, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      'Learning $prayerName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Watch the video below to learn how to pray $prayerName Salah correctly.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Video Player
              SalahVideoPlayer(videoPath: videoPath),

              const SizedBox(height: 30),

              // Tips Section
              _buildTipCard(
                'Remember!',
                'Salah is a conversation with Allah. Take your time and focus on each movement.',
                Icons.lightbulb_outline_rounded,
                AppTheme.accentGold,
              ),
              const SizedBox(height: 80), // Safe area bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
