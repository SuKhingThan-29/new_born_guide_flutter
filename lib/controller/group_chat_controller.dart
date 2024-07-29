import 'dart:io';

import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_chatinfo.dart';
import 'package:chitmaymay/db/dbModel/tbl_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chitmaymay_api/requestApi.dart';
import '../chitmaymay_api/requestApiFromData.dart';
import '../model/chat_message.dart';
import '../service/init_service.dart';
import '../service/socket_service.dart';
import '../utils/constant_util.dart';
import '../utils/constants.dart';

class GroupChatController extends GetxController {
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

  var members = <TBLUser>[].obs;

  //group setting
  var groupSettingLoading = false.obs;

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

  bool isMember(int groupOwnerId) {
    if (groupOwnerId == initService.getUserId) {
      return true;
    } else {
      return false;
    }
  }

  void setChatData(TBLChat tblChat) {
    chatData.value = tblChat;
  }

  Future<void> connectAndListen() async {
    fetchMessageList();
    fetchMemberList();
    socketService.socket
        .emit('subscribe', {"channel": chatData.value.groupConvKey ?? ''});

    //When an event recieved from server, data is added to the stream
    socketService.socket.on('chitmaymay', (data) {
      debugPrint('message event======>');
      ChatMessage chatMessage = ChatMessage.fromJson(data);
      if (chatMessage.receiveConvKey == chatData.value.groupConvKey) {
        messageList.insert(0, chatMessage);
        seenMessage();
      }
    });

    socketService.socket.on('chitmaymay.react', (data) {
      debugPrint('react event======>');
      if (data['conv_key'] == chatData.value.groupConvKey) {
        var messageid = data['group_message_id'];
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
      }
    });

    socketService.socket.on('chitmaymay.delete', (data) {
      debugPrint('delete event======>');
      if (data['conv_key'] == chatData.value.groupConvKey) {
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

  Future<void> fetchMemberList() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestMemberList(
          initService.getToken, chatData.value.groupId ?? 0);
      if (response?.status ?? false) {
        members.value = response?.data ?? [];
      }
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void sendMessage(String message, String convKey) {
    ChatMessage chatMessage = ChatMessage(
        message: message,
        messageType: 'text',
        chatType: 'group',
        senderId: initService.getUserId.toString(),
        senderName: userController.userProfile.value.username ?? '',
        senderImage: userController.userProfile.value.image ?? '',
        senderConvKey: userController.userProfile.value.convKey,
        replyMessageId: 0,
        replyMessage: '',
        receiveId: chatData.value.groupId.toString(),
        receiveName: chatData.value.groupName,
        receiveConvKey: chatData.value.groupConvKey,
        convKey: chatData.value.groupConvKey,
        createdAt: DateTime.now().toString());
    socketService.socket.emit('chitmaymay', chatMessage);
    sendNoti(
        chatData.value.groupId ?? 0, chatData.value.groupName ?? '', message);
  }

  Future<void> sendNoti(
      int receiveId, String receiveName, String message) async {
    await RequestApi.requestSendNoti(initService.getToken,
        initService.getUserId, receiveId, receiveName, message, "group");
  }

  Future<void> fetchMessageList() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      ChatMessageListRequest request = ChatMessageListRequest(
          convKey: chatData.value.groupConvKey ?? '',
          secretKey: secret_key,
          chatType: 'group',
          groupId: chatData.value.groupId ?? 0,
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
      'group_id': chatData.value.groupId,
      'sender_id': initService.getUserId,
      'conv_key': '',
      'is_admin': 0,
      'chat_type': 'group'
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
          chatType: 'group',
          groupId: chatData.value.groupId ?? 0,
          pageId: page,
          userId: initService.getUserId);

      final response = await RequestApi.requestChatMessageList(
          request, initService.getToken);
      if (response?.status ?? false) {
        if ((response?.data?.length ?? 0) > 1) {
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

  void onReact(ChatMessage message) {
    Map reactMsg = {
      'group_message_id': message.id,
      'react_action': (message.isReact ?? false) ? 0 : 1,
      'conv_key': chatData.value.groupConvKey,
      'user_id': initService.getUserId,
      'chat_type': 'group'
    };
    socketService.socket.emit('chitmaymay.react', reactMsg);
  }

  void onDeleteMessage(ChatMessage message) {
    Map deleteMsg = {
      'conv_key': chatData.value.groupConvKey,
      'group_id': chatData.value.groupId,
      'sender_id': initService.getUserId,
      'message_id': message.id,
      'message': "Message deleted",
      'chat_type': 'group',
      'created_at': DateTime.now().toString()
    };
    socketService.socket.emit('chitmaymay.delete', deleteMsg);
  }

  Future<void> deleteGroup(int groupId, context) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      groupSettingLoading.value = true;
      final response = await RequestApi.requestDeleteGroup(
          initService.getToken, groupId, initService.getUserId);
      if (response?.status ?? false) {
        showToast("Successfully deleted!");
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        debugPrint('error delete group');
      }
      groupSettingLoading.value = false;
    }
  }

  Future<void> leaveGroup(int groupId, int owner, context) async {
    if (initService.getUserId == owner) {
      showToast('You cannot leave because you are owner');
      return;
    }
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      groupSettingLoading.value = true;
      final response = await RequestApi.requestLeaveGroup(
          initService.getToken, groupId, initService.getUserId);
      if (response?.status ?? false) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        debugPrint('error leave group');
      }
      groupSettingLoading.value = false;
    }
  }

  Future<void> muteGroup(int groupId) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      groupSettingLoading.value = true;
      if (chatInfo.value.muteStatus == 0) {
        chatInfo.value.muteStatus = 1;
      } else {
        chatInfo.value.muteStatus = 0;
      }
      final response = await RequestApi.requestMuteGroup(initService.getToken,
          groupId, initService.getUserId, chatInfo.value.muteStatus ?? 0);
      if (response?.status ?? false) {
        showToast(
            (chatInfo.value.muteStatus == 0) ? 'Unmute Group!' : 'Mute Group!');
        chatInfo.refresh();
      } else {
        debugPrint('error mute');
      }
      groupSettingLoading.value = false;
    }
  }

