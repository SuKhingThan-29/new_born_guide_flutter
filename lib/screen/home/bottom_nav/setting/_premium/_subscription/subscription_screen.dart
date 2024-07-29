import 'package:chitmaymay/common/border_decoration.dart';
import 'package:chitmaymay/common/rectangle_full_button.dart';
import 'package:chitmaymay/controller/subscribtion_controller.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_premium/_subscription/component/subscription_widget.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_premium/_coupon/coupon_code_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_premium/_payment/payment_screen.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        color: backgroundDarkPurple,
        textColor: whiteColor,
        title: 'watch_video_unlimited'.tr,
      ),
      body: GetBuilder<SubscribtionController>(
        init: SubscribtionController(),
        builder: (value) {
          return value.isLoading.value
              ? const Center(
                  child: CustomLoading(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.subscriptionList.length,
                          itemBuilder: (context, index) {
                            var item = value.subscriptionList[index];
                            return SubscriptionWidget(
                                item: item,
                                onPressed: () {
                                  ConstantUtils.sendFirebaseAnalyticsEvent(
                                      '${item.total}-Ks$subscribe');
                                  Get.to(() => PaymentScreen(item: item));
                                },
                                name: 'subscribe_now'.tr);
                          }),
                      CustomText(
                        text: 'any_coupon'.tr,
                        textStyle: kTextStyleBlack(14),
                      ),
                      BorderDecoration(
                        pageMargin: const EdgeInsets.all(10),
                        pagePadding: const EdgeInsets.all(10),
                        radius: 15.0,
                        color: cl1_dark_purple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: 'coupon_code'.tr,
                                  textStyle: kTextStyleError(16),
                                ),
                                CustomText(
                                  text: 'to_use'.tr,
                                  textStyle: kTextStyleError(16),
                                ),
                              ],
                            ),
                            RectangleFullButton(
                                onPressed: () {
                                  Get.to(() => CouponCodeScreen());
                                },
                                buttonTitle: 'use_coupon'.tr)
                          ],
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
