import 'package:chitmaymay/controller/group_chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_user.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/group_add_member.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/widgets/custom_alertdialog.dart';
import 'widgets/card_with_icon.dart';
import 'widgets/user_image_widget.dart';

class GroupChatSetting extends StatelessWidget {
  final TBLChat group;
  final List<TBLUser> members;
  GroupChatSetting({
    Key? key,
    required this.group,
    required this.members,
  }) : super(key: key);

  final GroupChatController _controller = Get.find<GroupChatController>();
  @override
  Widget build(BuildContext context) {
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
          actions: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: CustomText(
                        text: 'done'.tr, textStyle: kTextStyleError(14))),
              ),
            )
          ],
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                group.groupImage != ''
                    ? UserImageWidget(
                        size: 50,
                        imageUrl: group.groupImage ?? '',
                        name: group.groupName ?? '')
                    : CircleAvatar(
                        radius: 25,
                        backgroundColor: lightGrey,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: greyColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                kHorizontalSpace(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                            color: lightGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: group.groupName ?? '',
                            textStyle: kTextStyleBoldBlack(14),
                          ),
                        ),
                      ),
                      kVerticalSpace(4),
                      CustomText(
                          text: '${members.length} members',
                          textStyle: kTextStyleGrey(12))
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              kHorizontalSpace(8),
              CardWithIcon(
                  icon: Icons.person_add,
                  title: 'add_member'.tr,
                  onTap: () {
                    Get.to(() => GroupAddMember(controller: _controller,groupId: group.groupId?? 0,));
                  }),
              CardWithIcon(
                  icon: (_controller.chatInfo.value.muteStatus == 0)
                      ? Icons.notifications
                      : Icons.notifications_off,
                  title: (_controller.chatInfo.value.muteStatus == 0)
                      ? 'mute'.tr
                      : 'unmute'.tr,
                  onTap: () {
                    _controller.muteGroup(group.groupId ?? 0);
                  }),
              CardWithIcon(
                  icon: Icons.exit_to_app,
                  title: 'leave'.tr,
                  onTap: () {
                    showAlertDialog(context, 'group_leave'.tr,
                        'group_leave_text'.tr, 'leave'.tr, () {
                      Navigator.pop(context);
                      _controller.leaveGroup(
                          group.groupId ?? 0, group.isOwner ?? 0, context);
                    });
                  }),
              _controller.isMember(group.isOwner ?? 0)
                  ? CardWithIcon(
                      icon: Icons.delete,
                      title: 'delete'.tr,
                      onTap: () {
                        showAlertDialog(context, 'group_delete'.tr,
                            'group_delete_text'.tr, 'delete'.tr, () {
                          Navigator.pop(context);
                          _controller.deleteGroup(group.groupId ?? 0, context);
                        });
                      })
                  : const SizedBox.shrink(),
            ],
          ),
          kVerticalSpace(20),
          Expanded(
            child: ListView.builder(
                itemCount: members.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  TBLUser user = members[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border(
                            top: index == 0
                                ? const BorderSide(color: boderLightPurple)
                                : const BorderSide(color: whiteColor),
                            bottom: const BorderSide(color: boderLightPurple))),
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
                      ))
                    ]),
                  );
                }),
          )
        ]),
      );
    });
  }
}
