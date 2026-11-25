import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:hotel/src/core/services/billing/subscription_billing_error_helper.dart';
import 'package:hotel/src/core/services/billing/subscription_entitlement_storage.dart';
import 'package:hotel/src/core/services/billing/subscription_plan.dart';
import 'package:hotel/src/core/services/billing/subscription_purchase_validator.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

/// iOS (and future Android) in-app purchase coordinator.
class SubscriptionService extends ChangeNotifier {
  SubscriptionService(this._storage);

  final SubscriptionEntitlementStorage _storage;
  final InAppPurchase _iap = InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _purchaseSub;
  _SubscriptionLifecycleObserver? _lifecycleObserver;
  bool _initialized = false;
  bool _isSyncingEntitlements = false;
  bool _hadPremiumBeforeEntitlementSync = false;
  bool _isStoreAvailable = false;
  bool _isLoadingProducts = false;
  bool _isPurchasing = false;
  bool _isRestoring = false;
  bool _storeUnavailable = false;
  String? _lastError;

  bool _premiumActive = false;
  bool _lifetimeActive = false;
  String? _activePlanLabel;
  String? _activeProductId;
  DateTime? _expiresAt;

  List<SubscriptionPlan> _plans = SubscriptionPlan.catalog();

  bool get hasPremiumAccess {
    if (!AppBillingConfig.requiresPremium) return true;
    return SubscriptionPurchaseValidator.isCachedEntitlementActive(
      premiumActive: _premiumActive,
      lifetime: _lifetimeActive,
      expiresAt: _expiresAt,
    );
  }

  bool get isSyncingEntitlements => _isSyncingEntitlements;

  /// True while StoreKit refresh runs if the user was premium before sync started.
  bool get hadPremiumBeforeEntitlementSync => _hadPremiumBeforeEntitlementSync;
  bool get isLifetimeActive => _lifetimeActive;
  bool get isStoreAvailable => _isStoreAvailable;
  bool get isLoadingProducts => _isLoadingProducts;
  bool get isPurchasing => _isPurchasing;
  bool get isRestoring => _isRestoring;
  bool get storeUnavailable => _storeUnavailable;
  String? get lastError => _lastError;
  String? get activePlanLabel => _activePlanLabel;
  String? get activeProductId => _activeProductId;
  DateTime? get subscriptionExpiresAt => _expiresAt;

  SubscriptionPlanKind? get activePlanKind {
    if (!hasPremiumAccess) return null;
    if (_lifetimeActive) return SubscriptionPlanKind.lifetime;
    final fromProduct = SubscriptionPlan.kindForProductId(_activeProductId);
    if (fromProduct != null) return fromProduct;
    return SubscriptionPlan.kindForPlanLabel(_activePlanLabel);
  }

  String? get activePlanDisplayLabel {
    if (!hasPremiumAccess) return null;
    final kind = activePlanKind;
    if (kind == null) return _activePlanLabel ?? 'Premium';
    return '${SubscriptionPlan.displayLabelForKind(kind)} Premium';
  }

  List<SubscriptionPlan> get plans => List.unmodifiable(_plans);

  bool canPurchasePlan(SubscriptionPlanKind kind) {
    if (!AppBillingConfig.iapEnabled) return false;
    if (_storeUnavailable || !_isStoreAvailable) return false;
    if (_isLoadingProducts || _isPurchasing) return false;
    for (final plan in _plans) {
      if (plan.kind == kind && plan.storeProduct != null) return true;
    }
    return false;
  }

  void _markStoreUnavailable([Object? error]) {
    _storeUnavailable = true;
    if (SubscriptionBillingErrorHelper.isTechnicalException(error) ||
        SubscriptionBillingErrorHelper.isTechnicalError(_lastError)) {
      _lastError = null;
    }
    if (kDebugMode && error != null) {
      debugPrint('SubscriptionService store unavailable: $error');
    }
  }

  void _refreshStoreAvailability() {
    _storeUnavailable = !_plans.any((plan) => plan.storeProduct != null);
  }

