import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/utils/widgets/custom_alertdialog.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/style.dart';
import '../../../../../utils/widgets/custom_text.dart';

class ChangeEmail extends StatelessWidget {
  final SettingController controller;
  ChangeEmail({Key? key, required this.controller}) : super(key: key);

  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();

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
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'change_email'.tr,
          textStyle: kTextStyleBlack(16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          CustomTextField(
            label: 'current_email'.tr,
            hintText: '',
            controller: currentEmailController,
          ),
          kVerticalSpace(8),
          CustomTextField(
            label: 'new_email'.tr,
            hintText: '',
            controller: newEmailController,
          ),
          kVerticalSpace(4),
          CustomText(
              text: 'change_email_text'.tr, textStyle: kTextStyleGrey(14)),
          kVerticalSpace(30),
          CustomButton(
              label: 'save'.tr,
              onTap: () {
                if (currentEmailController.text.isEmpty ||
                    newEmailController.text.isEmpty) {
                  showAlertDialog(
                      context, 'Error', 'Please fill all the fields!', 'OK',
                      () {
                    Navigator.pop(context);
                  });
                } else if (currentEmailController.text !=
                    newEmailController.text) {
                 
                  controller.updateEmail(newEmailController.text);

                } else {
                  showAlertDialog(context, 'Error',
                      'New Email must be different with old email!', 'OK', () {
                    Navigator.pop(context);
                  });
                }
              })
        ]),
      ),
    );
  }
}
