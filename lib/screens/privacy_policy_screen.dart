// lib/screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Screen displaying the Privacy Policy for Deen4Family.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy 🛡️'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Header Card
                Card(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(color: AppTheme.primaryGreen, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(Icons.shield_rounded, size: 50, color: Colors.teal),
                        const SizedBox(height: 12),
                        const Text(
                          'Our Privacy Promise',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'At Deen4Family, we are committed to providing a safe, clean, and private environment for the whole family to learn about Islam.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _buildPolicyCard(
                  title: '1. No Personal Data Collected ❌',
                  content:
                      'We do NOT collect, request, or store any personal information. You do not need to register, log in, or enter any details such as name, email, address, or phone number to use this app.',
                ),
                const SizedBox(height: 12),

                _buildPolicyCard(
                  title: '2. Local Storage Only 💾',
                  content:
                      'All your progress (quiz scores, completed daily tasks, and settings) is saved locally on your own device. This information is never sent to any external server and never shared with anyone.',
                ),
                const SizedBox(height: 12),

                _buildPolicyCard(
                  title: '3. Advertisements 📢',
                  content:
                      'We show occasional interstitial advertisements to help fund the app. Ads are served by Google AdMob for a general audience. You can permanently remove all ads with a one-time in-app purchase available in Settings.',
                ),
                const SizedBox(height: 12),

                _buildPolicyCard(
                  title: '4. In-App Purchases 💳',
                  content:
                      'The only available purchase is a one-time "Remove All Ads" option. All transactions are processed securely through Google Play Billing. We do not handle or store any payment information.',
                ),
                const SizedBox(height: 12),

                _buildPolicyCard(
                  title: '5. Third-Party Services 🔗',
                  content:
                      'This app uses the following third-party services:\n'
                      '• Google AdMob — for displaying ads\n'
                      '• Google Play Billing — for in-app purchases\n'
                      '• Quran API (alquran.cloud) — to fetch Quran text\n\n'
                      'These services have their own privacy policies. We do not control the data practices of these providers.',
                ),
                const SizedBox(height: 12),

                _buildPolicyCard(
                  title: '6. Questions or Support? 📧',
                  content:
                      'If you have any questions or feedback about our app or privacy practices, please contact us at:\n'
                      '• Email: shazikhantareen@gmail.com\n\n'
                      'Thank you for trusting Deen4Family as part of your Islamic learning journey!',
                ),
                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'Last Updated: June 2026',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyCard({required String title, required String content}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
