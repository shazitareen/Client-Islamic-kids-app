// lib/screens/islamic_quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../app_theme.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_button.dart';

/// The Islamic Knowledge Quiz screen — 25 multiple choice questions.
class IslamicQuizScreen extends StatefulWidget {
  const IslamicQuizScreen({super.key});

  @override
  State<IslamicQuizScreen> createState() => _IslamicQuizScreenState();
}

class _IslamicQuizScreenState extends State<IslamicQuizScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().startQuiz();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(bool correct) async {
    try {
      await _audioPlayer.play(
        AssetSource(correct ? 'sounds/correct_answer.mp3' : 'sounds/wrong_answer.mp3'),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        if (provider.state == QuizState.finished) {
          return _buildResultScreen(context, provider);
        }

        final question = provider.currentQuestion;
        if (question == null) return const SizedBox.shrink();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Islamic Quiz'),
            backgroundColor: AppTheme.deepTeal,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0F2F1), AppTheme.bgCream],
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
                      // ── Progress & Score ──────────────────────────
                      _buildHeader(provider),

                      // ── Question Card ─────────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: AppTheme.islamicQuizGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.deepTeal.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Question ${provider.currentIndex + 1}',
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                question.question,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Answer Options ────────────────────────────
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            itemCount: question.options.length,
                            itemBuilder: (context, index) {
                              final isAnswered =
                                  provider.state == QuizState.answered;
                              final isSelected = provider.selectedAnswer == index;
                              final isCorrect =
                                  isAnswered && index == question.correctIndex;
                              final isWrong =
                                  isAnswered && isSelected && !isCorrect;

                              return AnswerButton(
                                text: question.options[index],
                                index: index,
                                isSelected: isSelected,
                                isCorrect: isCorrect,
                                isWrong: isWrong,
                                isEnabled: !isAnswered,
                                onTap: () async {
                                  provider.selectAnswer(index);
                                  await _playSound(index == question.correctIndex);
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      // ── Explanation (Hint) ────────────────────────
                      if (question.explanation != null)
                        _buildHintCard(question.explanation!),

                      // ── Next Button (Shown after answering) ───────
                      if (provider.state == QuizState.answered)
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

  Widget _buildHeader(QuizProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${provider.currentIndex + 1} / ${provider.totalQuestions}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.deepTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '⭐ Score: ${provider.score}',
                  style: const TextStyle(
                      color: AppTheme.deepTeal, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: provider.progress,
              minHeight: 10,
              backgroundColor: Colors.teal.shade50,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppTheme.deepTeal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintCard(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber.shade300),
        ),
        child: Row(
          children: [
            const Text('💡', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Hint: $hint',
                style: TextStyle(
                    fontSize: 13, color: Colors.brown.shade700, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(QuizProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => provider.nextQuestion(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(
            provider.currentIndex + 1 >= provider.totalQuestions
                ? 'See Results 🏆'
                : 'Next Question →',
            style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildResultScreen(BuildContext context, QuizProvider provider) {
    final pct = (provider.score / provider.totalQuestions * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: AppTheme.deepTeal,
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
                      Text(
                        provider.resultEmoji,
                        style: const TextStyle(fontSize: 80),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        provider.resultTitle,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        provider.resultSubtitle,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Score card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.skyBlue.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Text(
                              provider.scoreString,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$pct% correct',
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            if (provider.highScore > 0)
                              Text(
                                '🏅 Best: ${provider.highScore}/${provider.totalQuestions}',
                                style: const TextStyle(
                                    color: Colors.brown, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => provider.startQuiz(),
                          icon: const Icon(Icons.replay_rounded),
                          label: const Text('Play Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentGold,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
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
