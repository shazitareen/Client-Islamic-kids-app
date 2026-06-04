// lib/providers/tasks_provider.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/daily_task.dart';
import '../data/daily_tasks_data.dart';
import '../services/storage_service.dart';

/// Manages the state for the 3 Daily Tasks.
class TasksProvider extends ChangeNotifier {
  final StorageService _storage;

  List<DailyTask> _todaysTasks = [];
  Map<String, bool> _completedTasks = {};
  bool _isLoaded = false;

  List<DailyTask> get todaysTasks => _todaysTasks;
  bool isTaskCompleted(String taskId) => _completedTasks[taskId] ?? false;
  
  bool get areAllTasksCompleted {
    if (_todaysTasks.isEmpty) return false;
    return _todaysTasks.every((t) => isTaskCompleted(t.id));
  }
  
  bool get isLoaded => _isLoaded;

  TasksProvider(this._storage);

  /// Loads tasks from storage, picks 3 tasks for today based on random seed.
  Future<void> loadTasks() async {
    final allTasks = getDailyTasksData();

    // Use current day as seed to pick 3 random unique tasks
    final daysSinceEpoch = DateTime.now().difference(DateTime(2024, 1, 1)).inDays;
    final random = Random(daysSinceEpoch);
    
    final shuffledTasks = List<DailyTask>.from(allTasks)..shuffle(random);
    _todaysTasks = shuffledTasks.take(3).toList();

    _completedTasks = _storage.getTaskHistory();

    if (_storage.shouldResetTasks()) {
      // It's a new day, clear old completions
      _completedTasks.clear();
      await _storage.saveTaskHistory(_completedTasks);
      await _storage.saveResetDate();
    }

    _isLoaded = true;
    notifyListeners();
  }

  /// Toggles a task completion state and persists it.
  Future<void> toggleTask(String taskId) async {
    final currentlyCompleted = _completedTasks[taskId] ?? false;
    _completedTasks[taskId] = !currentlyCompleted;
    
    await _storage.saveTaskHistory(_completedTasks);
    notifyListeners();
  }
}
