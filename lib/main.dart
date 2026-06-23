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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  MobileAds.instance.initialize();

  final storageService = await StorageService.create();

  final adService = AdService();
  await adService.initialize();

  final purchaseService = PurchaseService(storageService);
  final notificationService = NotificationService();

  final appProvider = AppProvider(
    adService: adService,
    purchaseService: purchaseService,
    notificationService: notificationService,
    storageService: storageService,
  );
  appProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>.value(value: appProvider),
        ChangeNotifierProvider<QaidahProvider>(
          create: (_) => QaidahProvider(adService),
        ),
        ChangeNotifierProvider<QuizProvider>(
          create: (_) => QuizProvider(storageService, adService),
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: (_) => TasksProvider(storageService),
        ),
      ],
      child: const Deen4FamilyApp(),
    ),
  );
}

class Deen4FamilyApp extends StatelessWidget {
  const Deen4FamilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deen4Family',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
