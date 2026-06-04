// lib/models/arabic_letter.dart

/// Represents a single Arabic letter with its name and associated Quran words.
class ArabicLetter {
  final String id;           // Unique ID for internal use (e.g. "alif", "ba")
  final String letter;       // The Arabic character e.g. "ا"
  final String name;         // English name e.g. "Alif"
  final String pronunciation; // How to pronounce e.g. "A"
  final List<String> quranWords; // Words from the Quran that contain this letter

  const ArabicLetter({
    required this.id,
    required this.letter,
    required this.name,
    required this.pronunciation,
    required this.quranWords,
  });

  String get audioPath => 'sounds/$id.mp3';
}