  Future<void> _ensureStoreConnection() async {
    if (!AppBillingConfig.iapEnabled) return;

    _isStoreAvailable = await _iap.isAvailable();
    if (!_isStoreAvailable) {
      _markStoreUnavailable('App Store is not available.');
      return;
    }

    _purchaseSub ??= _iap.purchaseStream.listen(
      _onPurchaseUpdates,
      onError: (Object error, StackTrace stack) {
        _markStoreUnavailable(error);
        notifyListeners();
        if (kDebugMode) {
          debugPrint('SubscriptionService purchaseStream error: $error\n$stack');
        }
      },
    );

    _lifecycleObserver ??= _SubscriptionLifecycleObserver(this)..register();
  }

  /// Reloads App Store products — call when opening the paywall or after connectivity returns.
  Future<void> refreshPaywallStore() async {
    if (!_initialized) {
      await initializeIfNeeded();
      return;
    }

    if (!AppBillingConfig.iapEnabled) {
      notifyListeners();
      return;
    }

    await _ensureStoreConnection();
    if (!_isStoreAvailable) {
      notifyListeners();
      return;
    }

    await loadProducts();
  }

  Future<void> _loadEntitlementFromStorage() async {
    _premiumActive = await _storage.isPremiumActive;
    _lifetimeActive = await _storage.isLifetime;
    _activePlanLabel = await _storage.planLabel;
    _activeProductId = await _storage.activeProductId;
    _expiresAt = await _storage.expiresAt;

    if (_premiumActive &&
        !_lifetimeActive &&
        !SubscriptionPurchaseValidator.isCachedEntitlementActive(
          premiumActive: true,
          lifetime: false,
          expiresAt: _expiresAt,
        )) {
      await _storage.revokeSubscriptionAccess();
      _premiumActive = false;
      _activePlanLabel = null;
      _activeProductId = null;
      _expiresAt = null;
    }
  }

  Future<void> initializeIfNeeded() async {
    if (_initialized) return;
    _initialized = true;

    await _loadEntitlementFromStorage();

    if (!AppBillingConfig.iapEnabled) {
      notifyListeners();
      return;
    }

    await _ensureStoreConnection();
    if (!_isStoreAvailable) {
      notifyListeners();
      return;
    }

    await loadProducts();
    await _syncEntitlementsWithStore(showRestoring: false);
  }

