import 'package:chitmaymay/controller/chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_block_user.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/widgets/custom_alertdialog.dart';
import '../../chat/widgets/user_image_widget.dart';

class BlockUserScreen extends StatelessWidget {
  final ChatController controller;
  const BlockUserScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          text: 'blocked_users'.tr,
          textStyle: kTextStyleBoldBlack(14),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.blockUserLoading.value
            ? const Center(
                child: CustomLoading(),
              )
            : Column(children: [
                kDivider(),
                _searchTextField(),
                kDivider(),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.blockUserList.length,
                        itemBuilder: (context, index) {
                          TBLBlockUser user = controller.blockUserList[index];
                          return InkWell(
                            onTap: () {
                              controller.addMemberToList(index);
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
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(context, 'confirmation'.tr,
                                        'unblock_text'.tr, 'ok'.tr, () {
                                      Get.back();
                                      controller.unblockUser(user.id ?? 0);
                                    });
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        border: Border.all(
                                            color: backgroundDarkPurple,
                                            width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Center(
                                        child: CustomText(
                                      text: 'Unblock',
                                      textStyle: kTextStyleColor(12),
                                    )),
                                  ),
                                )
                              ]),
                            ),
                          );
                        }))
              ]);
      }),
    );
  }

  Widget _searchTextField() {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 45,
      child: TextField(
        style: kTextStyleBlack(14),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            filled: true,
            fillColor: lightGrey,
            contentPadding: const EdgeInsets.all(14),
            hintText: 'search'.tr,
            border: InputBorder.none,
            enabledBorder: _borders(),
            focusedBorder: _borders(),
            disabledBorder: _borders()),
      ),
    );
  }

  _borders() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(width: 1, color: lightGrey));
  }
}
