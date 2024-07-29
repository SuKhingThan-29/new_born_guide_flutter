import 'dart:async';

import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/db/dbModel/tbl_block_user.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat_message.dart';
import 'package:chitmaymay/db/dbModel/tbl_group.dart';
import 'package:chitmaymay/db/dbModel/tbl_user.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/group_chat_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chitmaymay_api/requestApiFromData.dart';
import '../chitmaymay_api/requestApi.dart';
import '../service/boxes.dart';
import '../service/init_service.dart';
import '../utils/constant_util.dart';

class ChatController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  var isLoading = true.obs;
  var chatLists = <TBLChat>[].obs;
  List<TBLChat> allChatLists = [];

  var isNewMessageLoading = true.obs;
  var userLists = <TBLUser>[].obs;
  var allUserLists = <TBLUser>[].obs;
  var noticount = 0.obs;

  //user chat message screen
  var chatMessage = TBLChatMessage().obs;
  var chatMessageLoading = true.obs;

  //create group
  var memberList = <TBLUser>[].obs;
  final TextEditingController groupNameController = TextEditingController();
  var seletedImagePath = ''.obs;
  var createGroupLoading = false.obs;

  //block user list
  var blockUserLoading = true.obs;
  var blockUserList = <TBLBlockUser>[].obs;

  @override
  void onInit() {
    super.onInit();
   // fetchChatList();
  }

  Future<void> fetchChatHistory(TBLChat chat) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      ChatMessageListRequest request = ChatMessageListRequest(
          secretKey: secret_key,
          userId: initService.getUserId,
          convKey: chat.convkey ?? '',
          chatType: 'user',
          groupId: 0,
          pageId: 1);
      final response = await RequestApi.requestChatMessageList(
          request, initService.getToken);
      if (response?.status ?? false) {
        chatMessage.value = response!;
      }
      chatMessageLoading.value = false;
    }
    chatMessageLoading.value = false;
  }

  Future<void> fetchChatList() async {
    final box = Boxes.getChatList();
    chatLists.value = box.values.toList();
    Timer.periodic(const Duration(seconds: 3), (t) async {
      final isInternet = await ConstantUtils.isInternet();
      if (isInternet) {
        final response = await RequestApi.requestChatList(
            initService.getToken, initService.userId ?? 0);
        if (response?.status ?? false) {
          chatLists.value = response?.data ?? [];
          box.clear();
          box.addAll(chatLists);
        } else {
          chatLists.value = box.values.toList();
        }
        noticount.value = 0;
        for (var val in chatLists) {
          noticount += val.unreadCount ?? 0;
        }
        isLoading.value = false;
      }
    });
    noticount.value = 0;
    for (var val in chatLists) {
      noticount += val.unreadCount ?? 0;
    }
    isLoading.value = false;
  }

  searchChatList(String query) {
    if (query != '') {
      chatLists.value = [];
      for (var val in allChatLists) {
        if ((val.groupName ?? '').startsWith(query)) {
          chatLists.add(val);
        }
        if ((val.receiveName ?? '').startsWith(query)) {
          chatLists.add(val);
        }
      }
    } else {
      chatLists.value = allChatLists;
    }
    chatLists.refresh();
  }

  Future<void> fetchBlockUserList() async {
    blockUserLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestBlockUserList(
          initService.getToken, initService.userId ?? 0);
      if (response != null) {
        blockUserList.value = response.data;
      }
      blockUserLoading.value = false;
    }
    blockUserLoading.value = false;
  }

  Future<void> unblockUser(int unblockTo) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestBlockUser(
          initService.getToken, initService.getUserId, unblockTo, 0);
      if (response?.status ?? false) {
        blockUserList.removeWhere((element) => element.id == unblockTo);
        blockUserList.refresh();
      } else {
        debugPrint('error block ');
      }
    }
  }

  void unSelectUser() {
    for (var user in userLists) {
      if (user.selected ?? false) {
        user.selected = false;
      }
    }
  }

  void addMemberToList(int index) {
    userLists[index].selected = !(userLists[index].selected ?? false);
    if (userLists[index].selected ?? false) {
      memberList.add(userLists[index]);
    } else {
      memberList.remove(userLists[index]);
    }
    userLists.refresh();
    memberList.refresh();
  }

  Future<void> createGroup() async {
    List<int> members = [];
    for (var val in memberList) {
      members.add(val.id ?? 0);
    }
    members.add(initService.getUserId);
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      createGroupLoading.value = true;
      try {
        final response = await ImageUploadApi.requestCreateGroup(
            seletedImagePath.value,
            initService.getToken,
            initService.getUserId,
            groupNameController.text,
            members);
        if (response?.status ?? false) {
          showToast('successfully created group!');
          TBLGroup group = response?.data ?? TBLGroup();
          TBLChat chat = TBLChat(
            groupId: group.id,
            groupName: group.groupName,
            groupImage: group.groupImg,
            groupConvKey: group.groupConvKey,
            chatType: "group",
          );
          memberList.value = [];
          Get.off(GroupChatScreen(chat: chat));
        } else {
          debugPrint('error create group');
        }
        createGroupLoading.value = false;
      } catch (e) {
        createGroupLoading.value = false;
      }
    }
  }

  Future<void> deleteGroup(int groupId) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestDeleteGroup(
          initService.getToken, groupId, initService.getUserId);
      if (response?.status ?? false) {
        showToast("Successfully deleted!");
        fetchChatList();
      } else {
        debugPrint('error delete group');
      }
    }
  }

  Future<void> deleteUser(int toDeleteId, String convKey) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestDeleteUser(
          initService.getToken, toDeleteId, initService.getUserId, convKey);
      if (response?.status ?? false) {
        showToast("Successfully deleted!");
      } else {
        debugPrint('error delete user');
      }
    }
  }

  Future<void> leaveGroup(int groupId) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestLeaveGroup(
          initService.getToken, groupId, initService.getUserId);
      if (response?.status ?? false) {
      } else {
        debugPrint('error leave group');
      }
    }
  }

  Future<void> fetchUserList() async {
    allUserLists.value = [];
    isNewMessageLoading.value = true;

    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      RequestSaveContacts request = RequestSaveContacts(
          userId: initService.getUserId,
          secretKey: secret_key,
          phones: initService.getContacts);
      final response =
          await RequestApi.requestSendContacts(request, initService.getToken);

      if (response != null) {
        allUserLists.value = response.data;
        userLists = allUserLists;
      }
      isNewMessageLoading.value = false;
    }

    isNewMessageLoading.value = false;
  }

  Future<void> serachUser(String keyword) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestSearchUser(
          initService.getToken, initService.getUserId, keyword);

      if (response?.status ?? false) {
        userLists.value = response?.data ?? [];
      } else {
        userLists = allUserLists;
      }
      isNewMessageLoading.value = false;
    }
  }
}
