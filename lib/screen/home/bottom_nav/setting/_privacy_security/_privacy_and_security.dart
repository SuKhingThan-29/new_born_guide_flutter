import 'package:chitmaymay/screen/home/bottom_nav/setting/_privacy_security/block_user.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_privacy_security/privacy_security_item.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/chat_controller.dart';
import '../../../../../utils/constants.dart';

class PrivacyAndSecurity extends StatelessWidget {
  PrivacyAndSecurity({Key? key}) : super(key: key);
  final ChatController controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchBlockUserList();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(
          title: 'privcy_security'.tr,
        ),
        body: Obx(() {
          return Column(
            children: [
              PrivacySecurityItem(
                title: 'blocked_users'.tr,
                data: controller.blockUserList.isNotEmpty
                    ? controller.blockUserList.length.toString()
                    : 'None',
                onTap: () {
                  Get.to(BlockUserScreen(
                    controller: controller,
                  ));
                },
                topBorder: true,
              ),
              kVerticalSpace(20),
              PrivacySecurityItem(
                title: 'phone_number'.tr,
                data: 'Nobody',
                onTap: () {},
                topBorder: true,
              ),
              PrivacySecurityItem(
                  title: 'profile_photo'.tr, data: 'My contacts', onTap: () {}),
              PrivacySecurityItem(
                  title: 'group_and_channel'.tr,
                  data: 'My contacts',
                  onTap: () {}),
            ],
          );
        }));
  }
}
