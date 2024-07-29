import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/utils/widgets/custom_alertdialog.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_loading_button.dart';
import 'package:chitmaymay/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/style.dart';
import '../../../../../utils/widgets/custom_text.dart';

class ChangePassword extends StatelessWidget {
  final SettingController controller;
  ChangePassword({Key? key, required this.controller}) : super(key: key);
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.changePasswordLoading.value = false;
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
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'change_password'.tr,
          textStyle: kTextStyleBlack(16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            kTextFieldTitle('phone_number'.tr),
            kVerticalSpace(4),
            CustomText(
                text: controller.userProfile.value.phoneNo ?? '',
                textStyle: kTextStyleGrey(14)),
            kVerticalSpace(12),
            CustomTextField(
              label: 'old_password'.tr,
              hintText: '',
              controller: oldPasswordController,
              isObsecure: true,
            ),
            kVerticalSpace(4),
            CustomTextField(
              label: 'new_password'.tr,
              hintText: '',
              controller: newPasswordController,
              isObsecure: true,
            ),
            kVerticalSpace(4),
            CustomText(
                text: 'change_password_text'.tr, textStyle: kTextStyleGrey(12)),
            kVerticalSpace(12),
            CustomTextField(
              label: 'confirm_password'.tr,
              hintText: '',
              controller: confirmPasswordController,
              isObsecure: true,
            ),
            kVerticalSpace(30),
            Obx(() {
              return Center(
                  child: controller.changePasswordLoading.value
                      ? const SizedBox(
                          width: 100,
                          child: CustomLoadingButton(),
                        )
                      : CustomButton(
                          label: 'save'.tr,
                          onTap: () {
                            if (newPasswordController.text.isEmpty ||
                                confirmPasswordController.text.isEmpty ||
                                oldPasswordController.text.isEmpty) {
                              showAlertDialog(context, 'Error',
                                  'Please fill all the fields!', 'OK', () {
                                Navigator.pop(context);
                              });
                            } else if (newPasswordController.text ==
                                confirmPasswordController.text) {
                              controller.updatePassword(
                                  newPasswordController.text,
                                  oldPasswordController.text);
                            } else {
                              showAlertDialog(
                                  context,
                                  'Error',
                                  'Confirm password must be same with password!',
                                  'OK', () {
                                Navigator.pop(context);
                              });
                            }
                          }));
            })
          ]),
        ),
      ),
    );
  }
}
