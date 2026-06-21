// lib/screens/wudu_guide_screen.dart
import 'package:flutter/material.dart';
import '../app_theme.dart';

class WuduGuideScreen extends StatefulWidget {
  const WuduGuideScreen({super.key});

  @override
  State<WuduGuideScreen> createState() => _WuduGuideScreenState();
}

class _WuduGuideScreenState extends State<WuduGuideScreen> {
  int _currentStep = 0;

  static const List<_WuduStep> _steps = [
    _WuduStep(
      number: 1,
      title: 'Make Intention (Niyyah)',
      arabic: 'نِيَّةُ الْوُضُوءِ',
      description: 'In your heart, make the intention to perform Wudu for the sake of Allah.',
      emoji: '💚',
      tip: 'Niyyah is in the heart — you don\'t need to say it out loud.',
    ),
    _WuduStep(
      number: 2,
      title: 'Say Bismillah',
      arabic: 'بِسْمِ اللَّهِ',
      description: 'Say "Bismillah" — In the name of Allah — before you begin.',
      emoji: '🤲',
      tip: 'The Prophet ﷺ taught us to say Bismillah before Wudu.',
    ),
    _WuduStep(
      number: 3,
      title: 'Wash Both Hands',
      arabic: 'غَسْلُ الْيَدَيْنِ',
      description: 'Wash both hands up to the wrists 3 times, making sure water reaches between the fingers.',
      emoji: '👐',
      tip: 'Start with the right hand, then the left!',
    ),
    _WuduStep(
      number: 4,
      title: 'Rinse the Mouth',
      arabic: 'الْمَضْمَضَةُ',
      description: 'Take water into your mouth and swirl it around 3 times, then spit it out.',
      emoji: '💧',
      tip: 'Make sure the water reaches all parts of the mouth.',
    ),
    _WuduStep(
      number: 5,
      title: 'Rinse the Nose',
      arabic: 'الِاسْتِنْشَاقُ',
      description: 'Sniff water into your nose 3 times and blow it out each time.',
      emoji: '👃',
      tip: 'Use the left hand to blow out the water.',
    ),
    _WuduStep(
      number: 6,
      title: 'Wash the Face',
      arabic: 'غَسْلُ الْوَجْهِ',
      description: 'Wash the entire face 3 times, from the hairline to the chin and ear to ear.',
      emoji: '😊',
      tip: 'If you have a beard, let water flow through it.',
    ),
    _WuduStep(
      number: 7,
      title: 'Wash the Arms',
      arabic: 'غَسْلُ الذِّرَاعَيْنِ',
      description: 'Wash each arm from fingertips to the elbow 3 times. Start with the right arm.',
      emoji: '💪',
      tip: 'Don\'t forget to include the elbows!',
    ),
    _WuduStep(
      number: 8,
      title: 'Wipe the Head',
      arabic: 'مَسْحُ الرَّأْسِ',
      description: 'Wipe the entire head once with wet hands, going from the front to the back and back again.',
      emoji: '🙏',
      tip: 'The head is wiped once, not three times.',
    ),
    _WuduStep(
      number: 9,
      title: 'Wipe the Ears',
      arabic: 'مَسْحُ الْأُذُنَيْنِ',
      description: 'Using the same water, wipe the inside of the ears with index fingers and outside with thumbs.',
      emoji: '👂',
      tip: 'This is done once as part of wiping the head.',
    ),
    _WuduStep(
      number: 10,
      title: 'Wash the Feet',
      arabic: 'غَسْلُ الْقَدَمَيْنِ',
      description: 'Wash both feet up to and including the ankles 3 times. Start with the right foot.',
      emoji: '🦶',
      tip: 'Make sure water reaches between the toes!',
    ),
    _WuduStep(
      number: 11,
      title: 'Say the Dua',
      arabic: 'أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
      description: 'After finishing Wudu, say the dua of Wudu while looking towards the sky.',
      emoji: '⭐',
      tip: 'Saying this dua opens the 8 gates of Paradise for you!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];
    final isLast = _currentStep == _steps.length - 1;
    final isFirst = _currentStep == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Make Wudu'),
        backgroundColor: AppTheme.deepTeal,
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentStep + 1) / _steps.length,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.deepTeal),
            minHeight: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step ${step.number} of ${_steps.length}',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Text(
                  '${((_currentStep + 1) / _steps.length * 100).round()}%',
                  style: const TextStyle(color: AppTheme.deepTeal, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),

          // Step card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 6))
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Emoji
                            Text(step.emoji, style: const TextStyle(fontSize: 72)),
                            const SizedBox(height: 20),

                            // Title
                            Text(
                              step.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.deepTeal,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Arabic
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppTheme.deepTeal.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                step.arabic,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: AppTheme.deepTeal,
                                  height: 1.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Description
                            Text(
                              step.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Tip
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.amber.shade200),
                              ),
                              child: Row(
                                children: [
                                  const Text('💡', style: TextStyle(fontSize: 18)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      step.tip,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.amber.shade900,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Navigation buttons
                  Row(
                    children: [
                      if (!isFirst)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => setState(() => _currentStep--),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              side: const BorderSide(color: AppTheme.deepTeal),
                            ),
                            child: const Text('← Back', style: TextStyle(color: AppTheme.deepTeal, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      if (!isFirst) const SizedBox(width: 12),
                      Expanded(
                        flex: isFirst ? 1 : 1,
                        child: ElevatedButton(
                          onPressed: isLast
                              ? () {
                                  setState(() => _currentStep = 0);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('✅ Mashallah! Wudu complete!'),
                                      backgroundColor: AppTheme.deepTeal,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              : () => setState(() => _currentStep++),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isLast ? AppTheme.correctGreen : AppTheme.deepTeal,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 3,
                          ),
                          child: Text(
                            isLast ? '✅ Done! Restart' : 'Next →',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Step dots
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    children: List.generate(_steps.length, (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: i == _currentStep ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i <= _currentStep ? AppTheme.deepTeal : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WuduStep {
  final int number;
  final String title;
  final String arabic;
  final String description;
  final String emoji;
  final String tip;

  const _WuduStep({
    required this.number,
    required this.title,
    required this.arabic,
    required this.description,
    required this.emoji,
    required this.tip,
  });
}
