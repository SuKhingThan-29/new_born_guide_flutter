import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/common/rounded_corner_button.dart';
import 'package:chitmaymay/controller/commons_controller.dart';
import 'package:chitmaymay/screen/login/forget_password/forgot_password_request_screen.dart';
import 'package:chitmaymay/screen/login/login_screen.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/custom_loading_button.dart';

class ForgetVerifyOTPScreen extends StatefulWidget {
  final String phoneNo;
  final String resetpasswordscreen;
  const ForgetVerifyOTPScreen(
      {required this.phoneNo, required this.resetpasswordscreen, Key? key})
      : super(key: key);
  @override
  _ForgetVerifyOTPScreen createState() => _ForgetVerifyOTPScreen();
}

class _ForgetVerifyOTPScreen extends State<ForgetVerifyOTPScreen> {
  TextEditingController otpController = TextEditingController();
  late CountdownTimerController countdownTimerController;
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  late String _otpNumber = '';

  late String phoneNo;
  @override
  void initState() {
    phoneNo =
        '${widget.phoneNo.substring(0, 3)}${'*' * (widget.phoneNo.length - 4)}${widget.phoneNo.substring(widget.phoneNo.length - 3)}';

    countdownTimerController =
        CountdownTimerController(endTime: endTime, onEnd: onEnd);
    super.initState();
  }

  @override
  void dispose() {
    countdownTimerController.dispose();
    super.dispose();
  }

  void onEnd() {
    setState(() {
      Get.off(() => const ForgotPasswordRequestScreen());
    });
  }

  ComWidgets commonWidgets = ComWidgets();

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
                        commonWidgets.logoWidget(),
                        CustomText(
                          text: 'forgot_confirm_number'.tr,
                          textStyle: kTextStyleTitle(20),
                        ),
                        kVerticalSpace(15),
                        CustomText(
                          text: phoneNo,
                          textStyle: kTextStyleBlack(14),
                        ),
                        CustomText(
                          text: 'fill_otp_code'.tr,
                          textStyle: kTextStyleBlack(14),
                        ),
                        kVerticalSpace(15),
                        Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: OTPTextField(
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldWidth: 35,
                                fieldStyle: FieldStyle.box,
                                outlineBorderRadius: 15,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                                onChanged: (pin) {
                                  _otpNumber = pin;
                                },
                                onCompleted: (pin) {
                                  _otpNumber = pin;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                            )),
                        CountdownTimer(
                            controller: countdownTimerController,
                            onEnd: onEnd,
                            endTime: endTime),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'not_get_opt_code'.tr,
                                style: kTextStyleError(10),
                                children: [
                              TextSpan(
                                  text: 'please_send_again'.tr,
                                  style: kTextStyleColor(12),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        
                                      });
                                    }),
                            ])),
                        const SizedBox(
                          height: 15,
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: value.isLoading
                              ? const CustomLoadingButton()
                              : RoundedCornerButton(
                                  onPressed: () {
                                    if (_otpNumber.isNotEmpty) {
                                      value.saveForgetOTPVerify(
                                          context, _otpNumber, widget.phoneNo);
                                    } else {
                                      showToast("Please enter opt code!");
                                    }
                                  },
                                  buttonTitle: 'confirm'.tr),
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
                    ))),
          );
        },
      ),
    );
  }
}
