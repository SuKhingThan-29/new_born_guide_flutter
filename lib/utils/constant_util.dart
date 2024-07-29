import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_profile/_profile_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ConstantUtils {
  static bool isClassic1 = false;
  static bool isClassic2 = false;
  static bool isDarkMode = false;
  static DateFormat dayMonthNumberYearFormat = DateFormat('dd-MM-yyyy');
  static DateFormat yearMonthDateFormat = DateFormat('yyyy-MM-dd');

  static DateFormat dayMonthNameYearFormat = DateFormat('d-LLLL-yyyy');

  static const String hlsPlaylistUrlM3u8 =
      "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";

  static const String hlsPlaylistUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";

  // static const String hlsPlaylistUrl =
  //     "https://chitmaymay.s3.ap-southeast-1.amazonaws.com/62d7a851de029.m3u8"; //Ko Min Min

  //static const String hlsPlaylistUrl='/data/user/0/com.dkmads.chitmaymay/app_flutter/CMM3u8';
  static const String fileTestVideoUrl = "ForBiggerBlazesM3u8.mp4";

  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    String _localPath =
        '${directory.path}${Platform.pathSeparator}ChitMayMay/$fileName';
    debugPrint('Local Path get: $_localPath');
    return _localPath;
  }

  static String currentDate() {
    DateTime dateTime = DateTime.now();
    String createdAt = dateTime.toString();
    debugPrint('CurrentDateTime: $createdAt');
    return createdAt;
  }

  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          content: Text(message)),
    );
  }


  static showAlertDialogPhoneNumber(BuildContext context, String message) {
    // Create button
    Widget okButton = CustomButton(
      label: 'ok'.tr,
      onTap: () async {
        Navigator.of(context).pop();
        Get.off(() => const ProfileScreen());
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Warning Message'),
      content: Text(message.tr),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showAlertDialog(BuildContext context, String message) {
    // Create button
    Widget okButton = CustomButton(
      label: 'ok'.tr,
      backgroundColor: backgroundDarkPurple,
      textStyle: kTextStyleWhite(12),
      onTap: () async {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Warning Message'),
      content: Text(message.tr),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showDownloadingDialog(
      BuildContext context, String message, bool isCloseDialog) {
    debugPrint('isCloseDialog: $isCloseDialog');

    if (isCloseDialog) {
      Navigator.of(context).pop();
    }
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message.tr),
      content: const Center(
        child: CircularProgressIndicator(),
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showPremiumAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: cl1_dark_purple),
          child: const Center(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          )),
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        child: Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: 50,
                height: 50,
                child: SvgPicture.asset('assets/icon/crown.svg'),
              ),
              const Text(
                'Premium',
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              const Text(
                'သုံးစွဲမှုအတွက် ကျေးဇူးတင်ပါသည်။',
                style: TextStyle(color: Colors.black, fontSize: 14),
              )
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: okButton,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  static late AppsflyerSdk _appsflyerSdk;
  static final Map eventValues = {
    "af_content_id": "id123",
    "af_currency": "USD",
    "af_revenue": "0.1"
  };
  static Future<void> sendFirebaseAnalyticsEvent(String eventName) async {
    debugPrint('Event Name: $eventName');
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
        'items': [itemCreator()]
      },
    );
    ConstantUtils.sendAppFlyerEvent(eventName, ConstantUtils.eventValues);
  }

  static AnalyticsEventItem itemCreator() {
    return AnalyticsEventItem(
      affiliation: 'affil',
      coupon: 'coup',
      creativeName: 'creativeName',
      creativeSlot: 'creativeSlot',
      discount: 2.22,
      index: 3,
      itemBrand: 'itemBrand',
      itemCategory: 'itemCategory',
      itemCategory2: 'itemCategory2',
      itemCategory3: 'itemCategory3',
      itemCategory4: 'itemCategory4',
      itemCategory5: 'itemCategory5',
      itemId: 'itemId',
      itemListId: 'itemListId',
      itemListName: 'itemListName',
      itemName: 'itemName',
      itemVariant: 'itemVariant',
      locationId: 'locationId',
      price: 9.99,
      currency: 'USD',
      promotionId: 'promotionId',
      promotionName: 'promotionName',
      quantity: 1,
    );
  }

  static Future<bool?> sendAppFlyerEvent(
      String eventName, Map eventValues) async {
    final AppsFlyerOptions options = AppsFlyerOptions(
        afDevKey: 'WCEsoDzwXDTy9kq9fYugGH',
        appId: 'id1615505050',
        showDebug: true,
        timeToWaitForATTUserAuthorization: 15);
    _appsflyerSdk = AppsflyerSdk(options);
    _appsflyerSdk.onAppOpenAttribution((res) {
      debugPrint("onAppOpenAttribution res: " + res.toString());
      // setState(() {
      //   _deepLinkData = res;
      // });
    });
    _appsflyerSdk.onInstallConversionData((res) {
      debugPrint("onInstallConversionData res: " + res.toString());
      // setState(() {
      //   _gcd = res;
      // });
    });
    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          debugPrint(dp.deepLink?.toString());
          debugPrint("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          debugPrint("deep link not found");
          break;
        case Status.ERROR:
          debugPrint("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          debugPrint("deep link status parsing error");
          break;
      }
      debugPrint("onDeepLinking res: " + dp.toString());
      // setState(() {
      //   _deepLinkData = dp.toJson();
      // });
    });
    _appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: false,
        registerOnDeepLinkingCallback: true);
    return _appsflyerSdk.logEvent(eventName, eventValues);
  }
}
