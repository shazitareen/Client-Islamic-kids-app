// lib/screens/age_gate_screen.dart
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

/// Neutral age gate shown once on first launch.
/// Required by Google Play Families Policy for mixed-audience apps.
/// Must be visually neutral — no character/animation that appeals only to children.
class AgeGateScreen extends StatelessWidget {
  final StorageService storageService;

  const AgeGateScreen({super.key, required this.storageService});

  Future<void> _proceed(BuildContext context, bool isChild) async {
    await storageService.setAgeGateSeen(isChild);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgCream,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🕌',
                  style: TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Deen4Family',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Islamic Learning for the Whole Family',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Who is using the app?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _ChoiceButton(
                        label: 'I am a Child',
                        icon: Icons.child_care_rounded,
                        color: AppTheme.primaryGreen,
                        onTap: () => _proceed(context, true),
                      ),
                      const SizedBox(height: 12),
                      _ChoiceButton(
                        label: 'I am a Parent or Adult',
                        icon: Icons.person_rounded,
                        color: AppTheme.deepTeal,
                        onTap: () => _proceed(context, false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'This helps us show you the right experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ChoiceButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 22),
        label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 2,
        ),
      ),
    );
  }
}