  Future<void> loadProducts() async {
    if (!AppBillingConfig.iapEnabled || !_isStoreAvailable) return;

    _isLoadingProducts = true;
    _storeUnavailable = false;
    _lastError = null;
    notifyListeners();

    try {
      final response = await _iap.queryProductDetails(AppBillingConfig.productIds);

      final byId = {
        for (final product in response.productDetails) product.id: product,
      };

      _plans = SubscriptionPlan.catalog()
          .map((plan) => plan.copyWithProduct(byId[plan.productId]))
          .toList(growable: false);

      if (response.error != null) {
        _markStoreUnavailable(response.error);
      } else {
        _refreshStoreAvailability();
        if (_storeUnavailable) {
          _lastError = null;
        }
      }
    } catch (e, st) {
      _markStoreUnavailable(e);
      if (kDebugMode) {
        debugPrint('SubscriptionService loadProducts failed: $e\n$st');
      }
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }

  Future<void> refreshEntitlement() => _syncEntitlementsWithStore(showRestoring: true);

  Future<void> _syncEntitlementsWithStore({required bool showRestoring}) async {
    await initializeIfNeeded();
    _hadPremiumBeforeEntitlementSync = hasPremiumAccess;
    _isSyncingEntitlements = true;

    await _loadEntitlementFromStorage();

    if (!AppBillingConfig.iapEnabled || !_isStoreAvailable) {
      _isSyncingEntitlements = false;
      _hadPremiumBeforeEntitlementSync = false;
      notifyListeners();
      return;
    }

    if (_lifetimeActive) {
      _isSyncingEntitlements = false;
      _hadPremiumBeforeEntitlementSync = false;
      notifyListeners();
      return;
    }

    if (showRestoring) {
      _isRestoring = true;
      notifyListeners();
    }

    try {
      await SubscriptionPurchaseValidator.finishExpiredIosTransactions();

      // Drop stale subscription cache before asking StoreKit for current access.
      await _storage.revokeSubscriptionAccess();
      await _loadEntitlementFromStorage();

      final snapshot =
          await SubscriptionPurchaseValidator.readIosCurrentEntitlements(_iap);

      if (snapshot.isActive && snapshot.productId != null) {
        await _grantFromProductId(
          snapshot.productId!,
          lifetime: snapshot.lifetime,
          expiresAt: snapshot.expiresAt,
        );
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('SubscriptionService sync failed: $e\n$st');
      }
    } finally {
      _isSyncingEntitlements = false;
      _hadPremiumBeforeEntitlementSync = false;
      _isRestoring = false;
      await _loadEntitlementFromStorage();
      notifyListeners();
    }
  }

  Future<bool> purchasePlan(SubscriptionPlanKind kind) async {
    await initializeIfNeeded();
    if (!canPurchasePlan(kind)) {
      return false;
    }

    final plan = _plans.firstWhere((p) => p.kind == kind);
    final product = plan.storeProduct;
    if (product == null) {
      _markStoreUnavailable('Missing store product');
      notifyListeners();
      return false;
    }

    _isPurchasing = true;
    _lastError = null;
    notifyListeners();

    try {
      await SubscriptionPurchaseValidator.finishExpiredIosTransactions();
      final param = PurchaseParam(productDetails: product);
      return await _iap.buyNonConsumable(purchaseParam: param);
    } catch (e, st) {
      _markStoreUnavailable(e);
      if (kDebugMode) {
        debugPrint('SubscriptionService purchase failed: $e\n$st');
      }
      return false;
    } finally {
      _isPurchasing = false;
      notifyListeners();
    }
  }

  Future<void> restorePurchases() => refreshEntitlement();

  Future<void> _onPurchaseUpdates(List<PurchaseDetails> purchases) async {
    if (_isSyncingEntitlements) {
      for (final purchase in purchases) {
        if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          await SubscriptionPurchaseValidator.completePurchaseDetails(
            _iap,
            purchase,
          );
        }
      }
      return;
    }

    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (SubscriptionPurchaseValidator.isPurchaseEntitlementActive(purchase)) {
            final lifetime = AppBillingConfig.isLifetimeProduct(purchase.productID);
            await _grantFromProductId(
              purchase.productID,
              lifetime: lifetime,
              expiresAt: SubscriptionPurchaseValidator.expirationFromPurchase(purchase),
            );
          }
          await SubscriptionPurchaseValidator.completePurchaseDetails(_iap, purchase);
        case PurchaseStatus.error:
          _markStoreUnavailable(
            purchase.error?.message ?? 'Purchase failed.',
          );
        case PurchaseStatus.canceled:
          break;
      }
    }

    await _loadEntitlementFromStorage();
    notifyListeners();
  }

  Future<void> _grantFromProductId(
    String productId, {
    bool? lifetime,
    DateTime? expiresAt,
  }) async {
    if (!AppBillingConfig.isPremiumProduct(productId)) return;

    final isLifetime = lifetime ?? AppBillingConfig.isLifetimeProduct(productId);
    if (!isLifetime && expiresAt == null) return;

    final label = _labelForProductId(productId);

    await _storage.grant(
      productId: productId,
      lifetime: isLifetime,
      planLabel: label,
      expiresAt: isLifetime ? null : expiresAt,
    );
  }

  String _labelForProductId(String productId) {
    final kind = SubscriptionPlan.kindForProductId(productId);
    if (kind != null) return SubscriptionPlan.displayLabelForKind(kind);
    return 'Premium';
  }

  @override
  void dispose() {
    _lifecycleObserver?.unregister();
    unawaited(_purchaseSub?.cancel());
    super.dispose();
  }
}

final class _SubscriptionLifecycleObserver with WidgetsBindingObserver {
  _SubscriptionLifecycleObserver(this._service);

  final SubscriptionService _service;

  void register() => WidgetsBinding.instance.addObserver(this);

  void unregister() => WidgetsBinding.instance.removeObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && AppBillingConfig.iapEnabled) {
      unawaited(_service.refreshPaywallStore());
      unawaited(_service.refreshEntitlement());
    }
  }
}