  var userLists = <TBLUser>[].obs;
  var allUserLists = <TBLUser>[].obs;
  var addMemberLoading = false.obs;
  Future<void> fetchUserList(int groupId) async {
    allUserLists.value = [];
    addMemberLoading.value = true;

    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestGetGroupContacts(
          initService.getUserId,
          groupId,
          initService.getContacts,
          initService.getToken);
      if (response?.status ?? false) {
        allUserLists.value = response?.data ?? [];
        userLists = allUserLists;
      }
      addMemberLoading.value = false;
    }

    addMemberLoading.value = false;
  }

  void addMemberToList(int index) {
    userLists[index].selected = !(userLists[index].selected ?? false);
    userLists.refresh();
  }

  var addGpMemberLoading = false.obs;
  Future<void> addGroupMembers(int groupId, context) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      List<int> members = [];
      addGpMemberLoading.value = true;
      for (var user in userLists) {
        if (user.selected ?? false) {
          members.add(user.id ?? 0);
        }
      }
      if (members.isNotEmpty) {
        final response = await RequestApi.requestAddGroupMember(
            initService.getToken, groupId, initService.getUserId, members);
        if (response?.status ?? false) {
          showToast(' Members Added');
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        showToast('please select members');
      }
      addGpMemberLoading.value = false;
    }
  }

  void sendImageMessage(String imageLink) async {
    ChatMessage chatMessage = ChatMessage(
        message: imageLink,
        messageType: 'image',
        chatType: 'group',
        senderId: initService.getUserId.toString(),
        senderName: userController.userProfile.value.username ?? '',
        senderImage: userController.userProfile.value.image ?? '',
        senderConvKey: userController.userProfile.value.convKey,
        replyMessageId: 0,
        replyMessage: '',
        receiveId: chatData.value.groupId.toString(),
        receiveName: chatData.value.groupName,
        receiveConvKey: chatData.value.groupConvKey,
        convKey: chatData.value.groupConvKey,
        createdAt: DateTime.now().toString());
    socketService.socket.emit('chitmaymay', chatMessage.toJson());
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
