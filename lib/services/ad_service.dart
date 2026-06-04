// lib/services/ad_service.dart
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Manages AdMob Ads.
/// Uses production ad unit IDs with test device registration for safe testing.
class AdService {
  // ── AdMob IDs ──────────────────────────────────────────────────
  static const String _adMobInterstitialId = 'ca-app-pub-3461798675611787/6870862384';

  InterstitialAd? _adMobInterstitialAd;
  bool _isAdMobLoaded = false;
  bool _adsDisabled = false;

  /// Initializes the ad service
  Future<void> initialize() async {
    final RequestConfiguration requestConfiguration = RequestConfiguration(
      tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
      tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
      maxAdContentRating: MaxAdContentRating.g,
    );
    await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
    debugPrint('AdMob kids policy configuration initialized: TFCD=yes, MaxRating=G');
  }

  /// Call this once ads are purchased to stop showing them.
  void disableAds() {
    _adsDisabled = true;
    _adMobInterstitialAd?.dispose();
    _adMobInterstitialAd = null;
  }

  // ── AdMob Interstitial ──────────────────────────────────────────
  /// Pre-loads an AdMob interstitial ad.
  Future<void> loadAdMobInterstitial() async {
    if (_adsDisabled) return;

    try {
      await InterstitialAd.load(
        adUnitId: _adMobInterstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _adMobInterstitialAd = ad;
            _isAdMobLoaded = true;
            debugPrint('AdMob Interstitial loaded');

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _adMobInterstitialAd = null;
                _isAdMobLoaded = false;
                loadAdMobInterstitial(); // Pre-load next
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                _adMobInterstitialAd = null;
                _isAdMobLoaded = false;
                loadAdMobInterstitial();
              },
            );
          },
          onAdFailedToLoad: (error) {
            debugPrint('AdMob Interstitial failed to load: $error');
            _isAdMobLoaded = false;
          },
        ),
      );
    } catch (e) {
      debugPrint('Exception while loading AdMob Interstitial: $e');
      _isAdMobLoaded = false;
    }
  }

  /// Shows the AdMob interstitial ad (used in Qaidah Quiz and Islamic Quiz)
  Future<void> showAdMobInterstitial() async {
    if (_adsDisabled) return;
    if (!_isAdMobLoaded || _adMobInterstitialAd == null) {
      debugPrint('AdMob not ready — loading fresh one');
      await loadAdMobInterstitial();
      return;
    }
    await _adMobInterstitialAd!.show();
  }

  /// Clean up resources
  void dispose() {
    _adMobInterstitialAd?.dispose();
  }
}
