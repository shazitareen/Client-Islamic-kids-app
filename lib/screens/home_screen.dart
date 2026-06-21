// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../data/duas_data.dart';
import '../widgets/module_card.dart';
import '../widgets/parental_gate.dart';
import '../providers/app_provider.dart';
import 'qaidah_quiz_screen.dart';
import 'islamic_quiz_screen.dart';
import 'daily_tasks_screen.dart';
import 'settings_screen.dart';
import 'salah_guide_screen.dart';
import 'quran_screen.dart';
import 'wudu_guide_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowRemoveAdsPopup();
    });
  }

  void _maybeShowRemoveAdsPopup() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final appProvider = context.read<AppProvider>();
    if (appProvider.adsRemoved) return;

    final lastShown = prefs.getString('last_ads_popup');
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (lastShown == today) return;

    await prefs.setString('last_ads_popup', today);
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('🌟 Enjoy Ad-Free Learning!', textAlign: TextAlign.center),
        content: const Text(
          'Remove all ads forever for a one-time payment.\nPerfect for the whole family!',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Not now')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
            onPressed: () {
              Navigator.pop(ctx);
              ParentalGate.show(context, () {
                appProvider.purchaseRemoveAds(context);
              });
            },
            child: const Text('Remove Ads', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dua = getDuaOfTheDay();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryGreen, AppTheme.lightGreen],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ───────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.star_rounded, color: Colors.black87, size: 24),
                        tooltip: 'Remove Ads',
                        onPressed: () {
                          ParentalGate.show(context, () {
                            context.read<AppProvider>().purchaseRemoveAds(context);
                          });
                        },
                      ),
                    ),
                    const Text(
                      '🕌 Deen4Family',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.settings_rounded, color: Colors.black87, size: 24),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ── Bismillah Banner ──────────────────────────────────────
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Center(
                  child: Text(
                    'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ── Module Cards ──────────────────────────────────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppTheme.bgCream,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ── Dua of the Day ──────────────────────────
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                              child: _DuaOfTheDayCard(dua: dua),
                            ),

                            const SizedBox(height: 8),

                            // Quran Card
                            ModuleCard(
                              title: 'The Holy Quran',
                              iconPath: '',
                              emoji: '📖',
                              gradient: const [Color(0xFF1B5E20), Color(0xFF388E3C)],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const QuranScreen()),
                              ),
                            ),

                            // Qaidah Quiz Card
                            ModuleCard(
                              title: 'Qaidah Quiz',
                              iconPath: 'assets/images/qaidah-quiz.png',
                              gradient: AppTheme.qaidahGradient,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const QaidahQuizScreen()),
                              ),
                            ),

                            // Islamic Quiz Card
                            ModuleCard(
                              title: 'Islamic Quiz',
                              iconPath: 'assets/images/islamic-quiz.png',
                              gradient: AppTheme.islamicQuizGradient,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const IslamicQuizScreen()),
                              ),
                            ),

                            // Daily Tasks Card
                            ModuleCard(
                              title: 'Daily Tasks',
                              iconPath: 'assets/images/daily-task.png',
                              gradient: AppTheme.dailyTasksGradient,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const DailyTasksScreen()),
                              ),
                            ),

                            // Salah Guide Card
                            ModuleCard(
                              title: 'How to Pray Salah',
                              iconPath: 'assets/images/how-to-pray.png',
                              gradient: const [AppTheme.deepTeal, AppTheme.skyBlue],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SalahGuideScreen()),
                              ),
                            ),

                            // Wudu Guide Card
                            ModuleCard(
                              title: 'How to Make Wudu',
                              iconPath: '',
                              emoji: '🤲',
                              gradient: const [Color(0xFF0097A7), Color(0xFF26C6DA)],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const WuduGuideScreen()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Dua of the Day Card Widget ────────────────────────────────────────────────

class _DuaOfTheDayCard extends StatelessWidget {
  final DuaItem dua;

  const _DuaOfTheDayCard({required this.dua});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF283593)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(dua.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              const Text(
                'Dua of the Day',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            dua.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            dua.arabic,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dua.transliteration,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dua.translation,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
