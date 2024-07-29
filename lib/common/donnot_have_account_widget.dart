import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/launch/launch_screen.dart';
import '../utils/constants.dart';

class DonnotHaveAccount extends StatelessWidget {
  const DonnotHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.off(() =>  LaunchScreen());
      },
      child: RichText(
        text: TextSpan(
          text: 'donnot_have_account'.tr,
          style: kTextStyleError(10),
          children: [
            TextSpan(
              text: 'signup'.tr,
              style: kTextStyleColor(12),
            ),
          ],
        ),
      ),
    );
  }
}
