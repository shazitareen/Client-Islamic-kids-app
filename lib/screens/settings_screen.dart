// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_theme.dart';
import '../providers/app_provider.dart';
import 'privacy_policy_screen.dart';

/// Settings screen — handles Remove Ads purchase and restore.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings ⚙️'),
            backgroundColor: AppTheme.primaryGreen,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ── Remove Ads Section ────────────────────────────
                  _sectionHeader('Ads & Premium'),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.block, color: Colors.orange),
                          title: const Text(
                            'Remove All Ads',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            appProvider.adsRemoved
                                ? '✅ Purchased — Ads are removed!'
                                : appProvider.purchaseService.product != null
                                    ? 'One-time: ${appProvider.purchaseService.product!.price}'
                                    : 'Loading price...',
                          ),
                          trailing: appProvider.adsRemoved
                              ? const Icon(Icons.check_circle,
                                  color: AppTheme.correctGreen)
                              : ElevatedButton(
                                  onPressed: appProvider.isPurchasePending
                                      ? null
                                      : () => appProvider.purchaseRemoveAds(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.accentGold,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: appProvider.isPurchasePending
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2))
                                      : const Text('Buy',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.restore, color: Colors.blue),
                          title: const Text('Restore Purchase'),
                          subtitle:
                              const Text('Already bought? Tap to restore.'),
                          onTap: () => appProvider.restorePurchases(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Daily Reminders Section ───────────────────────
                  _sectionHeader('Reminders'),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        SwitchListTile(
                          secondary: const Icon(Icons.notifications_active, color: Colors.purple),
                          title: const Text(
                            'Daily Reminder',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Get daily reminders to complete habits'),
                          activeThumbColor: AppTheme.primaryGreen,
                          value: appProvider.notificationsEnabled,
                          onChanged: (value) => appProvider.toggleNotifications(value, context),
                        ),
                        if (appProvider.notificationsEnabled) ...[
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.access_time, color: Colors.amber),
                            title: const Text('Reminder Time', style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Currently set for ${TimeOfDay(hour: appProvider.notificationHour, minute: appProvider.notificationMinute).format(context)}'),
                            trailing: const Icon(Icons.edit, size: 18),
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: appProvider.notificationHour,
                                  minute: appProvider.notificationMinute,
                                ),
                              );
                              if (picked != null && context.mounted) {
                                appProvider.updateNotificationTime(picked, context);
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── User Profile Section ──────────────────────────
                  _sectionHeader('Profile'),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: const Icon(Icons.switch_account_rounded, color: Colors.deepPurple),
                      title: const Text('Switch User Type',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('Change between Child and Adult mode'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            title: const Text('Who is using the app?'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.child_care, color: AppTheme.primaryGreen),
                                  title: const Text('Child'),
                                  onTap: () async {
                                    await prefs.setBool('is_child_user', true);
                                    if (!ctx.mounted) return;
                                    Navigator.pop(ctx);
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                      const SnackBar(content: Text('Switched to Child mode')),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.person, color: AppTheme.deepTeal),
                                  title: const Text('Parent / Adult'),
                                  onTap: () async {
                                    await prefs.setBool('is_child_user', false);
                                    if (!ctx.mounted) return;
                                    Navigator.pop(ctx);
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                      const SnackBar(content: Text('Switched to Adult mode')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── About Section ─────────────────────────────────
                  _sectionHeader('About'),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.info_outline, color: Colors.teal),
                          title: Text('Version',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text('2.0.0',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        const Divider(height: 1),
                              const ListTile(
                          leading: Icon(Icons.family_restroom, color: Colors.pink),
                          title: Text('Designed for',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Muslim families — children & adults'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.shield_outlined, color: Colors.blueAccent),
                          title: const Text('Privacy Policy',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text(
                              'Read our data and privacy commitment'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PrivacyPolicyScreen()),
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading:
                              const Icon(Icons.favorite, color: Colors.redAccent),
                          title: const Text('Made with ❤️ for the Ummah',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text(
                              'Help your children grow closer to Allah'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
