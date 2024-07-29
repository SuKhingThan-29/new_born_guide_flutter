import 'package:chitmaymay/common/rounded_corner_button.dart';
import 'package:chitmaymay/common/terms_condition_agree.dart';
import 'package:chitmaymay/controller/sign_up_controller.dart';
import 'package:chitmaymay/screen/launch/launch_screen.dart';
import 'package:chitmaymay/screen/login/login_screen.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_error_text.dart';
import 'package:chitmaymay/utils/widgets/custom_loading_button.dart';
import 'package:chitmaymay/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';
import '../../../utils/widgets/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: GetBuilder<SignUpController>(
          init: SignUpController(),
          builder: (value) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: logoWidth,
                        height: logoWidth,
                        child: Image.asset(
                          'assets/icon/icon.png',
                        ),
                      ),
                      Center(
                          child: CustomText(
                        text: 'signup'.tr,
                        textStyle: kTextStyleTitle(20),
                      )),
                      CustomTextField(
                        label: 'username'.tr,
                        hintText: "",
                        controller: value.usernameController,
                      ),
                      value.filledUserName
                          ? Container()
                          : CustomErrorText(
                              label: 'please_fill_username'.tr,
                            ),
                      kVerticalSpace(10),
                      CustomTextField(
                        label: 'phoneno'.tr,
                        hintText: "+95",
                        controller: value.phoneNoController,
                      ),
                      value.filledPhoneNo
                          ? Container()
                          : CustomErrorText(
                              label: 'please_fill_phone'.tr,
                            ),
                      kVerticalSpace(10),
                      CustomTextField(
                        label: 'password'.tr,
                        hintText: "",
                        controller: value.passwordController,
                        isObsecure: value.passwordSeen,
                        showSuffixIcon: true,
                        updateSeen: () {
                          value.passwordSeen = !value.passwordSeen;
                          value.update();
                        },
                      ),
                      value.filledPassword
                          ? Container()
                          : CustomErrorText(
                              label: 'please_fill_password'.tr,
                            ),
                      kVerticalSpace(10),
                      CustomTextField(
                        label: 'comfirm_password'.tr,
                        hintText: "",
                        controller: value.confirmPasswordController,
                        isObsecure: value.confirmSeen,
                        showSuffixIcon: true,
                        updateSeen: () {
                          value.confirmSeen = !value.confirmSeen;
                          value.update();
                        },
                      ),
                      value.filledConfirmedPassword
                          ? Container()
                          : CustomErrorText(
                              label: 'please_fill_same_password'.tr,
                            ),
                      TermsAndConditionAgree(
                        isCheck: value.checkBox,
                        onChanged: (valueChanged) {
                          value.updateCheckBox(valueChanged);
                        },
                      ),
                      value.isCheck
                          ? Container()
                          : CustomErrorText(
                              label: 'please_check'.tr,
                            ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: spaceLeft, right: spaceRight),
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: value.isLoading
                                ? const CustomLoadingButton()
                                : RoundedCornerButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      value.validate(context);
                                    },
                                    buttonTitle: 'create_account'.tr),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.off(() => const LoginScreen());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'already_have_account'.tr,
                              style: kTextStyleBlack(12),
                              children: [
                                TextSpan(
                                  text: 'login'.tr,
                                  style: kTextStyleGreen(12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(() =>  LaunchScreen());
                        },
                        child: Center(
                          child: CustomText(
                            text: 'try_another_way'.tr,
                            textStyle: kTextStyleColor(14),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
