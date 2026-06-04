// lib/screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Screen displaying the Privacy Policy for deen4kids.
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
                          'At deen4kids, we are committed to providing a safe, clean, and private environment for children to learn about Islam.',
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

                // 1. Data Collection Section
                _buildPolicyCard(
                  title: '1. No Personal Data Collected ❌',
                  content:
                      'We do NOT collect, request, or store any personal information from children or parents. You do not need to register, log in, or enter details such as name, email, address, or phone number to use this app.',
                ),
                const SizedBox(height: 12),

                // 2. Local Storage Section
                _buildPolicyCard(
                  title: '2. 100% Offline Storage 💾',
                  content:
                      'All your progress (quiz scores, completed daily tasks, and sound settings) is saved locally on your own device using SharedPreferences. This information is never sent to any external server and never shared with anyone.',
                ),
                const SizedBox(height: 12),

                // 3. Child-Safe Advertisements Section
                _buildPolicyCard(
                  title: '3. Child-Safe Advertising (COPPA) 👶',
                  content:
                      'We show occasional advertisements to help fund the app. To make this safe for children:\n'
                      '• We strictly flag all ad requests for "Child-Directed Treatment" (COPPA/GDPR-K compliant).\n'
                      '• We limit ad content to a maximum rating of General Audience ("G").\n'
                      '• Personalised tracking, behavioral advertising, and profiling are fully disabled.',
                ),
                const SizedBox(height: 12),

                // 4. External Links & Purchases Section
                _buildPolicyCard(
                  title: '4. Parental Gate Protection 🔒',
                  content:
                      'Any action that could lead to financial transaction (like the one-time "Remove All Ads" purchase) or restoration of purchases is fully protected by a Parental Gate math challenge. This ensures that children cannot accidentally trigger purchases or exit the app flow.',
                ),
                const SizedBox(height: 12),

                // 5. Contact Section
                _buildPolicyCard(
                  title: '5. Questions or Support? 📧',
                  content:
                      'If you have any questions or feedback about our app or privacy practices, parents are welcome to contact the developer (Cilatrix) at:\n'
                      '• Email: cilatrix@gmail.com\n\n'
                      'Thank you for trusting deen4kids to be a part of your child\'s Islamic learning journey!',
                ),
                const SizedBox(height: 20),

                // Footer Text
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
