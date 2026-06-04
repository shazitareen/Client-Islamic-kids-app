// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'providers/app_provider.dart';
import 'providers/qaidah_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/tasks_provider.dart';
import 'services/ad_service.dart';
import 'services/notification_service.dart';
import 'services/purchase_service.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';

/// Entry point — initialises all services before running the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode (better for kids)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialise AdMob SDK in background
  MobileAds.instance.initialize();

  // Initialise storage (this is fast, safe to await)
  final storageService = await StorageService.create();

  // Wire up services
  final adService = AdService();
  await adService.initialize();
  final purchaseService = PurchaseService(storageService);
  final notificationService = NotificationService();

  // Create AppProvider and initialise everything
  final appProvider = AppProvider(
    adService: adService,
    purchaseService: purchaseService,
    notificationService: notificationService,
    storageService: storageService,
  );
  
  // Fire and forget: do not await so it doesn't block runApp
  appProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        // App-wide provider (ads, purchases, notifications)
        ChangeNotifierProvider<AppProvider>.value(value: appProvider),

        // Qaidah Quiz provider — gets adService injected
        ChangeNotifierProvider<QaidahProvider>(
          create: (_) => QaidahProvider(adService),
        ),

        // Islamic Quiz provider
        ChangeNotifierProvider<QuizProvider>(
          create: (_) => QuizProvider(storageService, adService),
        ),

        // Daily Tasks provider
        ChangeNotifierProvider<TasksProvider>(
          create: (_) => TasksProvider(storageService),
        ),
      ],
      child: const IslamicKidsApp(),
    ),
  );
}

class IslamicKidsApp extends StatelessWidget {
  const IslamicKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'deen4kids',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
