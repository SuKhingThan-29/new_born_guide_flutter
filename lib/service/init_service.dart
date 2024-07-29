import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chitmaymay_api/requestModel.dart';
import '../db/dbModel/tbl_about_us.dart';
import '../db/dbModel/tbl_chat.dart';
import '../db/dbModel/tbl_comic.dart';
import '../db/dbModel/tbl_content.dart';
import '../db/dbModel/tbl_data.dart';
import '../db/dbModel/tbl_device.dart';
import '../db/dbModel/tbl_downloaded_video.dart';
import '../db/dbModel/tbl_notification.dart';
import '../db/dbModel/tbl_premium.dart';
import '../db/dbModel/tbl_privacy_policy.dart';
import '../db/dbModel/tbl_profile.dart';
import '../db/dbModel/tbl_term_condition.dart';
import '../utils/constant_util.dart';
import '../utils/constants.dart';
import '../utils/style.dart';
import 'appflyer_service.dart';
import 'deep_link_service.dart';
import 'notification_service.dart';

class InitService {
  InitService._();

  init() async {
    appFlyerService.setAppFlyer();
    deeplinkService.handleDynamicLinks();
    notiService.initialize();

    await Hive.initFlutter();
    registerBoxes();
    fetchContactList();
  }

  late SharedPreferences preferences;
  int? userId;
  String? deviceId;
  String? deviceName;
  String? firebaseToken;
  String? token;
  bool? isLogin;
  String? loginDate;
  List<String> phones = [];

  SharedPreferences get sharedPreferences => preferences;

  int get getUserId => userId ?? 0;

  String get getDeviceId => deviceId ?? '';

  String get getDeviceName => deviceName ?? '';

  String get getFirebseToken => firebaseToken ?? '';

  String get getToken => token ?? '';

  bool get getIsLogin => isLogin ?? false;

  List<String> get getContacts => phones;

  void clearData() {
    preferences.clear();
  }

  void registerBoxes() async {
    Hive.registerAdapter(TBLTermAndConditionAdapter());
    await Hive.openBox<TBLTermAndCondition>('termAndCondition');

    Hive.registerAdapter(TblPrivacyPolicyAdapter());
    await Hive.openBox<TblPrivacyPolicy>('privacyPolicy');

    Hive.registerAdapter(TblAboutUsAdapter());
    await Hive.openBox<TblAboutUs>('aboutUs');

    Hive.registerAdapter(TblNotificationAdapter());
    await Hive.openBox<TblNotification>('notification');

    Hive.registerAdapter(TBLProfileAdapter());
    await Hive.openBox<TBLProfile>('profile');

    Hive.registerAdapter(TBLDeviceAdapter());
    await Hive.openBox<TBLDevice>('device');

    Hive.registerAdapter(TBLComicAdapter());
    Hive.registerAdapter(TBLContentAdapter());
    await Hive.openBox<TBLContent>('savecontents');
    Hive.registerAdapter(TBLDataAdapter());
    await Hive.openBox<TBLData>('data');

    Hive.registerAdapter(TBLChatAdapter());
    await Hive.openBox<TBLChat>('chatlist');

    Hive.registerAdapter(TBLPremiumAdapter());
    await Hive.openBox<TBLPremium>('premium');

    Hive.registerAdapter(TblDownloadedVideoAdapter());
    await Hive.openBox<TblDownloadedVideo>('downloadedvideos');
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<void> fetchContactList() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      debugPrint('contacts permission=====> grant');

      List<Contact> contacts = await FastContacts.allContacts;
      for (var val in contacts) {
        var phone = val.phones.join(', ').replaceAll(' ', '');
        if (phone.startsWith('09')) {
          phone = '+95' + phone;
          phones.add(phone);
        } else if (phone.startsWith('+95')) {
          phones.add(phone);
        }
      }

      debugPrint('contacts=====>');
      debugPrint(phones.toString());
    } else {
      debugPrint('contacts permission=====> deny');
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      showToast('Access to contact data denied');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showToast('Contact data not available on device');
    }
  }

  Future<void> savePrefsUserData(RegisterVerifyResponse? userData) async {
    preferences.setString(token_key, userData?.token ?? '');
    preferences.setInt(mUserId, userData?.userId ?? 0);
    preferences.setString(phoneNo, userData?.userPhone ?? '');
    preferences.setBool(IsLogin, true);
    loginDate = ConstantUtils.dayMonthNumberYearFormat.format(DateTime.now());
    preferences.setString(currentDate, loginDate ?? '');
  }

  Future<void> initUserData() async {
    setUserId();
    setToken();
  }

  Future<void> setUserId() async {
    userId = preferences.getInt(mUserId);
  }

  Future<void> setToken() async {
    token = preferences.getString(token_key);
  }

  Future<void> setDeviceId() async {
    try {
      deviceId = (await PlatformDeviceId.getDeviceId)!;
    } catch (e) {
      debugPrint(e.toString());
    }
    preferences.setString(mDeviceId, deviceId.toString());
  }

  Future<void> setDeviceName() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidDeviceInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosDeviceInfo.utsname.machine!;
    }
    preferences.setString(mDeviceName, deviceName ?? '');
  }

  Future<void> setUpFirebaseToken() async {
    FirebaseMessaging.instance.getToken().then((token) {
      firebaseToken = token ?? '';
      debugPrint('firebase token======> $firebaseToken');
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
      firebaseToken = token;
    });
  }

  Future<void> setUpIsLogin() async {
    preferences.getBool(IsLogin);
  }

  Future<void> initializeData() async {
    preferences = await SharedPreferences.getInstance();
    await setUserId();
    setToken();
    setDeviceId();
    setDeviceName();
    setUpFirebaseToken();
    setUpIsLogin();
  }
}

InitService initService = InitService._();
