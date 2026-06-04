// lib/screens/qaidah_quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../app_theme.dart';
import '../providers/qaidah_provider.dart';
import '../widgets/answer_button.dart';
import '../data/arabic_letters_data.dart';
import '../models/arabic_letter.dart';

/// The Qaidah (Arabic Alphabet) Quiz screen.
/// Shows one Arabic letter at a time and asks the player to pick the
/// Quran word that contains that letter.
class QaidahQuizScreen extends StatefulWidget {
  const QaidahQuizScreen({super.key});

  @override
  State<QaidahQuizScreen> createState() => _QaidahQuizScreenState();
}

class _QaidahQuizScreenState extends State<QaidahQuizScreen>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    // Reset to selection grid when entering the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QaidahProvider>().resetToSelection();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  Future<void> _playSound(bool correct) async {
    try {
      await _audioPlayer.play(
        AssetSource(correct ? 'sounds/correct_answer.mp3' : 'sounds/wrong_answer.mp3'),
      );
    } catch (_) {}
  }

  Future<void> _playLetterSound(ArabicLetter letter) async {
    try {
      await _audioPlayer.play(AssetSource(letter.audioPath));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QaidahProvider>(
      builder: (context, provider, _) {
        if (!provider.isQuizzing) {
          return _buildSelectionGrid(provider);
        }

        if (provider.isComplete) {
          return _buildCompleteScreen(provider);
        }

        final letter = provider.currentLetter!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Qaidah Quiz'),
            backgroundColor: AppTheme.primaryGreen,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => provider.setQuizzing(false),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8F5E9), AppTheme.bgCream],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      _buildProgressBar(provider),

                      // ── Arabic Letter Card ────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: GestureDetector(
                          onTap: () => _playLetterSound(letter),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppTheme.qaidahGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryGreen.withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Which word contains this letter?',
                                  style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                ScaleTransition(
                                  scale: _bounceAnimation,
                                  child: Text(
                                    letter.letter,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 96,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${letter.name}  •  ${letter.pronunciation}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.volume_up_rounded, size: 20, color: Colors.black54),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ── Answer Options ────────────────────────────
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: provider.options.length,
                            itemBuilder: (context, index) {
                              final isSelected =
                                  provider.selectedOptionIndex == index;
                              final isAnswered =
                                  provider.answerState != AnswerState.unanswered;
                              final isCorrect =
                                  isAnswered && index == provider.correctOptionIndex;
                              final isWrong = isAnswered && isSelected && !isCorrect;

                              return AnswerButton(
                                text: provider.options[index],
                                index: index,
                                isSquare: true,
                                isSelected: isSelected,
                                isCorrect: isCorrect,
                                isWrong: isWrong,
                                isEnabled: !isAnswered,
                                onTap: () async {
                                  await provider.selectAnswer(index);
                                  final correct =
                                      provider.answerState == AnswerState.correct;
                                  _bounceController.forward(from: 0);
                                  await _playSound(correct);
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      if (provider.answerState != AnswerState.unanswered)
                        _buildNextButton(provider),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectionGrid(QaidahProvider provider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arabic Letters'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppTheme.bgCream,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align text to match RTL feel
                children: [
                  Text(
                    'Tap a letter to hear sound & quiz',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.grid_view_rounded, size: 20, color: Colors.black54),
                ],
              ),
            ),

            // ── 4x7 RTL Letter Grid ──────────────────────────────
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl, // Arabic is Right-to-Left
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: arabicLettersData.length,
                  itemBuilder: (context, index) {
                    final letter = arabicLettersData[index];
                    return _buildLetterTile(provider, letter);
                  },
                ),
              ),
            ),

            // ── Random Quiz Button (Now at bottom) ────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => provider.startQuiz(),
                  icon: const Icon(Icons.psychology_rounded),
                  label: const Text('RANDOM QUIZ (3 LETTERS)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterTile(QaidahProvider provider, ArabicLetter letter) {
    return InkWell(
      onTap: () {
        _playLetterSound(letter);
        provider.startLetterSpecificQuiz(letter);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.1), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter.letter,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              letter.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: AppTheme.primaryGreen,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(QaidahProvider provider) {
    final total = provider.totalQuestions; // Total Arabic letters in this session
    final current = provider.questionsAnswered;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Letter ${current + 1} of $total',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Text(
                '✅ ${provider.correctAnswers} correct',
                style: const TextStyle(
                    color: AppTheme.correctGreen, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: total > 0 ? current / total : 0,
              minHeight: 10,
              backgroundColor: Colors.green.shade100,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppTheme.lightGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(QaidahProvider provider) {
    final correct = provider.answerState == AnswerState.correct;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Feedback message
          Text(
            correct ? '🎉 Excellent! MashaAllah!' : '❌ Oops! Try to remember!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: correct ? AppTheme.correctGreen : AppTheme.wrongRed,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => provider.nextLetter(),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    correct ? AppTheme.correctGreen : Colors.black87,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                  provider.questionsAnswered >= provider.totalQuestions
                      ? 'See Results 🏆'
                      : 'Next Letter →',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteScreen(QaidahProvider provider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: Container(
        width: double.infinity,
        color: AppTheme.bgCream,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 12,
                shadowColor: Colors.black.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(provider.resultEmoji, style: const TextStyle(fontSize: 80)),
                      const SizedBox(height: 16),
                      Text(
                        provider.resultTitle,
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 32,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You got ${provider.correctAnswers} out of ${provider.questionsAnswered} correct!',
                        style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        provider.resultSubtitle,
                        style: const TextStyle(color: Colors.black45, fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => provider.reset(),
                          icon: const Icon(Icons.replay_rounded),
                          label: const Text('Play Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentGold,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
