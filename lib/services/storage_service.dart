// lib/services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';

/// Handles all local persistence using SharedPreferences.
/// Manages: task completion, last reset date, purchase state.
class StorageService {
  static const String _tasksKeyPrefix = 'task_completed_';
  static const String _taskHistoryKey = 'task_history_map';
  static const String _taskStreakKey = 'task_streak_count';
  static const String _lastResetKey = 'tasks_last_reset_date';
  static const String _adsRemovedKey = 'ads_removed';
  static const String _quizHighScoreKey = 'quiz_high_score';
  static const String _notificationHourKey = 'notification_hour';
  static const String _notificationMinuteKey = 'notification_minute';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// Factory constructor — initialises SharedPreferences
  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // ─── Daily Tasks ──────────────────────────────────────────────────

  /// Returns the completion state for a given task ID.
  bool isTaskCompleted(String taskId) {
    return _prefs.getBool('$_tasksKeyPrefix$taskId') ?? false;
  }

  /// Saves the completion state for a given task ID.
  Future<void> setTaskCompleted(String taskId, bool completed) async {
    await _prefs.setBool('$_tasksKeyPrefix$taskId', completed);
  }

  /// Returns the date tasks were last reset (as ISO 8601 string).
  String? getLastResetDate() {
    return _prefs.getString(_lastResetKey);
  }

  /// Saves today's date as the last reset date.
  Future<void> saveResetDate() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    await _prefs.setString(_lastResetKey, today);
  }

  /// Checks if tasks need to be reset (new day detected).
  bool shouldResetTasks() {
    final lastReset = getLastResetDate();
    if (lastReset == null) return true;
    final today = DateTime.now().toIso8601String().split('T')[0];
    return lastReset != today;
  }

  /// Clears all task completion flags.
  Future<void> clearAllTasks(List<String> taskIds) async {
    for (final id in taskIds) {
      await _prefs.remove('$_tasksKeyPrefix$id');
    }
  }

  // ─── Task History & Streak ────────────────────────────────────────

  /// Returns the rolling history. Map of 'yyyy-MM-dd' -> bool
  Map<String, bool> getTaskHistory() {
    final List<String> list = _prefs.getStringList(_taskHistoryKey) ?? [];
    final Map<String, bool> map = {};
    for (var item in list) {
      final parts = item.split('|');
      if (parts.length == 2) {
        map[parts[0]] = parts[1] == 'true';
      }
    }
    return map;
  }

  /// Saves the task history.
  Future<void> saveTaskHistory(Map<String, bool> history) async {
    // Convert to list of strings
    final list = history.entries.map((e) => '${e.key}|${e.value}').toList();
    await _prefs.setStringList(_taskHistoryKey, list);
  }

  /// Returns current continuity streak
  int getContinuityStreak() {
    return _prefs.getInt(_taskStreakKey) ?? 0;
  }

  /// Saves current continuity streak
  Future<void> saveContinuityStreak(int streak) async {
    await _prefs.setInt(_taskStreakKey, streak);
  }

  // ─── Purchases ───────────────────────────────────────────────────

  /// Returns whether the user has purchased ad removal.
  bool isAdsRemoved() {
    return _prefs.getBool(_adsRemovedKey) ?? false;
  }

  /// Persists the ad-removal purchase so it survives reinstalls
  /// (backed up via Google Play Backup).
  Future<void> setAdsRemoved(bool removed) async {
    await _prefs.setBool(_adsRemovedKey, removed);
  }

  // ─── Scores ──────────────────────────────────────────────────────

  int getQuizHighScore() {
    return _prefs.getInt(_quizHighScoreKey) ?? 0;
  }

  Future<void> saveQuizHighScore(int score) async {
    final current = getQuizHighScore();
    if (score > current) {
      await _prefs.setInt(_quizHighScoreKey, score);
    }
  }

  // ─── Notifications ────────────────────────────────────────────────

  int getNotificationHour() {
    return _prefs.getInt(_notificationHourKey) ?? 7; // Default 7 AM
  }

  int getNotificationMinute() {
    return _prefs.getInt(_notificationMinuteKey) ?? 0; // Default 0
  }

  Future<void> setNotificationTime(int hour, int minute) async {
    await _prefs.setInt(_notificationHourKey, hour);
    await _prefs.setInt(_notificationMinuteKey, minute);
  }
}
