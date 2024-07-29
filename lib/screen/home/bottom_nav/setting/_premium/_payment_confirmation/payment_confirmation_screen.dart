import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/common/terms_condition_agree.dart';
import 'package:chitmaymay/controller/subscribtion_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_payment.dart';
import 'package:chitmaymay/db/dbModel/tbl_subscription.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constant_util.dart';
import '../../../../../../utils/widgets/custom_loading_button.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final TBLSubscription subscription;
  final TBLPayment payment;
  PaymentConfirmationScreen(
      {Key? key, required this.subscription, required this.payment})
      : super(key: key);

  final SubscribtionController _controller = Get.find<SubscribtionController>();
  final TextEditingController discountCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var totalPrice = (subscription.prices ?? 0) * (subscription.duration ?? 0);
    _controller.totalPrice.value = totalPrice;
    _controller.originalTotalPrice.value = totalPrice;
    _controller.discountPrices = 0;
    _controller.discountID.value = 0;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        color: backgroundDarkPurple,
         textColor: whiteColor,
        title: 'confirm_subscription'.tr,
       
      ),
      body: Obx(() {
        return SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kVerticalSpace(20),
              CustomText(
                text: 'any_coupon'.tr,
                textStyle: kTextStyleBlack(16),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: backgroundDarkPurple),
                    color: whiteColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    kHorizontalSpace(15),
                    SizedBox(
                      width: 50,
                      child:
                          SvgPicture.asset('assets/premium/coupon small.svg'),
                    ),
                    kHorizontalSpace(15),
                    Expanded(
                        child: Center(
                            child: TextFormField(
                      maxLines: 1,
                      obscureText: false,
                      keyboardType: TextInputType.multiline,
                      controller: discountCodeController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: 'enter_coupon'.tr,
                          hintStyle: kTextStyleGrey(10)),
                    ))),
                    _controller.discountLoading.value
                        ? const CustomLoading(
                            size: 30,
                          )
                        : InkWell(
                            onTap: () {
                              if (discountCodeController.text != '') {
                                _controller
                                    .discountCode(discountCodeController.text);
                              }
                            },
                            child: CustomText(
                                text: 'use'.tr,
                                textStyle: kTextStyleBoldColor(14)),
                          ),
                    kHorizontalSpace(15),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: backgroundDarkPurple),
                    color: whiteColor),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(""),
                        ),
                        Expanded(
                          child: CustomText(
                              text: '${subscription.originPrices} ks',
                              textStyle: const TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: 'price_per_month'.tr,
                            textStyle: kTextStyleBlack(14),
                          ),
                        ),
                        Expanded(
                          child:
                              ComWidgets.twoTextStyle('${subscription.prices}'),
                        )
                      ],
                    ),
                    kVerticalSpace(8),
                    sectionWidget(
                        'count'.tr,
                        '${subscription.duration} ${(subscription.duration ?? 0) > 1 ? 'months' : 'month'} ',
                        true),
                    kVerticalSpace(8),
                    sectionWidget('discount'.tr,
                        _controller.discountPrices.toString(), true),
                    kVerticalSpace(8),
                    sectionWidget(
                        'total'.tr, '${_controller.totalPrice} ks', true),
                    kVerticalSpace(8),
                    sectionWidget('payment_type'.tr, payment.name ?? '', false),
                    kVerticalSpace(8),
                  ],
                ),
              ),
              TermsAndConditionAgree(
                isCheck: _controller.isCheck.value,
                onChanged: (valueChanged) async {
                  _controller.isCheck.value = valueChanged;
                },
              ),
              FractionallySizedBox(
                widthFactor: 0.4,
                child: _controller.paymentconfirmLoading.value
                    ? const CustomLoadingButton(
                        color: redColor,
                      )
                    : CustomButton(
                        backgroundColor: redColor,
                        label: 'confirm_payment'.tr,
                        onTap: () {
                          if (_controller.isCheck.value) {
                            if (payment.name == 'CB pays') {
                              _controller.callCBPay(
                                  _controller.discountID.value,
                                  _controller.totalPrice.value,
                                  subscription.id ?? 0,
                                  payment.id ?? 0,
                                  context);
                            } else if (payment.name == 'AYA Banks') {
                              _controller.callAyaPay(
                                  _controller.discountID.value,
                                  _controller.totalPrice.value,
                                  subscription.id ?? 0,
                                  payment.id ?? 0,
                                  subscription.title ?? '',
                                  context);
                            } else if (payment.name == 'KBZPay') {
                              _controller.callKpay(
                                  _controller.discountID.value,
                                  totalPrice,
                                  subscription.id ?? 0,
                                  payment.id ?? 0,
                                  subscription.title ?? '');
                            }
                          } else {
                            ConstantUtils.showSnackBar(
                                context, 'Please check Terms & Condition');
                          }
                        },
                      ),
              )
            ],
          ),
        ));
      }),
    );
  }

  Widget sectionWidget(
      String firstLabel, String secondLabel, bool secondLabelColor) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            text: firstLabel,
            textStyle: kTextStyleBlack(14),
          ),
        ),
        Expanded(
          child: CustomText(
            text: secondLabel,
            textStyle: secondLabelColor
                ? kTextStyleBoldColor(22)
                : kTextStyleBlack(14),
          ),
        )
      ],
    );
  }
}
