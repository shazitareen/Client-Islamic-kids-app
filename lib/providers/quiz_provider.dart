// lib/providers/quiz_provider.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../data/quiz_questions_data.dart';
import '../services/storage_service.dart';
import '../services/ad_service.dart';

/// Manages state for the Islamic Quiz module.
enum QuizState { inProgress, answered, finished }

class QuizProvider extends ChangeNotifier {
  final StorageService _storage;
  final AdService _adService;
  final Random _random = Random();

  List<QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  QuizState _state = QuizState.inProgress;
  int _highScore = 0;
  bool _adsDisabled = false;

  // Getters
  QuizQuestion? get currentQuestion =>
      _questions.isNotEmpty && _currentIndex < _questions.length
          ? _questions[_currentIndex]
          : null;
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  int get score => _score;
  int? get selectedAnswer => _selectedAnswer;
  QuizState get state => _state;
  int get highScore => _highScore;
  double get progress =>
      _questions.isEmpty ? 0 : _currentIndex / _questions.length;

  QuizProvider(this._storage, this._adService);

  void startQuiz({bool disableAds = false}) {
    _adsDisabled = disableAds;
    // Take only 3 questions per session for a short game loop
    _questions = (List<QuizQuestion>.from(islamicQuizData)..shuffle(_random)).take(3).toList();
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;
    _state = QuizState.inProgress;
    _highScore = _storage.getQuizHighScore();
    notifyListeners();
  }

  /// Called when the user selects an answer option.
  void selectAnswer(int index) {
    if (_state == QuizState.answered || _state == QuizState.finished) return;

    _selectedAnswer = index;
    _state = QuizState.answered;

    if (index == _questions[_currentIndex].correctIndex) {
      _score++;
    }

    notifyListeners();
  }

  /// Move to the next question or finish the quiz.
  Future<void> nextQuestion() async {
    _currentIndex++;
    _selectedAnswer = null;

    if (_currentIndex >= _questions.length) {
      _state = QuizState.finished;
      await _storage.saveQuizHighScore(_score);
      _highScore = _storage.getQuizHighScore();
      // Show AdMob interstitial ad when the 3-question round ends
      if (!_adsDisabled) {
        await _adService.showAdMobInterstitial();
      }
    } else {
      _state = QuizState.inProgress;
    }

    notifyListeners();
  }

  /// Returns whether the selected answer is correct.
  bool get isCorrect =>
      _selectedAnswer != null &&
      _selectedAnswer == _questions[_currentIndex].correctIndex;

  /// Returns the percentage score as a string like "3/3"
  String get scoreString => '$_score/$totalQuestions';

  /// Returns a fun emoji based on score.
  String get resultEmoji {
    final pct = totalQuestions > 0 ? (score / totalQuestions * 100).round() : 0;
    if (pct == 100) return '🎉';
    if (pct >= 66) return '🌟';
    if (pct >= 33) return '📚';
    return '💡';
  }

  /// Returns an encouragement title based on score.
  String get resultTitle {
    final pct = totalQuestions > 0 ? (score / totalQuestions * 100).round() : 0;
    if (pct == 100) return 'Ma Sha Allah! Perfect!';
    if (pct >= 66) return 'Alhamdulillah! Well Done!';
    if (pct >= 33) return 'SubhanAllah! Good try!';
    return 'In Sha Allah, Next Time!';
  }

  /// Returns an encouragement subtitle based on score.
  String get resultSubtitle {
    final pct = totalQuestions > 0 ? (score / totalQuestions * 100).round() : 0;
    if (pct == 100) return 'You are a knowledge champion! Keep learning!';
    if (pct >= 66) return 'Great effort! You know a lot about Islam!';
    if (pct >= 33) return 'Good start! Read more and try again to improve!';
    return 'Don\'t be discouraged! Every mistake is a lesson. Try again!';
  }
}
