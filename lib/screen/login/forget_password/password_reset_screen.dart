import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/controller/commons_controller.dart';
import 'package:chitmaymay/screen/login/login_screen.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/rounded_corner_button.dart';
import '../../../utils/constants.dart';
import '../../../utils/widgets/custom_loading_button.dart';
import '../../../utils/widgets/custom_textfield.dart';

class PasswordResetScreen extends StatefulWidget {
  final String phone;
  const PasswordResetScreen({required this.phone, Key? key}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: GetBuilder<CommonsController>(
          init: CommonsController(),
          builder: (value) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ComWidgets().logoWidget(),
                    CustomText(
                      text: 'change_new_password'.tr,
                      textStyle: kTextStyleTitle(20),
                    ),
                    kVerticalSpace(15),
                    CustomText(
                      text: 'otp_your_new_password'.tr,
                      textStyle: kTextStyleBlack(14),
                    ),
                    CustomText(
                      text: 'cannot_same_old_password'.tr,
                      textStyle: kTextStyleBlack(14),
                    ),
                    kVerticalSpace(12),
                    CustomTextField(
                      label: 'password'.tr,
                      isObsecure: true,
                      hintText: '',
                      controller: value.changePasswordController,
                    ),
                    kVerticalSpace(10),
                    CustomTextField(
                      isObsecure: true,
                      label: 'comfirm_password'.tr,
                      hintText: '',
                      controller: value.changePasswordConfirmController,
                    ),
                    kVerticalSpace(12),
                    const SizedBox(
                      height: 20,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: value.isLoading
                          ? const CustomLoadingButton()
                          : RoundedCornerButton(
                              onPressed: () {
                                if (value.changePasswordValidate()) {
                                  value.savePasswordReset(
                                      context, widget.phone);
                                }
                              },
                              buttonTitle: 'change_password'.tr),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: CustomText(
                          text: 'cancel'.tr,
                          textStyle: kTextStyleBlack(12),
                        )),
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
