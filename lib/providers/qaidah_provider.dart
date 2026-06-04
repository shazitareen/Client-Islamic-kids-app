// lib/providers/qaidah_provider.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/arabic_letter.dart';
import '../data/arabic_letters_data.dart';
import '../services/ad_service.dart';

/// Manages the state for the Qaidah Quiz module.
enum AnswerState { unanswered, correct, wrong }

class QaidahProvider extends ChangeNotifier {
  final AdService _adService;
  final Random _random = Random();

  List<ArabicLetter> _letters = [];
  int _currentIndex = 0;
  List<String> _options = [];
  int? _selectedOptionIndex;
  AnswerState _answerState = AnswerState.unanswered;
  int _questionsAnswered = 0;
  int _correctAnswers = 0;
  int _correctOptionIndex = 0;
  bool _adsDisabled = false;
  bool _isQuizzing = false;

  // Getters
  bool get isQuizzing => _isQuizzing;
  ArabicLetter? get currentLetter =>
      _letters.isNotEmpty && _currentIndex < _letters.length ? _letters[_currentIndex] : null;
  List<String> get options => _options;
  int? get selectedOptionIndex => _selectedOptionIndex;
  AnswerState get answerState => _answerState;
  int get correctAnswers => _correctAnswers;
  int get questionsAnswered => _questionsAnswered;
  int get correctOptionIndex => _correctOptionIndex;
  int get totalQuestions => _letters.length;
  bool get isComplete => _currentIndex >= _letters.length;

  /// Returns a fun emoji based on score percentage.
  String get resultEmoji {
    final pct = totalQuestions > 0 ? (correctAnswers / totalQuestions * 100).round() : 0;
    if (pct == 100) return '🎉';
    if (pct >= 66) return '🌟';
    if (pct >= 33) return '📚';
    return '💡';
  }

  /// Returns an encouragement title based on score.
  String get resultTitle {
    final pct = totalQuestions > 0 ? (correctAnswers / totalQuestions * 100).round() : 0;
    if (pct == 100) return 'Ma Sha Allah! Perfect!';
    if (pct >= 66) return 'Alhamdulillah! Well Done!';
    if (pct >= 33) return 'SubhanAllah! Good try!';
    return 'In Sha Allah, Next Time!';
  }

  /// Returns an encouragement subtitle based on score.
  String get resultSubtitle {
    final pct = totalQuestions > 0 ? (correctAnswers / totalQuestions * 100).round() : 0;
    if (pct == 100) return 'You got everything right! You are becoming a Quran star!';
    if (pct >= 66) return 'Good job! Just a little more practice to get them all!';
    if (pct >= 33) return 'You\'re learning! Try again to see if you can get more correct.';
    return 'Don\'t worry! Try again and pay close attention to the letters.';
  }

  QaidahProvider(this._adService);

  /// Shuffles the letters and prepares a short 3-question game session.
  void startQuiz({bool disableAds = false}) {
    _adsDisabled = disableAds;
    _isQuizzing = true;
    // Pick 3 random letters for a short session
    _letters = (List<ArabicLetter>.from(arabicLettersData)..shuffle(_random)).take(3).toList();
    _currentIndex = 0;
    _questionsAnswered = 0;
    _correctAnswers = 0;
    _answerState = AnswerState.unanswered;
    _selectedOptionIndex = null;
    _generateOptions();
    notifyListeners();
  }

  /// Starts a 3-question quiz specifically for one letter.
  void startLetterSpecificQuiz(ArabicLetter letter, {bool disableAds = false}) {
    _adsDisabled = disableAds;
    _isQuizzing = true;
    // We create a session of 3 questions all about the SAME letter
    _letters = [letter, letter, letter];
    _currentIndex = 0;
    _questionsAnswered = 0;
    _correctAnswers = 0;
    _answerState = AnswerState.unanswered;
    _selectedOptionIndex = null;
    _generateOptions();
    notifyListeners();
  }

  /// Toggles between Grid view and Quiz view.
  void setQuizzing(bool value) {
    _isQuizzing = value;
    notifyListeners();
  }

  /// Resets everything back to the letter selection grid.
  void resetToSelection() {
    _isQuizzing = false;
    _currentIndex = 0;
    _questionsAnswered = 0;
    _correctAnswers = 0;
    _answerState = AnswerState.unanswered;
    _selectedOptionIndex = null;
    _letters = [];
    notifyListeners();
  }

  /// Generates 4 multiple-choice word options for the current letter.
  /// One correct answer (a Quran word containing the letter),
  /// three distractors from other letters' words.
  void _generateOptions() {
    if (_letters.isEmpty || _currentIndex >= _letters.length) return;

    final letter = _letters[_currentIndex];

    // Pick one correct word from this letter's Quran words
    final correctWord = letter.quranWords[_random.nextInt(letter.quranWords.length)];

    // Pick 3 distractor words from OTHER letters
    final distractors = <String>[];
    final otherLetters = arabicLettersData
        .where((l) => l.letter != letter.letter)
        .toList()
      ..shuffle(_random);

    for (final other in otherLetters) {
      if (distractors.length >= 3) break;
      final word = other.quranWords[_random.nextInt(other.quranWords.length)];
      if (!distractors.contains(word)) {
        distractors.add(word);
      }
    }

    // Combine and shuffle all 4 options
    final allOptions = [correctWord, ...distractors]..shuffle(_random);
    _options = allOptions;
    _correctOptionIndex = allOptions.indexOf(correctWord);
  }

  /// Called when the user taps an answer.
  Future<void> selectAnswer(int index) async {
    if (_answerState != AnswerState.unanswered) return;

    _selectedOptionIndex = index;
    _answerState =
        index == _correctOptionIndex ? AnswerState.correct : AnswerState.wrong;
    _questionsAnswered++;
    if (_answerState == AnswerState.correct) _correctAnswers++;

    notifyListeners();
  }

  /// Advances to the next letter. Shows an AdMob ad if the session is complete.
  Future<void> nextLetter() async {
    _currentIndex++;
    _answerState = AnswerState.unanswered;
    _selectedOptionIndex = null;

    if (isComplete) {
      // Show AdMob interstitial ad when the 3-question game finishes
      if (!_adsDisabled) {
        await _adService.showAdMobInterstitial();
      }
    } else {
      _generateOptions();
    }

    notifyListeners();
  }

  /// Resets the quiz to the beginning for a new game loop.
  void reset() {
    startQuiz(disableAds: _adsDisabled);
  }
}
