// lib/providers/app_provider.dart
import 'package:flutter/material.dart';
import '../services/ad_service.dart';
import '../services/purchase_service.dart';
import '../services/notification_service.dart';
import '../services/storage_service.dart';

/// Top-level provider that manages cross-cutting concerns:
/// ads, purchases, notifications. Initialised once at app startup.
class AppProvider extends ChangeNotifier {
  final AdService adService;
  final PurchaseService purchaseService;
  final NotificationService notificationService;
  final StorageService storageService;

  bool _adsRemoved = false;
  bool _isPurchasePending = false;
  bool _notificationsEnabled = false;
  int _notificationHour = 7;
  int _notificationMinute = 0;

  bool get adsRemoved => _adsRemoved;
  bool get isPurchasePending => _isPurchasePending;
  bool get notificationsEnabled => _notificationsEnabled;
  int get notificationHour => _notificationHour;
  int get notificationMinute => _notificationMinute;

  AppProvider({
    required this.adService,
    required this.purchaseService,
    required this.notificationService,
    required this.storageService,
  });

  /// Called once during app startup to initialise all services.
  Future<void> initialize() async {
    // Check saved ad-removal state
    _adsRemoved = storageService.isAdsRemoved();
    if (_adsRemoved) {
      adService.disableAds();
    } else {
      // Pre-load first ad (do not await, so it doesn't block startup)
      adService.loadAdMobInterstitial();
    }

    // Initialise purchase service
    await purchaseService.initialize();
    purchaseService.onPurchaseSuccess = _onPurchaseSuccess;
    purchaseService.onPurchaseFailed = _onPurchaseFailed;

    // Initialise notifications
    await notificationService.initialize();
    
    _notificationHour = storageService.getNotificationHour();
    _notificationMinute = storageService.getNotificationMinute();

    // Schedule daily reminder by default
    await notificationService.scheduleDailyReminder(
        hour: _notificationHour, minute: _notificationMinute);
    _notificationsEnabled = true;

    notifyListeners();
  }

  void _onPurchaseSuccess() {
    _adsRemoved = true;
    _isPurchasePending = false;
    adService.disableAds();
    notifyListeners();
  }

  void _onPurchaseFailed() {
    _isPurchasePending = false;
    notifyListeners();
  }

  /// Initiates the Remove Ads purchase flow.
  Future<void> purchaseRemoveAds(BuildContext context) async {
    if (!purchaseService.isAvailable) {
      _showSnack(context, 'Purchases not available on this device');
      return;
    }
    if (purchaseService.product == null) {
      _showSnack(context, 'Store product not configured yet (test mode or missing ID).');
      return;
    }
    _isPurchasePending = true;
    notifyListeners();
    await purchaseService.buyRemoveAds();
  }

  /// Restores previous purchases (e.g. after reinstall).
  Future<void> restorePurchases(BuildContext context) async {
    await purchaseService.restorePurchases();
    if (!context.mounted) return;
    _showSnack(context, 'Checking for previous purchases...');
  }

  /// Toggles daily notification on/off.
  Future<void> toggleNotifications(bool enabled, BuildContext context) async {
    _notificationsEnabled = enabled;
    if (enabled) {
      await notificationService.requestPermissions();
      await notificationService.scheduleDailyReminder(
          hour: _notificationHour, minute: _notificationMinute);
      if (!context.mounted) return;
      
      final timeStr = TimeOfDay(hour: _notificationHour, minute: _notificationMinute).format(context);
      _showSnack(context, '✅ Daily reminder set for $timeStr');
    } else {
      await notificationService.cancelDailyReminder();
      if (!context.mounted) return;
      _showSnack(context, 'Daily reminder cancelled');
    }
    notifyListeners();
  }

  /// Updates the time for daily notifications
  Future<void> updateNotificationTime(TimeOfDay newTime, BuildContext context) async {
    _notificationHour = newTime.hour;
    _notificationMinute = newTime.minute;
    await storageService.setNotificationTime(newTime.hour, newTime.minute);

    if (_notificationsEnabled) {
      await notificationService.scheduleDailyReminder(
          hour: newTime.hour, minute: newTime.minute);
      if (!context.mounted) return;
      _showSnack(context, '✅ Daily reminder updated to ${newTime.format(context)}');
    }
    notifyListeners();
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    adService.dispose();
    purchaseService.dispose();
    super.dispose();
  }
}
