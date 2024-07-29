import 'package:chitmaymay/controller/chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/group_chat_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/create_new_chat_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/user_chat_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/chat_list_item.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/search_textfield.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../../service/init_service.dart';
import '../../../../utils/widgets/custom_alertdialog.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key);

  final ChatController _controller = Get.find<ChatController>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
          // leading: IconButton(
          //   onPressed: null,
          //   icon: CustomText(
          //     text: 'edit'.tr,
          //     textStyle: kTextStyleError(14),
          //   ),
          // ),
          title: CustomText(
            text: 'chats'.tr,
            textStyle: kTextStyleBoldColor(16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(CreateNewChat(
                    controller: _controller,
                  ));
                },
                icon: const Icon(
                  Icons.person_add,
                  color: blackColor,
                ))
          ],
        ),
        body: Obx(() {
          return _controller.isLoading.value
              ? const Center(child: CustomLoading())
              : Column(
                  children: [
                    kDivider(),
                    SearchTextField(
                      controller: _controller.searchController,
                      onChange: (val) {
                        _controller.searchChatList(val);
                      },
                    ),
                    kDivider(),
                    Expanded(
                        child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: backgroundDarkPurple,
                      onRefresh: () async {
                        _controller.fetchChatList();
                      },
                      child: SingleChildScrollView(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _controller.chatLists.length,
                            separatorBuilder: (context, index) => kDivider(),
                            itemBuilder: (context, index) {
                              TBLChat chatData = _controller.chatLists[index];
                              return GestureDetector(
                                  onTap: () {
                                    if (chatData.groupId == null) {
                                      Get.to(() => UserChatScreen(
                                            chat: chatData,
                                          ));
                                    } else {
                                      Get.to(() => GroupChatScreen(
                                            chat: chatData,
                                          ));
                                    }
                                  },
                                  child: Slidable(
                                    startActionPane: ActionPane(
                                        extentRatio: 0.35,
                                        motion: const ScrollMotion(),
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (chatData.groupId != null) {
                                                  if (chatData.isOwner ==
                                                      initService.getUserId) {
                                                    showAlertDialog(
                                                        context,
                                                        'group_delete'.tr,
                                                        'group_delete_text'.tr,
                                                        'delete'.tr, () {
                                                      Get.back();
                                                      _controller.deleteGroup(
                                                          chatData.groupId ??
                                                              0);
                                                    });
                                                  } else {
                                                    showAlertDialog(
                                                        context,
                                                        'group_delete'.tr,
                                                        'Are you sure to leave and delete group'
                                                            .tr,
                                                        'delete'.tr, () {
                                                      Get.back();
                                                      _controller.leaveGroup(
                                                          chatData.groupId ??
                                                              0);
                                                    });
                                                  }
                                                } else {
                                                  showAlertDialog(
                                                      context,
                                                      'group_delete'.tr,
                                                      'Are you sure to delete chat history'
                                                          .tr,
                                                      'delete'.tr, () {
                                                    Get.back();
                                                    _controller.deleteUser(
                                                        chatData.receiveId ?? 0,
                                                        chatData.convkey ?? '');
                                                  });
                                                }
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4,
                                                      vertical: 8),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                          color: redColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: redColor,
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {},
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4,
                                                      vertical: 8),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                          color:
                                                              backgroundDarkPurple),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: const Icon(
                                                    Icons.volume_up,
                                                    color: backgroundDarkPurple,
                                                  )),
                                            ),
                                          ),
                                        ]),
                                    child: ChatListItem(
                                      chatData: chatData,
                                    ),
                                  ));
                            }),
                      ),
                    ))
                  ],
                );
        }),
      ),
    );
  }
}
