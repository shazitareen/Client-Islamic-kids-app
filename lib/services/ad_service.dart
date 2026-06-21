// lib/services/ad_service.dart
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  // Google's official test interstitial ID — only used in debug builds
  static const String _testInterstitialId = 'ca-app-pub-3940256099942544/1033173712';
  static const String _prodInterstitialId = 'ca-app-pub-3461798675611787/6870862384';

  static String get _adMobInterstitialId =>
      kDebugMode ? _testInterstitialId : _prodInterstitialId;

  InterstitialAd? _adMobInterstitialAd;
  bool _isAdMobLoaded = false;
  bool _adsDisabled = false;

  // true = child-safe config (TFCD on); false = standard adult config
  bool _isChildUser = true;

  Future<void> initialize({bool isChildUser = true}) async {
    _isChildUser = isChildUser;
    final RequestConfiguration config = RequestConfiguration(
      tagForChildDirectedTreatment: isChildUser
          ? TagForChildDirectedTreatment.yes
          : TagForChildDirectedTreatment.no,
      tagForUnderAgeOfConsent: isChildUser
          ? TagForUnderAgeOfConsent.yes
          : TagForUnderAgeOfConsent.no,
      maxAdContentRating:
          isChildUser ? MaxAdContentRating.g : MaxAdContentRating.t,
    );
    await MobileAds.instance.updateRequestConfiguration(config);
    debugPrint(
        'AdMob configured: isChild=$isChildUser TFCD=${isChildUser ? "yes" : "no"}');
  }

  void disableAds() {
    _adsDisabled = true;
    _adMobInterstitialAd?.dispose();
    _adMobInterstitialAd = null;
  }

  Future<void> loadAdMobInterstitial() async {
    if (_adsDisabled) return;

    try {
      await InterstitialAd.load(
        adUnitId: _adMobInterstitialId,
        request: AdRequest(
          // Pass child-directed extras when in child mode
          extras: _isChildUser ? {'npa': '1'} : null,
        ),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _adMobInterstitialAd = ad;
            _isAdMobLoaded = true;
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _adMobInterstitialAd = null;
                _isAdMobLoaded = false;
                loadAdMobInterstitial();
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

  Future<void> showAdMobInterstitial() async {
    if (_adsDisabled) return;
    if (!_isAdMobLoaded || _adMobInterstitialAd == null) {
      await loadAdMobInterstitial();
      return;
    }
    await _adMobInterstitialAd!.show();
  }

  void dispose() {
    _adMobInterstitialAd?.dispose();
  }
}
