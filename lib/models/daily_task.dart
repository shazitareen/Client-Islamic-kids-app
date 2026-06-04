// lib/models/daily_task.dart

/// Represents a single daily Islamic habit/task.
class DailyTask {
  final String id;
  final String title;
  final String arabicPhrase; // Optional Arabic phrase e.g. "بِسْمِ اللَّهِ"
  final String description;
  final String emoji;
  bool isCompleted;

  DailyTask({
    required this.id,
    required this.title,
    required this.arabicPhrase,
    required this.description,
    required this.emoji,
    this.isCompleted = false,
  });

  /// Creates a copy with optional field overrides
  DailyTask copyWith({bool? isCompleted}) {
    return DailyTask(
      id: id,
      title: title,
      arabicPhrase: arabicPhrase,
      description: description,
      emoji: emoji,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
