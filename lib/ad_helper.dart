import 'package:flutter/foundation.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdManager {

  static Future<void> loadUnityIntAd() async {
    await UnityAds.load(
      placementId: AdHelper.interstitialId,
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  static Future<void> showIntAd() async {
    UnityAds.showVideoAd(
        placementId: AdHelper.interstitialId,
        onStart: (placementId) => print('Video Ad $placementId started'),
        onClick: (placementId) => print('Video Ad $placementId click'),
        onSkipped: (placementId) => print('Video Ad $placementId skipped'),
        onComplete: (placementId) async {
          await loadUnityIntAd();
        },
        onFailed: (placementId, error, message) async {
          await loadUnityIntAd();
        });
  }

  static Future<void> loadUnityRewardedAd() async {
    await UnityAds.load(
      placementId: AdHelper.rewardedId,
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  static Future<void> showBannerAd() async {
    UnityBannerAd(
      placementId: AdHelper.bannerId,
      onLoad: (placementId) => print('Banner loaded: $placementId'),
      onClick: (placementId) => print('Banner clicked: $placementId'),
      onFailed: (placementId, error, message) =>
          print('Banner Ad $placementId failed: $error $message'),
    );
  }

  static Future<void> showRewardedAd() async {
    UnityAds.showVideoAd(
        placementId: AdHelper.rewardedId,
        onStart: (placementId) => print('Video Ad $placementId started'),
        onClick: (placementId) => print('Video Ad $placementId click'),
        onSkipped: (placementId) => print('Video Ad $placementId skipped'),
        onComplete: (placementId) async {
          await loadUnityRewardedAd();
        },
        onFailed: (placementId, error, message) async {
          await loadUnityRewardedAd();
        });
  }
}

class AdHelper {
  static String get addUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '5325822';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return '4994514';
    }
    return '';
  }

  static String get bannerId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Banner_Android';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Banner_iOS';
    }
    return '';
  }

  static String get interstitialId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Interstitial_Android';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Interstitial_iOS';
    }
    return '';
  }


  static String get rewardedId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Rewarded_Android';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Rewarded_iOS';
    }
    return '';
  }
}