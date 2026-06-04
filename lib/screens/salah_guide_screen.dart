// lib/screens/salah_guide_screen.dart
import 'package:flutter/material.dart';
import 'prayer_video_screen.dart';
import '../app_theme.dart';

class SalahStep {
  final String title;
  final String arabicTitle;
  final String description;
  final IconData icon;
  final Color color;

  const SalahStep({
    required this.title,
    required this.arabicTitle,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class PrayerVideoData {
  final String name;
  final String rakat;
  final String videoPath;
  final Color color;

  const PrayerVideoData({
    required this.name,
    required this.rakat,
    required this.videoPath,
    required this.color,
  });
}

class SalahGuideScreen extends StatelessWidget {
  const SalahGuideScreen({super.key});

  static const List<PrayerVideoData> _prayers = [
    PrayerVideoData(
      name: 'Fajr',
      rakat: '2 Rakat',
      videoPath: 'assets/videos/2_rakat.mp4',
      color: AppTheme.skyBlue,
    ),
    PrayerVideoData(
      name: 'Dhuhr',
      rakat: '4 Rakat',
      videoPath: 'assets/videos/4_rakat.mp4',
      color: AppTheme.primaryGreen,
    ),
    PrayerVideoData(
      name: 'Asr',
      rakat: '4 Rakat',
      videoPath: 'assets/videos/4_rakat.mp4',
      color: AppTheme.accentGold,
    ),
    PrayerVideoData(
      name: 'Maghrib',
      rakat: '3 Rakat',
      videoPath: 'assets/videos/3_rakat.mp4',
      color: AppTheme.warmOrange,
    ),
    PrayerVideoData(
      name: 'Isha',
      rakat: '4 Rakat',
      videoPath: 'assets/videos/4_rakat.mp4',
      color: AppTheme.softPurple,
    ),
  ];

  static const List<SalahStep> _steps = [
    // ... (rest of the steps remain the same)
    SalahStep(
      title: '1. Make Wudu (Ablution)',
      arabicTitle: 'الوضوء',
      description: 'Cleanse yourself before praying by washing your hands, mouth, nose, face, arms, head, and feet.',
      icon: Icons.water_drop,
      color: AppTheme.skyBlue,
    ),
    SalahStep(
      title: '2. Intention (Niyyah)',
      arabicTitle: 'النية',
      description: 'Stand facing the Qiblah. In your heart, make the intention for the specific Salah you are about to perform.',
      icon: Icons.favorite,
      color: AppTheme.warmOrange,
    ),
    SalahStep(
      title: '3. Takbeer',
      arabicTitle: 'تكبير',
      description: 'Raise your hands to your ears and say "Allahu Akbar" (Allah is the Greatest).',
      icon: Icons.pan_tool,
      color: AppTheme.deepTeal,
    ),
    SalahStep(
      title: '4. Qiyam (Standing)',
      arabicTitle: 'قيام',
      description: 'Place your right hand over your left on your chest. Recite Surah Al-Fatihah, followed by another Surah.',
      icon: Icons.accessibility_new,
      color: AppTheme.primaryGreen,
    ),
    SalahStep(
      title: '5. Ruku (Bowing)',
      arabicTitle: 'ركوع',
      description: 'Bow down, resting your hands on your knees. Keep your back straight and recite "Subhana Rabbiyal Azim" 3 times.',
      icon: Icons.arrow_downward,
      color: AppTheme.accentGold,
    ),
    SalahStep(
      title: '6. Sujud (Prostration)',
      arabicTitle: 'سجود',
      description: 'Prostrate on the ground with your forehead, nose, both hands, knees, and toes touching the floor. Recite "Subhana Rabbiyal A\'la" 3 times.',
      icon: Icons.airline_seat_flat_angled,
      color: AppTheme.bubblegumPink,
    ),
    SalahStep(
      title: '7. Tashahhud (Sitting)',
      arabicTitle: 'تشهد',
      description: 'Sit in a kneeling position between prostrations and at the end of the prayer. Recite the Tashahhud and send blessings upon the Prophet ﷺ.',
      icon: Icons.airline_seat_legroom_normal,
      color: AppTheme.softPurple,
    ),
    SalahStep(
      title: '8. Tasleem (Ending)',
      arabicTitle: 'تسليم',
      description: 'Turn your head to the right and say "As-salamu alaykum wa rahmatullah". Then turn to your left and repeat.',
      icon: Icons.compare_arrows,
      color: AppTheme.lightGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Pray Salah'),
        backgroundColor: AppTheme.deepTeal,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            children: [
              // ── Video Tutorials Section ─────────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Video Tutorials',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _prayers.length,
                  itemBuilder: (context, index) {
                    final prayer = _prayers[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PrayerVideoScreen(
                            prayerName: prayer.name,
                            videoPath: prayer.videoPath,
                          ),
                        ),
                      ),
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: prayer.color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: prayer.color.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: prayer.color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              prayer.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              prayer.rakat,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // ── Step-by-Step Guide Section ──────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Step-by-Step Guide',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(_steps.length, (index) {
                final step = _steps[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black12, width: 2),
                        gradient: LinearGradient(
                          colors: [
                            step.color.withValues(alpha: 0.1),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: step.color.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              step.icon,
                              color: step.color,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        step.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      step.arabicTitle,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Amiri',
                                        color: Colors.black87,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  step.description,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
