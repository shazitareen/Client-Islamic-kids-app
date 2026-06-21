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
import 'screens/age_gate_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  MobileAds.instance.initialize();

  final storageService = await StorageService.create();

  // Determine user type before initialising ads so config is correct from the start
  final isChildUser = storageService.isChildUser();

  final adService = AdService();
  await adService.initialize(isChildUser: isChildUser);

  final purchaseService = PurchaseService(storageService);
  final notificationService = NotificationService();

  final appProvider = AppProvider(
    adService: adService,
    purchaseService: purchaseService,
    notificationService: notificationService,
    storageService: storageService,
  );
  appProvider.initialize();

  // Show age gate on very first launch; route directly to home otherwise
  final showAgeGate = !storageService.hasSeenAgeGate();

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
      child: Deen4FamilyApp(
        showAgeGate: showAgeGate,
        storageService: storageService,
      ),
    ),
  );
}

class Deen4FamilyApp extends StatelessWidget {
  final bool showAgeGate;
  final StorageService storageService;

  const Deen4FamilyApp({
    super.key,
    required this.showAgeGate,
    required this.storageService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deen4Family',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: showAgeGate
          ? AgeGateScreen(storageService: storageService)
          : const HomeScreen(),
    );
  }
}
