import 'dart:convert';
import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/init_service.dart';

class HomeController extends GetxController {
  bool isLogin = false;

  final SettingController settingController = Get.put(SettingController());

  Future<bool> ayaRefundPaymentVerify() async {
    int subscribe_id = 0;
    int discount_id = 0;
    int payment_id = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId;
    userId = initService.getUserId;
    if (pref.getInt(subscribeId) != null) {
      subscribe_id = pref.getInt(subscribeId)!;
    }
    if (pref.getInt(discountId) != null) {
      discount_id = pref.getInt(discountId)!;
    }
    if (pref.getInt(paymentId) != null) {
      payment_id = pref.getInt(paymentId)!;
    }
    if (pref.getString(referenceNumber) != null &&
        pref.getString(referenceNumber)!.isNotEmpty) {
      AyaRefundPaymentRequest ayaRefundPaymentRequest = AyaRefundPaymentRequest(
          referenceNumber: pref.getString(referenceNumber).toString(),
          externalTransactionId:
              pref.getString(externalTransactionId).toString());
      AyaRefundPaymentResponse? ayaRefundPaymentResponse =
          await RequestApi.refundPayment(ayaRefundPaymentRequest);
      if (ayaRefundPaymentResponse != null) {
        RequestUserSubscribe userScribe = RequestUserSubscribe(
            userId: userId,
            subscribeId: subscribe_id,
            discountId: discount_id,
            paymentId: payment_id,
            total: ayaRefundPaymentResponse.data.totalAmount.toString(),
            referenceNumber: referenceNumber,
            externalTransactionId: externalTransactionId,
            merchOrderId: '',
            secretKey: secret_key);
        bool isValid = await RequestApi.requestUserSubscribe(userScribe);
        if (isValid) {
          //await RequestApi.requestGetSubscribe();
          pref.setString(referenceNumber, '');
          pref.setString(externalTransactionId, '');
          pref.setInt(subscribeId, 0);
          pref.setInt(discountId, 0);
          pref.setInt(paymentId, 0);
        }
        return isValid;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> verifyPayment() async {
    debugPrint('verfiy payment========>');
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool kpay = false;
    if (pref.getBool("kpay") != null) {
      kpay = pref.getBool("kpay") ?? false;
    }

    if (kpay) {
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String merchOrderId = pref.getString("merch_order_id") ?? '';
      String rawSign =
          "appid=$appId&merch_code=$merchCode&merch_order_id=$merchOrderId&method=kbz.payment.queryorder&nonce_str=$nonceStr&timestamp=$timeStamp&version=3.0";
      var signInBytes = utf8.encode(rawSign + "&key=" + appKey);
      String sign = sha256.convert(signInBytes).toString().toUpperCase();
      KpayQueryOrderBizContent bizContent = KpayQueryOrderBizContent(
          appId: appId, merchCode: merchCode, merchOrderId: merchOrderId);
      KpayQueryOrderRequest queryOrderRequest = KpayQueryOrderRequest(
          timeStamp: timeStamp,
          nonceStr: nonceStr,
          signType: signType,
          sign: sign,
          version: "3.0",
          bizContent: bizContent);
      final queryResponse = await RequestApi.queryKpayPayment(
          queryOrderRequest, initService.getToken);
      if (queryResponse?.response.tradeStatus == paySuccess) {
        RequestUserSubscribe userScribe = RequestUserSubscribe(
            userId: initService.getUserId,
            subscribeId: pref.getInt("subscribe_id") ?? 0,
            discountId: pref.getInt("discount_id") ?? 0,
            paymentId: pref.getInt("payment_id") ?? 0,
            total: pref.getString("total") ?? '',
            referenceNumber: '',
            externalTransactionId: '',
            merchOrderId: merchOrderId,
            secretKey: secret_key);
        bool isValid = await RequestApi.requestUserSubscribe(userScribe);
        if (isValid) {
          settingController.fetchPremium();
          pref.setInt("subscribe_id", 0);
          pref.setInt("discount_id", 0);
          pref.setInt("payment_id", 0);
          pref.setString("total", '');
          pref.setString("merch_order_id", '');
          pref.setBool("kpay", false);
          pref.setString("prepay_id", '');
        }
        return isValid;
      }
    } else {
      bool cbpay = false;

      if (pref.getBool("cbpay") != null) {
        cbpay = pref.getBool("cbpay") ?? false;
      }
      if (cbpay) {
        if (pref.getString(mGenerateRefOrder) != null) {
          String refOder = pref.getString(mGenerateRefOrder).toString();
          debugPrint('REFOrder: $refOder');
          if (refOder.isNotEmpty) {
            CBRequestPinVerify pinVerify = CBRequestPinVerify(
                generateRefOrder: refOder,
                ecommerceId: ecommerceId,
                orderId: orderId);
            CBResponsePaymentPinVerify? response =
                await RequestApi.requestCBPinVerify(pinVerify);
            if (response != null) {
              if (response.code == '0000') {
                debugPrint('REFOrder pinVerify: ${response.code}');
                RequestUserSubscribe userScribe = RequestUserSubscribe(
                    userId: initService.getUserId,
                    subscribeId: pref.getInt(subscribeId) ?? 0,
                    discountId: pref.getInt(discountId) ?? 0,
                    paymentId: pref.getInt(paymentId) ?? 0,
                    total: response.totalAmount.toString(),
                    referenceNumber: refOder,
                    externalTransactionId: '',
                    merchOrderId: '',
                    secretKey: secret_key);
                bool isValid =
                    await RequestApi.requestUserSubscribe(userScribe);
                if (isValid) {
                  settingController.fetchPremium();
                  pref.setInt(subscribeId, 0);
                  pref.setInt(discountId, 0);
                  pref.setInt(paymentId, 0);
                  pref.setBool("cbpay", false);
                }
                return isValid;
              }
            }
          }
        }
      }
    }
    return false;
  }
}
