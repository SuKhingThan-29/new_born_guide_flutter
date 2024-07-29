import 'package:chitmaymay/db/dbModel/tbl_about_us.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/db/dbModel/tbl_data.dart';
import 'package:chitmaymay/db/dbModel/tbl_device.dart';
import 'package:chitmaymay/db/dbModel/tbl_notification.dart';
import 'package:chitmaymay/db/dbModel/tbl_premium.dart';
import 'package:chitmaymay/db/dbModel/tbl_privacy_policy.dart';
import 'package:chitmaymay/db/dbModel/tbl_profile.dart';
import 'package:chitmaymay/db/dbModel/tbl_term_condition.dart';
import 'package:hive/hive.dart';

import '../db/dbModel/tbl_downloaded_video.dart';

class Boxes {
  static Box<TBLTermAndCondition> getTermAndCondition() =>
      Hive.box<TBLTermAndCondition>('termAndCondition');

  static Box<TblAboutUs> getAboutUs() => Hive.box<TblAboutUs>('aboutUs');

  static Box<TblPrivacyPolicy> getPrivacyPolicy() =>
      Hive.box<TblPrivacyPolicy>('privacyPolicy');

  static Box<TBLProfile> getProfile() => Hive.box<TBLProfile>('profile');

  static Box<TblNotification> getNotification() =>
      Hive.box<TblNotification>('notification');

  static Box<TBLDevice> getDevice() => Hive.box<TBLDevice>('device');

  static Box<TBLData> getData() => Hive.box<TBLData>('data');

  static Box<TBLChat> getChatList() => Hive.box<TBLChat>('chatlist');

  static Box<TBLPremium> getPremium() => Hive.box<TBLPremium>('premium');

  static Box<TBLContent> getSavedContent() =>
      Hive.box<TBLContent>('savecontents');

  static Box<TblDownloadedVideo> getDownloadVideos() =>
      Hive.box<TblDownloadedVideo>('downloadedvideos');
}
