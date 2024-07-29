import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';

class AppFlyerService {
  late AppsflyerSdk appsflyerSdk;

  final androidOptions = {
    "afDevKey": "WCEsoDzwXDTy9kq9fYugGH",
    "afAppId": "com.dkmads.athabyar",
    "isDebug": true,
  };

  final iosOptions = {
    "afDevKey": "WCEsoDzwXDTy9kq9fYugGH",
    "afAppId": "id1615505050",
    "isDebug": true,
  };

  AppFlyerService._() {
    _init();
  }

  _init() async {
    if (Platform.isIOS) {
      appsflyerSdk = AppsflyerSdk(iosOptions);
    } else if (Platform.isAndroid) {
      appsflyerSdk = AppsflyerSdk(androidOptions);
    }
  }

  setAppFlyer() {
    appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);

  }
}

AppFlyerService appFlyerService = AppFlyerService._();
