// lib/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized color palette and theme configuration.
/// Uses a soft, toddler-friendly "Playful Pastels" palette.
class AppTheme {
  // ── Brand Colors ────────────────────────────────────────────────
  // Modern pastel/vibrant palette
  static const Color primaryGreen = Color(0xFFA8E6CF);   // Soft Mint Green
  static const Color lightGreen = Color(0xFFC8F0DF);
  static const Color accentGold = Color(0xFFFFDFBA);     // Pastel Yellow
  static const Color deepTeal = Color(0xFFBAE1FF);       // Sky Blue 
  static const Color skyBlue = Color(0xFFD4E6F1);        // Lighter Sky
  static const Color softPurple = Color(0xFFE1BEE7);     // Pastel Purple
  static const Color warmOrange = Color(0xFFFFCCB6);     // Soft Peach/Orange
  static const Color bgCream = Color(0xFFFFFDD0);        // Creamy White
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color bubblegumPink = Color(0xFFFFC6FF);  // Soft Pink

  // ── Answer Colors ───────────────────────────────────────────────
  static const Color correctGreen = Color(0xFF81C784);   // Muted Correct Green
  static const Color wrongRed = Color(0xFFFF8A80);   // Soft pastel red for feedback
  static const Color neutralGrey = Color(0xFFF5F5F5);
  static const Color selectedBlue = Color(0xFF90CAF9);

  // ── Module Gradient Colors (Vibrant & Playful) ──────────────────
  static const List<Color> qaidahGradient = [Color(0xFFB9F6CA), Color(0xFFA8E6CF)];
  static const List<Color> islamicQuizGradient = [Color(0xFFBBDEFB), Color(0xFF90CAF9)];
  static const List<Color> dailyTasksGradient = [Color(0xFFFFF9C4), Color(0xFFFFE082)];
  
  static const List<Color> qaidahGradientGreen = qaidahGradient;
  static const List<Color> islamicQuizGradientTeal = islamicQuizGradient;
  static const List<Color> dailyTasksGradientPurple = dailyTasksGradient;

  static ThemeData get theme {
    final baseTextTheme = GoogleFonts.quicksandTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
      ),
      textTheme: baseTextTheme,
      scaffoldBackgroundColor: bgCream,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: GoogleFonts.quicksand(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 4,
          shadowColor: Colors.black12,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
  }
}
