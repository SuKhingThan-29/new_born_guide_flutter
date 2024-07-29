import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/common/terms_and_condition_widget.dart';
import 'package:chitmaymay/controller/commons_controller.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_loading_button.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:chitmaymay/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/donnot_have_account_widget.dart';
import 'forget_password/forgot_password_request_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                          text: 'login'.tr,
                          textStyle: kTextStyleTitle(20),
                        )),
                        kVerticalSpace(12),
                        CustomTextField(
                          label: 'phoneno_username'.tr,
                          hintText: '',
                          controller: value.phoneNoController,
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
                        kVerticalSpace(2),
                        GestureDetector(
                          onTap: () {
                            Get.off(() => const ForgotPasswordRequestScreen());
                          },
                          child: kTextFieldTitle('forgot_password'.tr),
                        ),
                        kVerticalSpace(15),
                        value.isLoading
                            ? const Center(
                                child: SizedBox(
                                    width: 180, child: CustomLoadingButton()),
                              )
                            : Center(
                                child: CustomButton(
                                  backgroundColor: backgroundDarkPurple,
                                  textStyle: kTextStyleWhite(14),
                                  label: 'login'.tr,
                                  onTap: () {
                                    if (value.validateField()) {
                                      value.saveLogin(context);
                                    } else {
                                      showToast("Please fill all fields!");
                                    }
                                  },
                                ),
                              ),
                        const Spacer(),
                        const Center(
                          child: DonnotHaveAccount(),
                        ),
                        kVerticalSpace(10),
                        Center(child: TermsAndConditionWidget()),
                        const Spacer(),
                      ],
                    )),
              ),
            );
          },
        ));
  }
}
