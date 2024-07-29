import 'dart:convert';

import 'package:chitmaymay/db/dbModel/tbl_use_coupon.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../chitmaymay_api/chitMayMayApi.dart';
import '../chitmaymay_api/requestApi.dart';
import '../chitmaymay_api/requestModel.dart';
import '../db/dbModel/tbl_check_discount.dart';
import '../service/init_service.dart';
import '../utils/constants.dart';
import '../utils/style.dart';
import 'package:crypto/crypto.dart';

import 'setting_controller.dart';

class SubscribtionController extends GetxController {
  var subscriptionList = [].obs;
  var isLoading = true.obs;

  var paymentList = [].obs;
  var paymentLoading = true.obs;

  var paymentconfirmLoading = false.obs;
  int discountPrices = 0;
  var isCheck = false.obs;
  String generateRefOrder = '';
  var totalPrice = 0.obs;
  var originalTotalPrice = 0.obs;

  var couponResult = "".obs;
  var otp = ''.obs;
  var optLoading = false.obs;
  var discountLoading = false.obs;
  var discountID = 0.obs;

  final SettingController settingController = Get.find<SettingController>();

  Future<void> useCoupon() async {
    optLoading.value = true;
    RequestUseCoupon coupon = RequestUseCoupon(
        userId: initService.getUserId,
        couponCode: otp.value,
        secretKey: secret_key);
    final response =
        await RequestApi.requestUseCoupon(coupon, initService.getToken);
    if (response?.status ?? false) {
      TBLUseCoupon coupons = response?.data ?? TBLUseCoupon();
      settingController.fetchPremium();
      couponResult.value =
          'You got premium ${coupons.duration} - month \n ${coupons.price} ks \n From: ${coupons.startDate} To: ${coupons.endDate}';
    } else {
      couponResult.value = 'wrong_coupon'.tr;
    }
    optLoading.value = false;
  }

  Future<void> discountCode(String code) async {
    discountLoading.value = true;
    RequestCheckDiscount request =
        RequestCheckDiscount(discountCode: code, secretKey: secret_key);
    discountID.value = 0;
    final response =
        await RequestApi.requestCheckDiscount(request, initService.getToken);
    if (response?.status ?? false) {
      TBLCheckDiscount tblCheckDiscount = response?.data ?? TBLCheckDiscount();
      discountID.value = tblCheckDiscount.id ?? 0;
      discountPrices = tblCheckDiscount.prices ?? 0;
      if (discountPrices != 0) {
        totalPrice.value = originalTotalPrice.value - discountPrices;
      }
    } else {
      totalPrice.value = originalTotalPrice.value;
    }
    discountLoading.value = false;
  }

  Future<String> cbRequestPayment(
      int totalPrice, int subscribeID, int paymentID, int discountID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var mBytes = utf8.encode(
        '$cbAuthToken&$ecommerceId&$subMerId&$orderId&$amounts&$currency');
    String mSignature = sha256.convert(mBytes).toString();

    CBRequestPayment requestPayment = CBRequestPayment(
        authenToken: cbAuthToken,
        ecommerceId: ecommerceId,
        transactionType: transactionType,
        orderId: orderId,
        orderDetails: orderDetails,
        amount: '$totalPrice.00',
        currency: currency,
        notifyUrl: notifyUrl,
        signature: mSignature,
        subMerId: subMerId);
    String generateRefOrder = await RequestApi.requestCBPayment(requestPayment);
    if (generateRefOrder.isNotEmpty) {
      pref.setBool("cbpay", true);
      pref.setInt(subscribeId, subscribeID);
      if (discountID != 0) {
        pref.setInt(discountId, discountID);
      } else {
        pref.setInt(discountId, 0);
      }
      pref.setInt(paymentId, paymentID);
      return generateRefOrder;
    } else {
      generateRefOrder = '';
      pref.setInt(subscribeId, 0);
      pref.setInt(discountId, 0);
      pref.setInt(paymentId, 0);
    }
    update();
    return generateRefOrder;
  }

