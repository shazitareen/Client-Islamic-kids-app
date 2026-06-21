# deen4kids — Play Store Publishing & Monetization Guide

This document contains key credentials, build output paths, and step-by-step instructions to release **deen4kids** on the Google Play Store and configure monetization.

---

## 🔑 1. App Signing Credentials (Android)

The app is configured for release signing. **Keep these credentials safe.** If you lose the keystore, you will not be able to upload updates to your app.

* **Keystore File Location**: `android/app/upload-keystore.jks`
* **Keystore Configuration File**: `android/key.properties`
* **Key Alias**: `upload`
* **Key Password**: `deen4kids123`
* **Store Password**: `deen4kids123`

*Note: The `key.properties` file is loaded dynamically by `android/app/build.gradle.kts` during compilation.*

---

## 📦 2. Release App Bundle Location

We have compiled the release build using the signing keys. The final package is saved here:
* **Output Path**: `build/app/outputs/bundle/release/app-release.aab`
* **Size**: `110.1 MB`

*This `.aab` (Android App Bundle) file is the exact package you must upload to the Google Play Console.*

---

## 💰 3. Monetization & In-App Purchase Setup Guide

Since deen4kids includes a one-time payment to **"Remove All Ads"**, you must set up Google Play monetization to accept payments.

### Step 1: Set Up Your Merchant Profile (Prerequisite)
A Google Merchant Profile manages your bank account, currency payouts, taxes, and customer refunds.
1. Log in to the [Google Play Console](https://play.google.com/console/).
2. On the left-hand menu, scroll down to **Setup** (or **Developer Account**).
3. Select **Merchant Account** (or go to **Developer Account** -> **Associated developer accounts**).
4. Click **Set up a merchant account** (or **Link a Google payments profile**).
5. Enter your business details, legal name, bank account, and tax information.
6. Once complete, Google will verify your merchant status. **This is required before you can charge money for in-app products.**

### Step 2: Create the In-App Product in the Play Console
Once your Merchant Profile is linked, you must define the product that our Flutter app queries.
1. In Play Console, select your app (**deen4kids**).
2. On the left menu, scroll to the **Monetize** section and select **Products** -> **In-app products**.
3. Click the **Create product** button.
4. Fill in the product settings **exactly** as follows:
   * **Product ID**: `remove_ads_lifetime` *(This must match the ID defined in `lib/services/purchase_service.dart`)*
   * **Name**: Remove All Ads
   * **Description**: Lifetime access to all quizzes, guide tasks, and features completely ad-free. Perfect for children!
5. Set the price (e.g. £1.99, $1.99, or local equivalent).
6. Click **Save** (bottom right) and then click **Activate** to make the product live.

### Step 3: Set Up License Testing (Recommended)
This lets you test the purchase flow on a physical device for free without charging a real credit card.
1. In Play Console, go to **Settings** (or **Developer Account**) -> **License testing**.
2. Add your developer/tester Google Play email addresses to the **License testers** list.
3. Under **License response**, select **RESPOND_NORMALLY**.
4. On your test device, purchase the "Remove Ads" option; Google Play will show a test dialog that completes the purchase instantly and for free.
