import 'package:chitmaymay/controller/language_controller.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/home/nav/term_condition_screen.dart';

class TermsAndConditionWidget extends StatelessWidget {
  TermsAndConditionWidget({Key? key}) : super(key: key);
  final LanguageController _controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.isMyanmarLang.value
          ? RichText(
              text: TextSpan(text: '', children: [
                TextSpan(
                    text: 'terms_and_condition'.tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => TermAndConditionScreen());
                      },
                    style: kTextStyleColorUnderLine(12)),
                TextSpan(text: 'agree_with'.tr, style: kTextStyleBlack(12))
              ]),
            )
          : RichText(
              text: TextSpan(
                  text: 'agree_with'.tr,
                  style: kTextStyleGrey(12),
                  children: [
                    TextSpan(
                        text: 'terms_and_condition'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => TermAndConditionScreen());
                          },
                        style: kTextStyleColorUnderLine(12))
                  ]),
            );
    });
  }
}
