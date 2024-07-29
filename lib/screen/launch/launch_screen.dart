import 'package:chitmaymay/common/language_chage_widget.dart';
import 'package:chitmaymay/controller/sign_up_controller.dart';
import 'package:chitmaymay/screen/login/login_screen.dart';
import 'package:chitmaymay/screen/login/signup/signup_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:chitmaymay/utils/widgets/launch_screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);

  final SignUpController _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SizedBox(
                  width: logoWidth,
                  height: logoHeight,
                  child: Image.asset(
                    'assets/icon/icon.png',
                  ),
                ),
                SizedBox(
                  height: spaceMedium,
                ),
                LaunchScreenButton(
                    label: 'signup'.tr,
                    backgroundColor: backgroundDarkPurple,
                    textStyle: kTextStyleWhite(14),
                    onTap: () {
                      Get.off(() => const SignUpScreen());
                    }),
                LaunchScreenButton(
                  onTap: () async {
                    _controller.signInWithGoogle(context);
                  },
                  label: "continue_with_google".tr,
                  widget: _controller.googleSignInLoading.value
                      ? const CustomLoading(
                          size: 30,
                        )
                      : SvgPicture.asset(
                          'assets/icon/google_icon.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                ),
                LaunchScreenButton(
                  onTap: () async {
                    _controller.signInWithFacebook(context);
                  },
                  label: 'continue_with_facebook'.tr,
                  widget: _controller.fbSignInLoading.value
                      ? const CustomLoading(
                          size: 30,
                        )
                      : SvgPicture.asset(
                          'assets/icon/fb_icon.svg',
                          allowDrawingOutsideViewBox: true,
                        ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  label: 'login'.tr,
                  onTap: () {
                    Get.off(() => const LoginScreen());
                  },
                  backgroundColor: greenColor,
                  textStyle: kTextStyleWhite(14),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'language'.tr,
                      textStyle: kTextStyleBlack(12),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    const LanguateChangeWidget(),
                  ],
                ),
                kVerticalSpace(20)
              ],
            ),
          ),
        ),
      );
    });
  }
}
