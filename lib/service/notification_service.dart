import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../db/dbModel/tbl_chat.dart';
import '../screen/home/bottom_nav/chat/group_chat_screen.dart';
import '../screen/home/bottom_nav/chat/user_chat_screen.dart';

class NotificationService {
  NotificationService._();

  Future<void> initialize() async {
    _listenForegroundMessage();
    await _setupIosForegroundNotiOptions();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  void _listenForegroundMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatePage(message);
    });
  }

  Future<void> _setupIosForegroundNotiOptions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else {
      openAppSettings();
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  navigatePage(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      if (message.data["chat_type"] == "user") {
        TBLChat chat = TBLChat(
          receiveId: int.parse(message.data["received_id"]),
          receiveName: message.data["name"],
          receivePhone: message.data["receivePhone"],
          receiveConvKey: message.data["receiveConvKey"],
          convkey: message.data["conv_key"],
          receiveImage: message.data["image"],
          chatType: "user",
        );
        Get.to(UserChatScreen(chat: chat));
      } else if (message.data["chat_type"] == "group") {
        TBLChat chat = TBLChat(
          groupId: int.parse(message.data["received_id"]),
          groupName: message.data["name"],
          groupConvKey: message.data["group_conv_key"],
          groupImage: message.data["image"],
          chatType: "group",
        );
        Get.to(GroupChatScreen(chat: chat));
      }
    }
  }
}

NotificationService notiService = NotificationService._();
