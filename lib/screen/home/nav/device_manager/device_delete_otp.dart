import 'package:chitmaymay/common/otp_widget.dart';
import 'package:chitmaymay/common/rounded_corner_button.dart';
import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/widgets/custom_text.dart';

class DeviceDeleteOtp extends StatefulWidget {
  final List<String> selectedDeviceList;
  const DeviceDeleteOtp({Key? key, required this.selectedDeviceList})
      : super(key: key);
  @override
  DeviceDeleteOtpState createState() => DeviceDeleteOtpState();
}

class DeviceDeleteOtpState extends State<DeviceDeleteOtp> {
  String _otpNumber = '';
  late CountdownTimerController countdownTimerController;
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  final SettingController _controller = Get.find<SettingController>();

  void onEnd() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.getPhoneNo();
    countdownTimerController =
        CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void dispose() {
    countdownTimerController.dispose();
    super.dispose();
  }

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
          text: 'device_manager'.tr,
          textStyle: kTextStyleBlack(16),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                      '${_controller.phoneNo} သို့ပေးပို့သော အတည် ပြုကုဒ် ကိုထည့်ပါ'),
                ),
                OTPWidget(
                    onChanged: (pin) {
                      setState(() {
                        _otpNumber = pin;
                      });
                    },
                    onCompleted: (pin) {
                      setState(() {
                        _otpNumber = pin;
                      });
                    },
                    otpLength: 6),
                kVerticalSpace(20),
                CountdownTimer(
                    controller: countdownTimerController,
                    onEnd: onEnd,
                    endTime: endTime),
                kVerticalSpace(15),
                RichText(
                    text: TextSpan(
                        text: 'do_you_get_otp'.tr,
                        style: kTextStyleError(10),
                        children: [
                      TextSpan(
                          text: 'resend'.tr,
                          style: kTextStyleColor(12),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            }),
                    ])),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: spaceLeft, right: spaceRight),
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: RoundedCornerButton(
                          onPressed: () {
                            if (_otpNumber.isNotEmpty) {
                              _controller.deviceOTP(_otpNumber);
                            }
                          },
                          buttonTitle: 'confirm'.tr),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
