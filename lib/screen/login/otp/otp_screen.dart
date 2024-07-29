import 'package:chitmaymay/controller/sign_up_controller.dart';
import 'package:chitmaymay/screen/login/signup/signup_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../common/rounded_corner_button.dart';
import '../../../utils/widgets/custom_loading_button.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNo;
  const OTPScreen({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  late CountdownTimerController countdownTimerController;
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  late String _otpNumber = '';
  final SignUpController controller = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();
    phoneNo =
        '${widget.phoneNo.substring(0, 3)}${'*' * (widget.phoneNo.length - 4)}${widget.phoneNo.substring(widget.phoneNo.length - 3)}';
    countdownTimerController =
        CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    Get.off(() => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'assets/icon/icon.png',
                        ),
                      ),
                    ),
                    CustomText(
                      text: 'confirm_number'.tr,
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
                            textFieldAlignment: MainAxisAlignment.spaceAround,
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
                              FocusScope.of(context).requestFocus(FocusNode());
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
                                  controller.resendOtpRegister(
                                      context, widget.phoneNo);
                                }),
                        ])),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: controller.verifyRegisterLoading.value
                              ? const CustomLoadingButton()
                              : RoundedCornerButton(
                                  onPressed: () {
                                    if (_otpNumber.isNotEmpty) {
                                      controller.verifyRegister(
                                          context, widget.phoneNo, _otpNumber);
                                    } else {
                                      showToast("Please enter opt code!");
                                    }
                                  },
                                  buttonTitle: 'confirm'.tr),
                        ),
                      );
                    }),
                    kVerticalSpace(15),
                    GestureDetector(
                        onTap: () {
                          Get.off(() => const SignUpScreen());
                        },
                        child: CustomText(
                          text: 'cancel'.tr,
                          textStyle: kTextStyleBlack(12),
                        )),
                  ],
                ))));
  }
}
