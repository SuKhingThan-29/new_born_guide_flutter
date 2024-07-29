import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/common/donnot_have_account_widget.dart';
import 'package:chitmaymay/common/rounded_corner_button.dart';
import 'package:chitmaymay/common/terms_and_condition_widget.dart';
import 'package:chitmaymay/controller/commons_controller.dart';
import 'package:chitmaymay/screen/login/login_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:chitmaymay/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/custom_loading_button.dart';

class ForgotPasswordRequestScreen extends StatefulWidget {
  const ForgotPasswordRequestScreen({Key? key}) : super(key: key);
  @override
  _ForgotPasswordRequestScreenState createState() =>
      _ForgotPasswordRequestScreenState();
}

class _ForgotPasswordRequestScreenState
    extends State<ForgotPasswordRequestScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ComWidgets().logoWidget(),
                  Center(
                      child: CustomText(
                    text: 'forgot_password'.tr,
                    textStyle: kTextStyleTitle(20),
                  )),
                  kVerticalSpace(15),
                  Center(
                      child: CustomText(
                    text: 'otp_code_will_send'.tr,
                    textStyle: kTextStyleBlack(14),
                  )),
                  Center(
                      child: CustomText(
                    text: 'to_your_phone_no'.tr,
                    textStyle: kTextStyleBlack(14),
                  )),
                  kVerticalSpace(15),
                  CustomTextField(
                    label: 'phoneno'.tr,
                    hintText: '+95',
                    controller: value.forgotPasswordController,
                  ),
                  kVerticalSpace(35),
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: value.isLoading
                        ? const CustomLoadingButton()
                        : RoundedCornerButton(
                            onPressed: () {
                              if (value.forgotPasswordController.text
                                  .isNumericOnly) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                value.requestForgetOTP(
                                  context,
                                );
                              } else {
                                showToast('please enter phone no!');
                              }
                            },
                            buttonTitle: 'send_otp'.tr),
                  ),
                  kVerticalSpace(10),
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          Get.off(() => const LoginScreen());
                        },
                        child: CustomText(
                          text: 'cancel'.tr,
                          textStyle: kTextStyleBlack(14),
                        )),
                  ),
                  const Spacer(),
                  const Center(
                    child: DonnotHaveAccount(),
                  ),
                  kVerticalSpace(10.0),
                  Center(child: TermsAndConditionWidget()),
                  const Spacer(),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
