import 'package:chitmaymay/common/rounded_corner_button.dart';
import 'package:chitmaymay/controller/subscribtion_controller.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_loading_button.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class CouponCodeScreen extends StatelessWidget {
  CouponCodeScreen({Key? key}) : super(key: key);

  final SubscribtionController _controller = Get.find<SubscribtionController>();

  @override
  Widget build(BuildContext context) {
    _controller.couponResult.value = '';
    return Scaffold(
      appBar: CustomAppBar(
        color: backgroundDarkPurple,
        textColor: whiteColor,
        title: 'use_coupon'.tr,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    child: CustomText(
                      text: 'add_coupon'.tr,
                      textStyle: kTextStyleBlack(14),
                    ),
                  ),
                ),
                Stack(children: [
                  Center(
                    child: SvgPicture.asset(
                      'assets/premium/coupon big.svg',
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 50, top: 20, right: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'ChitMayMay'.tr,
                                textStyle: kTextStyleWhite(14),
                              ),
                              CustomText(
                                text: 'coupon_code'.tr,
                                textStyle: kTextStyleWhite(14),
                              )
                            ],
                          )),
                      kHorizontalSpace(10),
                      Expanded(
                        child: OTPTextField(
                          keyboardType: TextInputType.text,
                          length: 5,
                          margin: const EdgeInsets.only(right: 10),
                          textFieldAlignment: MainAxisAlignment.start,
                          fieldWidth: 25,
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 5,
                          style: kTextStyleBlack(16),
                          onChanged: (pin) {
                            _controller.otp.value = pin;
                          },
                          onCompleted: (pin) {
                            _controller.otp.value = pin;
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      )
                    ],
                  )
                ]),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    child: Text(
                      _controller.couponResult.isEmpty
                          ? ''
                          : _controller.couponResult.value,
                      style: TextStyle(
                          color: _controller.couponResult.value ==
                                  'wrong_coupon'.tr
                              ? Colors.red
                              : Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 0.5,
                    child: _controller.optLoading.value
                        ? const CustomLoadingButton()
                        : RoundedCornerButton(
                            onPressed: () {
                              if (_controller.otp.value.isNotEmpty) {
                                _controller.useCoupon();
                              }
                            },
                            buttonTitle: 'use'.tr,
                          ))
              ],
            );
          },
        ),
      ),
    );
  }
}
