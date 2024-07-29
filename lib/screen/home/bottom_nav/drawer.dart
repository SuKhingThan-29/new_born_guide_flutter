import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/screen/home/nav/about_us_screen.dart';
import 'package:chitmaymay/screen/home/nav/device_manager/device_manager_screen.dart';
import 'package:chitmaymay/screen/home/nav/invite.dart';
import 'package:chitmaymay/screen/home/nav/privacy_policy_screen.dart';
import 'package:chitmaymay/screen/home/nav/term_condition_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_section_title.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../nav/bmi_calculation/_bmi_calculation.dart';
import 'chat/widgets/user_image_widget.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final SettingController _controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Drawer(
          backgroundColor: backgroundDarkPurple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              kVerticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kHorizontalSpace(20),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: whiteColor, width: 1)),
                        width: 80,
                        height: 80,
                        child: ((_controller.userProfile.value.image ?? '')
                                .isEmpty)
                            ? SvgPicture.asset('assets/icon/profile.svg')
                            : UserImageWidget(
                                imageUrl:
                                    _controller.userProfile.value.image ?? '',
                                name: _controller.userProfile.value.fullName ??
                                    ''),
                      ),
                      (_controller.userProfile.value.isPremium ?? 0) == 1
                          ? Positioned(
                              bottom: 5,
                              right: -1,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    color: backgroundColor,
                                    shape: BoxShape.circle),
                                width: 30,
                                height: 30,
                                child:
                                    SvgPicture.asset('assets/icon/crown.svg'),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  kHorizontalSpace(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kVerticalSpace(20),
                        CustomText(
                            text: _controller.userProfile.value.username ?? "",
                            textStyle: kTextStyleWhite(20)),
                        CustomText(
                            text: _controller.userProfile.value.phoneNo ?? "",
                            textStyle: kTextStyleWhite(12))
                      ],
                    ),
                  )
                ],
              ),
              kVerticalSpace(45),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30))),
                  child: Column(children: [
                    kVerticalSpace(4),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shadowColor: Colors.black,
                        elevation: 4.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0)),
                      ),
                      onPressed: () => {context.next(const BMICalculation())},
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Image.asset(
                          'assets/img/bmi.png',
                          width: 30,
                          height: 30,
                        ),
                        kHorizontalSpace(4),
                        CustomText(
                            text: 'bmi_calculation'.tr,
                            textStyle: kTextStyleBoldBlack(14))
                      ]),
                    ),
                    kVerticalSpace(12),
                    CustomSectionTitle(
                      onTap: () {},
                      title: 'my_wallet'.tr,
                      backgroundColor: whiteColor,
                      iconColor: checkedColor,
                      titleColor: blackColor,
                      noBorder: true,
                    ),
                    kVerticalSpace(2),
                    CustomSectionTitle(
                      onTap: () {
                        context.next(const InviteScreen());
                      },
                      title: 'invite_friends'.tr,
                      backgroundColor: whiteColor,
                      iconColor: checkedColor,
                      titleColor: blackColor,
                      noBorder: true,
                    ),
                    kVerticalSpace(2),
                    CustomSectionTitle(
                      onTap: () {
                        context.next(DeviceManagerScreen(
                          controller: _controller,
                        ));
                      },
                      title: 'device_manager'.tr,
                      backgroundColor: whiteColor,
                      iconColor: blackColor,
                      titleColor: blackColor,
                      noBorder: true,
                      widget: Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: greenColor),
                        child: Center(
                          child: Text(
                            '${_controller.deviceList.length}/3  devices',
                            style: kTextStyleWhite(12),
                          ),
                        ),
                      ),
                    ),
                    kVerticalSpace(2),
                    CustomSectionTitle(
                      onTap: () {
                        context.next(const TermAndConditionScreen());
                      },
                      title: 'terms_and_conditions'.tr,
                      backgroundColor: whiteColor,
                      iconColor: checkedColor,
                      titleColor: blackColor,
                      noBorder: true,
                    ),
                    kVerticalSpace(2),
                    CustomSectionTitle(
                      onTap: () {
                        context.next(PrivacyPolicyScreen(
                          controller: _controller,
                        ));
                      },
                      title: 'privacy_policy'.tr,
                      backgroundColor: whiteColor,
                      iconColor: checkedColor,
                      titleColor: blackColor,
                      noBorder: true,
                    ),
                    kVerticalSpace(2),
                    CustomSectionTitle(
                      onTap: () {
                        context.next(AboutUs(
                          controller: _controller,
                        ));
                      },
                      title: 'about_chitmaymay'.tr,
                      backgroundColor: whiteColor,
                      iconColor: checkedColor,
                      titleColor: blackColor,
                      noBorder: true,
                    ),
                    kVerticalSpace(2),
                    CustomSectionTitle(
                      onTap: () {},
                      title: 'version'.tr,
                      backgroundColor: whiteColor,
                      iconColor: checkedColor,
                      titleColor: blackColor,
                      noBorder: true,
                      widget: Text(
                        '1.0.0',
                        style: kTextStyleGrey(14),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ));
    });
  }
}
