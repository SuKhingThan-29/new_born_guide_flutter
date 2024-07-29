import 'dart:io';

import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_chatinfo.dart';
import 'package:chitmaymay/service/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chitmaymay_api/requestApi.dart';
import '../chitmaymay_api/requestApiFromData.dart';
import '../model/chat_message.dart';
import '../service/init_service.dart';
import '../utils/constant_util.dart';

class ChatScreenController extends GetxController {
  var messageList = <ChatMessage>[].obs;
  final SettingController userController = Get.find<SettingController>();
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 50.0);

  var isLoading = true.obs;
  var chatInfo = TBLChatInfo().obs;
  var chatData = TBLChat().obs;

  var fetchingNewData = false.obs;
  int page = 1;
  bool moreData = true;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    chatData = TBLChat().obs;
    super.onClose();
  }

  void setChatData(TBLChat tblChat) {
    chatData.value = tblChat;
  }

  Future<void> connectAndListen() async {
    fetchMessageList();

    socketService.socket.emit('subscribe',
        {"channel": userController.userProfile.value.convKey ?? ''});

    //When an event recieved from server, data is added to the stream
    socketService.socket.on('chitmaymay', (data) {
      debugPrint('message event======>');
      ChatMessage chatMessage = ChatMessage.fromJson(data);
      if (chatMessage.convKey == chatData.value.convkey) {
        messageList.insert(0, chatMessage);
        seenMessage();
      }
    });

    socketService.socket.on('chitmaymay.react', (data) {
      debugPrint('react event======>');
      var messageid = data['message_id'];
      for (var val in messageList) {
        if (val.id == messageid) {
          val.isReact = (data['react_action'] == 0) ? false : true;
          if (val.isReact ?? false) {
            val.customerReact?.add(
                CustomerReact(userId: data['user_id'], messageId: messageid));
            messageList.refresh();
            return;
          } else {
            val.customerReact?.removeWhere((element) =>
                (element.messageId == messageid &&
                    element.userId == data['user_id']));
            messageList.refresh();
            return;
          }
        }
      }
      messageList.refresh();
    });

    socketService.socket.on('chitmaymay.delete', (data) {
      debugPrint('delete event======>');
      if (data['conv_key'] == chatData.value.convkey) {
        var messageid = data['message_id'];
        for (var val in messageList) {
          if (val.id == messageid) {
            val.messageType = 'delete';
            messageList.refresh();
            return;
          }
        }
      }
    });
  }

  void sendMessage(String message, int receiveId, String receiveName,
      String receiveConvKey, String convKey) async {
    ChatMessage chatMessage = ChatMessage(
        message: message,
        messageType: 'text',
        chatType: 'user',
        senderId: initService.getUserId.toString(),
        senderName: userController.userProfile.value.username ?? '',
        senderImage: userController.userProfile.value.image ?? '',
        senderConvKey: userController.userProfile.value.convKey,
        replyMessageId: 0,
        replyMessage: '',
        receiveId: receiveId.toString(),
        receiveName: receiveName,
        receiveConvKey: receiveConvKey,
        convKey: convKey,
        createdAt: DateTime.now().toString());
    socketService.socket.emit('chitmaymay', chatMessage.toJson());
    sendNoti(receiveId, receiveName, message);
  }

  void sendImageMessage(String imageLink, int receiveId, String receiveName,
      String receiveConvKey, String convKey) async {
    ChatMessage chatMessage = ChatMessage(
        message: imageLink,
        messageType: 'image',
        chatType: 'user',
        senderId: initService.getUserId.toString(),
        senderName: userController.userProfile.value.username ?? '',
        senderImage: userController.userProfile.value.image ?? '',
        senderConvKey: userController.userProfile.value.convKey,
        replyMessageId: 0,
        replyMessage: '',
        receiveId: receiveId.toString(),
        receiveName: receiveName,
        receiveConvKey: receiveConvKey,
        convKey: convKey,
        createdAt: DateTime.now().toString());
    socketService.socket.emit('chitmaymay', chatMessage.toJson());
    messageList.insert(0, chatMessage);
    sendNoti(receiveId, receiveName, 'Send a photo message');
  }

  void onReact(ChatMessage message) {
    Map reactMsg = {
      'group_message_id': 0,
      'react_action': (message.isReact ?? false) ? 0 : 1,
      'user_id': initService.getUserId,
      'message_id': message.id,
      'conv_key': chatData.value.convkey ?? '',
      'chat_type': 'user'
    };
    socketService.socket.emit('chitmaymay.react', reactMsg);
  }

  void onDeleteMessage(ChatMessage message) {
    Map deleteMsg = {
      'conv_key': chatData.value.convkey ?? '',
      'group_id': 0,
      'sender_id': initService.getUserId,
      'message_id': message.id,
      'message': "Message deleted",
      'chat_type': 'user',
      'created_at': DateTime.now().toString()
    };
    socketService.socket.emit('chitmaymay.delete', deleteMsg);
  }

  Future<void> sendNoti(
      int receiveId, String receiveName, String message) async {
    await RequestApi.requestSendNoti(initService.getToken,
        initService.getUserId, receiveId, receiveName, message, "user");
  }

  Future<void> fetchMessageList() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      ChatMessageListRequest request = ChatMessageListRequest(
          convKey: chatData.value.convkey ?? '',
          secretKey: secret_key,
          chatType: 'user',
          groupId: 0,
          pageId: page,
          userId: initService.getUserId);

      final response = await RequestApi.requestChatMessageList(
          request, initService.getToken);
      if (response != null) {
        seenMessage();
        page++;
        chatInfo.value = response.chatInfo ?? TBLChatInfo();
        messageList.value = (response.data ?? []) as List<ChatMessage>;
      }
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void seenMessage() {
    Map read = {
      'group_id': 0,
      'receive_id': chatData.value.receiveId ?? '',
      'conv_key': chatData.value.convkey ?? '',
      'is_admin': 0,
      'chat_type': 'user'
    };
    socketService.socket.emit('chitmaymay.read', read);
  }

  Future<void> loadMoreMessage() async {
    final isInternet = await ConstantUtils.isInternet();
    fetchingNewData.value = true;
    if (isInternet) {
      ChatMessageListRequest request = ChatMessageListRequest(
          convKey: chatData.value.convkey ?? '',
          secretKey: secret_key,
          chatType: 'user',
          groupId: 0,
          pageId: page,
          userId: initService.getUserId);

      final response = await RequestApi.requestChatMessageList(
          request, initService.getToken);
      if (response?.status ?? false) {
        if ((response?.data?.length ?? 0) > 0) {
          messageList.addAll((response?.data ?? []) as List<ChatMessage>);
          fetchingNewData.value = false;
          page++;
        } else {
          moreData = false;
        }
      }
      fetchingNewData.value = false;
    }
    fetchingNewData.value = false;
  }

  void scrollListener() {
    if (moreData) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (fetchingNewData.value) {
          return debugPrint("Sorry, I am loading......");
        }
        loadMoreMessage();
      }
    }
  }

  Future<void> blockUser(int blockTo) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      if (chatInfo.value.blockStatus == 0) {
        chatInfo.value.blockStatus = 1;
      } else {
        chatInfo.value.blockStatus = 0;
      }
      final response = await RequestApi.requestBlockUser(initService.getToken,
          initService.getUserId, blockTo, chatInfo.value.blockStatus ?? 0);
      if (response?.status ?? false) {
        chatInfo.refresh();
      } else {
        debugPrint('error block');
      }
    }
  }

  Future<void> muteUser(int muteTo) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      if (chatInfo.value.muteStatus == 0) {
        chatInfo.value.muteStatus = 1;
      } else {
        chatInfo.value.muteStatus = 0;
      }
      final response = await RequestApi.requestMuteUser(initService.getToken,
          initService.getUserId, muteTo, chatInfo.value.muteStatus ?? 0);
      if (response?.status ?? false) {
        chatInfo.refresh();
      } else {
        debugPrint('error mute');
      }
    }
  }

  Future<String> uploadImage(File image) async {
    final isInternet = await ConstantUtils.isInternet();
    String imageLink = '';
    if (isInternet) {
      final response =
          await ImageUploadApi.chatImageUpload(image, initService.getToken);
      if (response?.status ?? false) {
        imageLink = response?.data ?? '';
      } else {
        debugPrint('error image upload');
      }
    }
    return imageLink;
  }
}
