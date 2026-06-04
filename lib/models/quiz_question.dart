// lib/models/quiz_question.dart

/// Represents a single multiple-choice Islamic quiz question.
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex; // 0-based index of the correct answer
  final String? explanation; // Optional fun fact shown after answering

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });
}
