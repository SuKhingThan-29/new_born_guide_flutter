import 'dart:io';

import 'package:chitmaymay/db/dbModel/tbl_user.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/chat_controller.dart';
import '../../../../utils/widgets/custom_text.dart';
import 'widgets/user_image_widget.dart';

class CreateGroup extends StatelessWidget {
  CreateGroup({Key? key}) : super(key: key);
  final ChatController controller = Get.find<ChatController>();
  final _picker = ImagePicker();

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
              onPressed: () {
                controller.memberList.value = [];
                Get.back();
              }),
          actions: [
            GestureDetector(
              onTap: () {
                if (controller.groupNameController.text.isEmpty) {
                  showToast("Please fill group name!");
                  return;
                }
                if (controller.seletedImagePath.isEmpty) {
                  showToast("Please add group image!");
                  return;
                }
                controller.createGroup();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: controller.createGroupLoading.value
                        ? const CustomLoading(size: 25)
                        : CustomText(
                            text: 'create'.tr, textStyle: kTextStyleError(14))),
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
                controller.seletedImagePath.value != ''
                    ? GestureDetector(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(File(
                                        controller.seletedImagePath.value))))),
                      )
                    : CircleAvatar(
                        radius: 25,
                        backgroundColor: lightGrey,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: greyColor,
                          ),
                          onPressed: () {
                            _imgFromGallery();
                          },
                        ),
                      ),
                kHorizontalSpace(8),
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: controller.groupNameController,
                        style: kTextStyleBlack(14),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: lightGrey,
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'Group Name',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: controller.memberList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  TBLUser user = controller.memberList[index];
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

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    final File file = File(image!.path);
    controller.seletedImagePath.value = file.path;
  }
}
