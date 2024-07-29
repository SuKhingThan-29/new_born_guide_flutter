import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_loading_button.dart';
import 'package:chitmaymay/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/setting_controller.dart';

class UserFeedback extends StatelessWidget {
  final SettingController controller;
  @override
  UserFeedback({Key? key, required this.controller}) : super(key: key);
  final TextEditingController subjectController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: 'user_feedback'.tr,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: "subject".tr,
                  hintText: "",
                  controller: subjectController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: "write_message".tr,
                  hintText: "",
                  isTextArea: true,
                  controller: messageController,
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(() {
                  return controller.feedbackLoading.value
                      ? const Center(
                          child: SizedBox(
                              width: 180, child: CustomLoadingButton()),
                        )
                      : Center(
                          child: CustomButton(
                            backgroundColor: backgroundDarkPurple,
                            textStyle: kTextStyleWhite(14),
                            label: 'send'.tr,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (subjectController.text.isNotEmpty &&
                                  messageController.text.isNotEmpty) {
                                controller.sendFeedback(subjectController.text,
                                    messageController.text, context);
                              } else {
                                showToast('Please fill all fields!');
                              }
                            },
                          ),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
