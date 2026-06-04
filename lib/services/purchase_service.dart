// lib/services/purchase_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'storage_service.dart';

/// Manages the one-time "Remove Ads" in-app purchase.
/// Handles purchase, restore, and persisting the purchase state.
class PurchaseService {
  // TODO: Set this to your exact product ID created in Google Play Console
  static const String removeAdsProductId = 'remove_ads_lifetime';

  final StorageService _storage;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  bool _isAvailable = false;
  bool _purchasePending = false;
  ProductDetails? _removeAdsProduct;

  /// Callback fired when purchase is verified and completed
  VoidCallback? onPurchaseSuccess;
  VoidCallback? onPurchaseFailed;

  PurchaseService(this._storage);

  bool get isAvailable => _isAvailable;
  bool get purchasePending => _purchasePending;
  ProductDetails? get product => _removeAdsProduct;

  /// Initialise the purchase stream and check store availability.
  Future<void> initialize() async {
    _isAvailable = await _inAppPurchase.isAvailable();
    if (!_isAvailable) {
      debugPrint('In-app purchases not available on this device');
      return;
    }

    // Listen to purchase updates
    _purchaseSubscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onError: (error) => debugPrint('Purchase stream error: $error'),
    );

    // Load product details from Play Store
    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final response = await _inAppPurchase.queryProductDetails({removeAdsProductId});
    if (response.error != null) {
      debugPrint('Error loading products: ${response.error}');
      return;
    }
    if (response.productDetails.isNotEmpty) {
      _removeAdsProduct = response.productDetails.first;
      debugPrint('Product loaded: ${_removeAdsProduct!.title} — ${_removeAdsProduct!.price}');
    }
  }

  /// Initiates the purchase flow for "Remove Ads"
  Future<void> buyRemoveAds() async {
    if (_removeAdsProduct == null) {
      debugPrint('Product not loaded yet');
      return;
    }
    _purchasePending = true;
    final purchaseParam = PurchaseParam(productDetails: _removeAdsProduct!);
    // Non-consumable purchase (one-time)
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Restores previous purchases (e.g. after reinstall)
  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.productID == removeAdsProductId) {
        if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          _verifyAndComplete(purchase);
        } else if (purchase.status == PurchaseStatus.error) {
          _purchasePending = false;
          onPurchaseFailed?.call();
        } else if (purchase.status == PurchaseStatus.canceled) {
          _purchasePending = false;
        }
      }

      // Always complete pending purchases
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  Future<void> _verifyAndComplete(PurchaseDetails purchase) async {
    // In production, verify server-side. For now, trust Play Store.
    await _storage.setAdsRemoved(true);
    _purchasePending = false;
    debugPrint('Remove ads purchase verified and saved!');
    onPurchaseSuccess?.call();
  }

  void dispose() {
    _purchaseSubscription?.cancel();
  }
}