  void callAyaPay(int discountId, int totalPrice, int subscriptionId,
      int paymentId, String subscriptionTitle, context) async {
    await RequestApi.requestAYAPayAccessToken(context, totalPrice.toString(),
        'MMK', subscriptionId, paymentId, discountId, subscriptionTitle);
  }

  void callCBPay(int discountId, int totalPrice, int subscriptionId,
      int paymentId, context) async {
    paymentconfirmLoading.value = true;
    String genKey = await cbRequestPayment(
        totalPrice, subscriptionId, paymentId, discountId);
    if (genKey.isEmpty) {
      ConstantUtils.showSnackBar(context, 'Response is null');
    } else {
      ConstantUtils.sendFirebaseAnalyticsEvent(
          '$totalPrice-paymentConfirmation');
      generateRefOrder = 'cbuat://pay?keyreference=$genKey';
      open(context, generateRefOrder);
    }
    paymentconfirmLoading.value = false;
  }

  Future<void> callKpay(int discountId, int totalPrice, int subscriptionId,
      int paymentId, String subTitle) async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String merchOrderId = getRandomOrderId();
    String rawSign =
        "appid=$appId&callback_info=$kbzNotifyUrl&merch_code=$merchCode&merch_order_id=$merchOrderId&method=$method&nonce_str=$nonceStr&notify_url=$kbzNotifyUrl&timestamp=$timeStamp&title=$subTitle&total_amount=$totalPrice&trade_type=$tradeType&trans_currency=$currency&version=$version";
    var signInBytes = utf8.encode(rawSign + "&key=" + appKey);
    String sign = sha256.convert(signInBytes).toString().toUpperCase();
    BizContent bizContent = BizContent(
        merchOrderId: merchOrderId,
        merchCode: merchCode,
        appid: appId,
        tradeType: tradeType,
        title: subTitle,
        totalAmount: totalPrice.toString(),
        currency: currency,
        callbackInfo: kbzNotifyUrl);
    KPayRequestPayment request = KPayRequestPayment(
        timestamp: timeStamp,
        method: method,
        notifyUrl: kbzNotifyUrl,
        nonceStr: nonceStr,
        signType: signType,
        sign: sign,
        version: version,
        bizContent: bizContent);

    final response =
        await RequestApi.requestKpayPayment(request, initService.getToken);
    if (response != "") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt("subscribe_id", subscriptionId);
      preferences.setInt("discount_id", discountId);
      preferences.setInt("payment_id", paymentId);
      preferences.setString("total", totalPrice.toString());
      preferences.setString("merch_order_id", merchOrderId);
      preferences.setBool("kpay", true);
      preferences.setString("prepay_id", response);
    } else {
      showToast('Payment Fail');
    }
  }

  static Future<bool> open(BuildContext context, String url) async {
    try {
      await launch(url, enableJavaScript: true, forceSafariVC: false);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      ConstantUtils.showSnackBar(context, e.toString());
      return false;
    }
  }

  cBApp(String mUrlLink) async {
    // String mUrlLink =
    // 'https://api.whatsapp.com/send/?phone=546497546464&text&app_absent=0';// or add your URL here
    //'https://cbpay-deeplink-test.netlify.app/';
    // 'cbuat://pay?keyreference=$generateRefOrder';
    if (await canLaunch(mUrlLink)) {
      await launch(mUrlLink);
    } else {
      throw 'Could not launch $mUrlLink';
    }
  }

  @override
  void onInit() {
    fetchSubscription();
    super.onInit();
  }

  //fetch subscription plan from api
  Future<void> fetchSubscription() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestGetSubscription(
          initService.getToken, initService.getUserId);
      if (response?.status ?? false) {
        subscriptionList.value = response?.data ?? [];
        update();
      } else {
        debugPrint('error subscription');
      }
    } else {
      showToast('no_internet'.tr);
    }
    isLoading.value = false;
  }

  //fetch payment list from api
  Future<void> fetchPayment() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestGetPayment(initService.getToken);
      if (response?.status ?? false) {
        paymentList.value = response?.data ?? [];
        update();
      } else {
        debugPrint('error payment');
      }
      paymentLoading.value = false;
    } else {
      showToast('no_internet'.tr);
    }
    paymentLoading.value = false;
  }
}
