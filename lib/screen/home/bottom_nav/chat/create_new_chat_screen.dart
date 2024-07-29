import 'package:chitmaymay/controller/chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_user.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/add_new_member.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/user_chat_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/search_textfield.dart';
import 'widgets/user_image_widget.dart';

class CreateNewChat extends StatelessWidget {
  final ChatController controller;
  const CreateNewChat({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchUserList();
    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
            onPressed: () => Get.back(),
          ),
          title: CustomText(
            text: 'new_message'.tr,
            textStyle: kTextStyleBoldColor(14),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          kDivider(),
          SearchTextField(
            controller: controller.searchController,
            onChange: (val) {
              controller.serachUser(val);
            },
          ),
          GestureDetector(
            onTap: () {
              Get.off(AddMember(
                controller: controller,
              ));
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: whiteColor,
                  border: Border(
                      top: BorderSide(color: boderLightPurple),
                      bottom: BorderSide(color: boderLightPurple))),
              height: 40,
              child: Row(children: [
                kHorizontalSpace(8),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.group_add,
                      color: greyColor,
                    )),
                kHorizontalSpace(8),
                CustomText(
                    text: 'create_group'.tr, textStyle: kTextStyleBlack(12))
              ]),
            ),
          ),
          kVerticalSpace(20),
          Expanded(
              child: controller.isNewMessageLoading.value
                  ? const CustomLoading()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.userLists.length,
                      itemBuilder: (context, index) {
                        TBLUser user = controller.userLists[index];
                        return GestureDetector(
                          onTap: () {
                            TBLChat chat = TBLChat(
                              receiveId: user.id,
                              receiveName: user.name,
                              receivePhone: user.phone,
                              receiveConvKey: user.receiveConvKey,
                              convkey: user.convKey,
                              receiveImage: user.imageUrl,
                              chatType: "user",
                            );
                            Get.off(UserChatScreen(chat: chat));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border(
                                    top: index == 0
                                        ? const BorderSide(
                                            color: boderLightPurple)
                                        : const BorderSide(color: whiteColor),
                                    bottom: const BorderSide(
                                        color: boderLightPurple))),
                            child: Row(children: [
                              UserImageWidget(
                                imageUrl: user.imageUrl ?? '',
                                name: user.name ?? '',
                                size: 35,
                              ),
                              kHorizontalSpace(12),
                              Expanded(
                                  child: CustomText(
                                text: user.name ?? '',
                                textStyle: kTextStyleBlack(12),
                              )),
                            ]),
                          ),
                        );
                      }))
        ]),
      );
    });
  }
}
