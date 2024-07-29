// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeepLinkService {
  DeepLinkService._();

  ValueNotifier<String> referrerCode = ValueNotifier<String>('');

  final dynamicLink = FirebaseDynamicLinks.instance;

  Future<void> handleDynamicLinks() async {
    //Get initial dynamic link if app is started using the link
    final data = await dynamicLink.getInitialLink();
    if (data != null) {
      _handleDeepLink(data);
    }

    //handle foreground
    dynamicLink.onLink.listen((event) {
      _handleDeepLink(event);
    }).onError((v) {
      debugPrint('Failed: $v');
    });
  }

  Future<String> createReferLink(String referUserId) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://chitmaymay.page.link',
      link: Uri.parse('https://chitmaymay.page.link/refer?code=$referUserId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.dkmads.chitmaymay',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.dkmads.chitmaymay',
        appStoreId: '1645472708',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'REFER A FRIEND & EARN',
        description: 'Earn 50MMK on every referral',
        imageUrl: Uri.parse(
            'https://moru.com.np/wp-content/uploads/2021/03/Blog_refer-Earn.jpg'),
      ),
    );

    final shortLink = await dynamicLink.buildShortLink(dynamicLinkParameters);

    return shortLink.shortUrl.toString();
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    debugPrint("Deeplink====> " + data.link.toString());
    final Uri deepLink = data.link;
    var isRefer = deepLink.pathSegments.contains('refer');
    var isProfile = deepLink.pathSegments.contains('profile');
    debugPrint('isRefer======> $isRefer ');
    if (isRefer) {
      var code = deepLink.queryParameters['code'];
      if (code != null) {
        referrerCode.value = code;
        debugPrint('ReferrerCode $referrerCode');
        referrerCode.notifyListeners();
      }
    } else if (isProfile) {
      final Uri? deepLink = data.link;
      if (deepLink != null) {
        Get.toNamed('/profile');
      }
    }
  }
}

DeepLinkService deeplinkService = DeepLinkService._();
