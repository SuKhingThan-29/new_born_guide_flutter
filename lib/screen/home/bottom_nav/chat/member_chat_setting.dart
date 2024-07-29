import 'package:chitmaymay/controller/user_chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/card_with_icon.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/user_image_widget.dart';

class MemberChatSetting extends StatelessWidget {
  final TBLChat chat;
  final ChatScreenController controller;
  const MemberChatSetting(
      {Key? key, required this.chat, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
            onPressed: (() => Get.back()),
          )),
      body: Obx(() {
        return Column(children: [
          Center(
            child: UserImageWidget(
              imageUrl: chat.receiveImage ?? '',
              name: chat.receiveName ?? '',
              size: 70,
            ),
          ),
          kVerticalSpace(8),
          CustomText(
              text: chat.receiveName ?? '', textStyle: kTextStyleBoldBlack(20)),
          kVerticalSpace(4),
          CustomText(
              text: chat.receivePhone ?? '', textStyle: kTextStyleBlack(14)),
          kVerticalSpace(15),
          Row(
            children: [
              const Spacer(),
              CardWithIcon(
                  icon: (controller.chatInfo.value.muteStatus == 0)
                      ? Icons.notifications
                      : Icons.notifications_off,
                  title: (controller.chatInfo.value.muteStatus == 0)
                      ? 'mute'.tr
                      : 'unmute'.tr,
                  onTap: () {
                    controller.muteUser(chat.receiveId ?? 0);
                  }),
              CardWithIcon(
                icon: (controller.chatInfo.value.blockStatus == 0)
                    ? Icons.person
                    : Icons.block,
                title: (controller.chatInfo.value.blockStatus == 0)
                    ? 'block'.tr
                    : 'unblock'.tr,
                onTap: () {
                  controller.blockUser(chat.receiveId ?? 0);
                },
                textStyle: kTextStyleError(12),
              ),
              const Spacer()
            ],
          ),
        ]);
      }),
    );
  }
}
