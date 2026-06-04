# Play Store Readiness & Kid-Friendly Settings

This plan describes how we will make the app fully ready for publishing on the Google Play Store under the name **deen4kids** (package name: `com.cilatrix.deen4kids`). 

Key improvements include:
1. **Upgrading SDK version to 36** (Android 16 compatibility) and setting minSdk/targetSdk accordingly.
2. **Branding Updates**: Renaming the app package name and display name to `deen4kids` / `com.cilatrix.deen4kids` across Android and iOS.
3. **Kids App Compliance (Google Play Families Policy & COPPA)**:
   - Configuring Google Mobile Ads (AdMob) to enforce child-directed treatment (TFCD) and limit ad content rating to General Audience (G).
   - Removing the `SCHEDULE_EXACT_ALARM` permission from `AndroidManifest.xml` since it is restricted on Google Play for kids' apps and not required for our inexact daily reminders.
   - Implementing a **Parental Gate** that pops up for purchases and setting changes so that children do not make accidental modifications.
   - Creating a dedicated, beautiful **In-App Privacy Policy screen** (fully readable offline) detailing our zero-data-collection policy.
4. **Settings Page Enhancements**: Adding user settings for daily reminders (toggle notification on/off, change daily time) using existing provider actions.

---

## User Review Required

> [!IMPORTANT]
> - **Package ID Rename**: Renaming the package ID to `com.cilatrix.deen4kids` means that once uploaded to the Play Store, it will occupy that specific package namespace.
> - **Internal Dart Names**: The Flutter internal package name `islamic_kids_app` will remain unchanged in code imports (via `pubspec.yaml`) to avoid touching hundreds of relative import statements. Only the Android application package/ID (`com.cilatrix.deen4kids`) and visible app names will be updated. This is standard practice and perfectly correct for store compilation.

---

## Proposed Changes

### Android Project Configuration

#### [MODIFY] [build.gradle.kts](file:///d:/android%20projects/Client%20Islamic%20kids%20app/android/app/build.gradle.kts)
- Change `namespace` to `"com.cilatrix.deen4kids"`.
- Change `applicationId` to `"com.cilatrix.deen4kids"`.
- Set `compileSdk = 36` and `targetSdk = 36`.

#### [MODIFY] [AndroidManifest.xml](file:///d:/android%20projects/Client%20Islamic%20kids%20app/android/app/src/main/AndroidManifest.xml)
- Change `android:label` in `<application>` to `"deen4kids"`.
- Remove `<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>` to comply with exact alarm restrictions.

#### [NEW] [MainActivity.kt](file:///d:/android%20projects/Client%20Islamic%20kids%20app/android/app/src/main/kotlin/com/cilatrix/deen4kids/MainActivity.kt)
- Create a new Kotlin activity under the correct package namespace path `com/cilatrix/deen4kids` containing `package com.cilatrix.deen4kids`.

#### [DELETE] [MainActivity.kt](file:///d:/android%20projects/Client%20Islamic%20kids%20app/android/app/src/main/kotlin/com/example/islamic_kids_app/MainActivity.kt)
- Delete the old package folder structure `com/example/islamic_kids_app` and MainActivity files.

---

### iOS Project Configuration (For Alignment)

#### [MODIFY] [Info.plist](file:///d:/android%20projects/Client%20Islamic%20kids%20app/ios/Runner/Info.plist)
- Change `<key>CFBundleDisplayName</key>` value to `deen4kids`.
- Change `<key>CFBundleName</key>` value to `deen4kids`.

#### [MODIFY] [project.pbxproj](file:///d:/android%20projects/Client%20Islamic%20kids%20app/ios/Runner.xcodeproj/project.pbxproj)
- Change `PRODUCT_BUNDLE_IDENTIFIER` instances from `com.example.islamicKidsApp` to `com.cilatrix.deen4kids`.

---

### Dart Codebase & Settings

#### [MODIFY] [main.dart](file:///d:/android%20projects/Client%20Islamic%20kids%20app/lib/main.dart)
- Change the `MaterialApp` title parameter to `'deen4kids'`.

#### [MODIFY] [home_screen.dart](file:///d:/android%20projects/Client%20Islamic%20kids%20app/lib/screens/home_screen.dart)
- Update visual title text from `🕌 Islamic Kids` to `🕌 Deen4Kids`.
- Wrap Home Screen purchase buttons with the new parental gate verification.

#### [MODIFY] [ad_service.dart](file:///d:/android%20projects/Client%20Islamic%20kids%20app/lib/services/ad_service.dart)
- In the `initialize` / ad load processes, update request configuration using `RequestConfiguration` to set child-directed tagging:
  ```dart
  RequestConfiguration configuration = RequestConfiguration(
    tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
    tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
    maxAdContentRating: MaxAdContentRating.g,
  );
  MobileAds.instance.updateRequestConfiguration(configuration);
  ```

#### [MODIFY] [settings_screen.dart](file:///d:/android%20projects/Client%20Islamic%20kids%20app/lib/screens/settings_screen.dart)
- Add a new "Daily Reminders" configuration section containing:
    - Notification toggle switch (using `appProvider.toggleNotifications`).
    - Time-picker selector tile (using `appProvider.updateNotificationTime`).
- Add a "Privacy Policy" button that navigates to the local Privacy Policy screen.
- Wrap the Ad-removal and Restore purchase buttons with the parental gate.

#### [NEW] [parental_gate.dart](file:///d:/android%20projects/Client%20Islamic%20kids%20app/lib/widgets/parental_gate.dart)
- Create a beautiful kid-safe verification dialog that requests solving a simple math challenge (e.g. `15 + 6 = ?`) to verify parent permission.

#### [NEW] [privacy_policy_screen.dart](file:///d:/android%20projects/Client%20Islamic%20kids%20app/lib/screens/privacy_policy_screen.dart)
- Create a local, stylized, offline-accessible screen displaying the Privacy Policy for `deen4kids` by Cilatrix.

---

## Verification Plan

### Automated Verification
- Run `flutter analyze` to ensure code syntax is completely free of errors.
- Run `flutter build apk` to confirm that the package renames, gradle compilation SDK 36 upgrade, and manifests compile successfully into a release-ready APK.

### Manual Verification
- Launch the application and navigate to Settings.
- Verify that clicking "Remove All Ads" prompts the Parental Gate dialog. Test wrong answers (displays error) and the correct answer (initiates purchase).
- Verify that daily reminder configuration works (toggling on/off, updating time).
- Verify that the Privacy Policy screen opens and displays correct information matching the Google Play Families requirements.
