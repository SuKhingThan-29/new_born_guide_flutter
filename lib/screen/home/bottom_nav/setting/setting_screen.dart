import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chitmaymay/common/language_chage_widget.dart';
import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/user_image_widget.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_save/save_content_list_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_user_feedback/_user_feedback.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_alertdialog.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_section_title.dart';
import 'package:chitmaymay/utils/widgets/custom_switch_button.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '_apperance/_apperance.dart';
import '_premium/_subscription/subscription_screen.dart';
import '_privacy_security/_privacy_and_security.dart';
import '_profile/_profile_screen.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final SettingController _controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: borderLineColor))),
                  child: Column(
                    children: [
                      Center(
                          child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            width: 100,
                            height: 100,
                            child: ((_controller.userProfile.value.image ?? '')
                                    .isEmpty)
                                ? SvgPicture.asset('assets/icon/profile.svg')
                                : UserImageWidget(
                                    imageUrl:
                                        _controller.userProfile.value.image ??
                                            '',
                                    name: _controller
                                            .userProfile.value.fullName ??
                                        ''),
                          ),
                          (_controller.userProfile.value.isPremium ?? 0) == 1
                              ? Positioned(
                                  bottom: 1,
                                  right: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        color: backgroundColor,
                                        shape: BoxShape.circle),
                                    width: 40,
                                    height: 40,
                                    child: SvgPicture.asset(
                                        'assets/icon/crown.svg'),
                                  ),
                                )
                              : Positioned(
                                  bottom: 1, right: 5, child: Container())
                        ],
                      )),
                      kVerticalSpace(8),
                      CustomText(
                        text: _controller.userProfile.value.username ?? '',
                        textStyle: kTextStyleBoldBlack(16),
                      ),
                      CustomText(
                        text: _controller.userProfile.value.phoneNo ?? '',
                        textStyle: kTextStyleTitlePurple(14),
                      ),
                      kVerticalSpace(25),
                      _controller.noSubscribtion
                          ? Container()
                          : Text(
                              _controller.isPremium.value &&
                                      _controller.premiumDay > 0
                                  ? 'သင်၏ပရီပီယမ်သက်တမ်း ${_controller.premiumDay}ရက် ကျန်ပါသေးသည်။'
                                  : 'သင်၏ပရီပီယမ်သက်တမ်း ကုန်ဆုံးသွားပါသည်။',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _controller.isPremium.value &&
                                          _controller.premiumDay > 0
                                      ? Colors.black
                                      : Colors.red),
                            ),
                      kVerticalSpace(5),
                      _controller.isPremium.value && _controller.premiumDay > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 70,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            _controller.mTopColor,
                                            _controller.mBottomColor
                                          ]),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${_controller.premiumDay}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        const Text(
                                          'Days Left',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showPicker(context, _controller);
                                  },
                                  child: Container(
                                      width: 140,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [topColor, bottomColor]),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: SvgPicture.asset(
                                                  'assets/icon/crown.svg')),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          const Text(
                                            'Extend Premium',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )
                                        ],
                                      )),
                                )
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                _showPicker(context, _controller);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [topColor, bottomColor]),
                                  color: cl1_dark_purple,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 50,
                                      child: SvgPicture.asset(
                                          'assets/icon/crown.svg'),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    CustomText(
                                        text: 'get_premium'.tr,
                                        textStyle: kTextStyleWhite(14))
                                  ],
                                ),
                              ),
                            ),
                      kVerticalSpace(20)
                    ],
                  ),
                ),
                kVerticalSpace(12),
                CustomSectionTitle(
                    bottomBorder: true,
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                    title: 'edit_profile'.tr),
                CustomSectionTitle(
                  bottomBorder: true,
                  onTap: () {},
                  title: 'notificatiions'.tr,
                  widget: CustomSwitchButton(
                    value: true,
                    onChange: (value) {},
                  ),
                ),
                CustomSectionTitle(
                    bottomBorder: true,
                    onTap: () {
                      context.next(SaveContentListsScreen());
                    },
                    title: 'saved'.tr),
                CustomSectionTitle(
                    bottomBorder: true,
                    onTap: () {
                      context.next(PrivacyAndSecurity());
                    },
                    title: 'privacy_policy'.tr),
                CustomSectionTitle(
                  bottomBorder: true,
                  onTap: () {},
                  title: 'language'.tr,
                  widget: const LanguateChangeWidget(),
                ),
                CustomSectionTitle(
                    bottomBorder: true,
                    onTap: () {
                      context.next(const Apperance());
                    },
                    title: 'appearance'.tr),
                CustomSectionTitle(
                    bottomBorder: true,
                    onTap: () {
                      context.next(UserFeedback(
                        controller: _controller,
                      ));
                    },
                    title: 'user_feedback'.tr),
                CustomSectionTitle(
                  onTap: () {
                    showAlertDialog(
                        context, 'confirmation'.tr, 'logout_text'.tr, 'ok'.tr,
                        () {
                      Get.back();
                      _controller.logoutRequest(context);
                    });
                  },
                  title: 'logout'.tr,
                  titleColor: redColor,
                ),
                kVerticalSpace(12),
              ],
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _imageSlider(SettingController controller) {
    return controller.slides
        .map((item) => ClipRRect(
                child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item.imageUrl ?? "",
                  fit: BoxFit.cover,
                  width: 1000.0,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
                Container(
                  width: 1000.0,
                  height: 350,
                  color: blackColor.withOpacity(0.5),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text: item.title ?? "",
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )))
        .toList();
  }

  void _showPicker(context, SettingController controller) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return Wrap(
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  color: backgroundDarkPurple,
                  child: Stack(children: [
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icon/crown.svg'),
                            CustomText(
                                text: 'get_premium'.tr,
                                textStyle: kTextStyleWhite(14)),
                          ]),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        )),
                  ]),
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomText(
                  isAlignCenter: true,
                  text: 'premium_bottomsheet'.tr,
                  textStyle: kTextStyleBlack(12),
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(
                  children: [
                    CarouselSlider(
                      items: _imageSlider(controller),
                      carouselController: controller.carouselController,
                      options: CarouselOptions(
                          height: 350,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            controller.updateSliderIndex(index);
                          }),
                    ),
                    Obx(() {
                      return Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(controller.slides.length,
                                controller.selectedSlide.value)),
                      );
                    })
                  ],
                ),
                kVerticalSpace(30),
                CustomButton(
                  backgroundColor: deepPurple,
                  label: 'get_premium'.tr,
                  textStyle: kTextStyleWhite(14),
                  onTap: () {
                    Get.off(() => const SubscriptionScreen());
                  },
                ),
                kVerticalSpace(20)
              ],
            ),
          ],
        );
      },
    );
  }

  List<Widget> indicators(imagesLength, int currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
          width: currentIndex == index ? 18 : 13,
          height: currentIndex == index ? 18 : 13,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: currentIndex == index
                    ? backgroundDarkPurple
                    : Colors.white),
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.white : backgroundDarkPurple,
          ));
    });
  }
}
