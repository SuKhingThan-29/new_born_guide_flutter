import 'package:chitmaymay/controller/group_chat_controller.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../db/dbModel/tbl_user.dart';
import '../../../../utils/style.dart';
import '../../../../utils/widgets/custom_text.dart';
import 'widgets/user_image_widget.dart';

class GroupAddMember extends StatelessWidget {
  final GroupChatController controller;
  final int groupId;
  const GroupAddMember(
      {Key? key, required this.controller, required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchUserList(groupId);
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
            text: 'add_member'.tr,
            textStyle: kTextStyleBoldColor(14),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  controller.addGroupMembers(groupId, context);
                },
                child: Center(
                    child: controller.addGpMemberLoading.value
                        ? const CustomLoading(size: 25)
                        : CustomText(
                            text: 'done'.tr, textStyle: kTextStyleError(14))),
              ),
            )
          ],
        ),
        body: controller.addMemberLoading.value
            ? const CustomLoading()
            : Column(children: [
                kDivider(),
                _searchTextField(),
                kDivider(),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.userLists.length,
                        itemBuilder: (context, index) {
                          TBLUser user = controller.userLists[index];
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
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: (user.selected ?? false)
                                          ? backgroundDarkPurple
                                          : whiteColor,
                                      border: Border.all(
                                          color: greyColor, width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                )
                              ]),
                            ),
                          );
                        }))
              ]),
      );
    });
  }

  Widget _searchTextField() {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 45,
      child: TextField(
        style: kTextStyleBlack(14),
        textAlignVertical: TextAlignVertical.center,
        onChanged: (keyword) {},
        decoration: InputDecoration(
            filled: true,
            fillColor: lightGrey,
            contentPadding: const EdgeInsets.all(14),
            hintText: 'who_would_you_like_to_add'.tr,
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
