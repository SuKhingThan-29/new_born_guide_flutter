import 'package:chitmaymay/db/dbModel/tbl_about_us.dart';
import 'package:chitmaymay/db/dbModel/tbl_block_user.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/db/dbModel/tbl_check_discount.dart';
import 'package:chitmaymay/db/dbModel/tbl_data.dart';
import 'package:chitmaymay/db/dbModel/tbl_group.dart';
import 'package:chitmaymay/db/dbModel/tbl_notification.dart';
import 'package:chitmaymay/db/dbModel/tbl_payment.dart';
import 'package:chitmaymay/db/dbModel/tbl_privacy_policy.dart';
import 'package:chitmaymay/db/dbModel/tbl_profile.dart';
import 'package:chitmaymay/db/dbModel/tbl_slide.dart';
import 'package:chitmaymay/db/dbModel/tbl_subscription.dart';
import 'package:chitmaymay/db/dbModel/tbl_term_condition.dart';
import 'package:chitmaymay/db/dbModel/tbl_use_coupon.dart';
import 'package:chitmaymay/db/dbModel/tbl_user.dart';
import 'package:flutter/material.dart';

import '../db/dbModel/tbl_content.dart';
import '../db/dbModel/tbl_device.dart';
import '../db/dbModel/tbl_premium.dart';

class RequestRegister {
  String name;
  String phone;
  String password;
  String deviceId;
  String secretKey;

  RequestRegister(
      {required this.name,
      required this.phone,
      required this.password,
      required this.deviceId,
      required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    data['device_id'] = deviceId;
    data['secret_key'] = secretKey;
    return data;
  }
}

class CommonResponseMessage {
  final String message;
  final bool status;

  CommonResponseMessage({required this.message, required this.status});

  factory CommonResponseMessage.fromJson(Map<String, dynamic> json) {
    return CommonResponseMessage(
        message: json['message'], status: json['status']);
  }
}

class ImageUploadResponse {
  final String message;
  final bool status;
  final String data;

  ImageUploadResponse(
      {required this.message, required this.status, required this.data});

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponse(
        message: json['message'] ?? '',
        status: json['status'],
        data: json['data']);
  }
}

class CreateGroupResponse {
  final String message;
  final bool status;
  final TBLGroup data;

  CreateGroupResponse(
      {required this.message, required this.status, required this.data});

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponse(
        message: json['message'],
        status: json['status'],
        data: TBLGroup.fromJson(json['data']));
  }
}

class RequestForgetOTPVerify {
  String phone;
  String otpCode;
  String secretKey;

  RequestForgetOTPVerify(
      {required this.phone, required this.otpCode, required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp_code'] = otpCode;
    data['secret_key'] = secretKey;

    return data;
  }
}

class RequestOTP {
  String phone;
  String otpCode;
  String secretKey;
  String deviceId;
  String deviceName;

  RequestOTP(
      {required this.phone,
      required this.otpCode,
      required this.secretKey,
      required this.deviceId,
      required this.deviceName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp_code'] = otpCode;
    data['secret_key'] = secretKey;
    data['device_id'] = deviceId;
    data['device_name'] = deviceName;
    return data;
  }
}

class RequestLogin {
  String phone;
  String password;
  String secretKey;
  String deviceId;
  String deviceName;

  RequestLogin(
      {required this.phone,
      required this.password,
      required this.secretKey,
      required this.deviceId,
      required this.deviceName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['secret_key'] = secretKey;
    data['device_id'] = deviceId;
    data['device_name'] = deviceName;
    return data;
  }
}

class RegisterVerifyResponse {
  final String message;
  final String token;
  final bool status;
  final int userId;
  final String userPhone;
  final String fullName;

  RegisterVerifyResponse(
      {required this.message,
      required this.token,
      required this.status,
      required this.userId,
      required this.userPhone,
      required this.fullName});

  factory RegisterVerifyResponse.fromJson(Map<String, dynamic> json) {
    return RegisterVerifyResponse(
        message: json['message'],
        token: json['token'] ?? '',
        status: json['status'],
        userId: json['user_id'] ?? 0,
        userPhone: json['user_phone'] ?? '',
        fullName: json['full_name'] ?? '');
  }
}

class ResponseSocial {
  final String message;
  final String token;
  final bool status;
  final int userId;
  final String userName;

  ResponseSocial(
      {required this.message,
      required this.token,
      required this.status,
      required this.userId,
      required this.userName});

  factory ResponseSocial.fromJson(Map<String, dynamic> json) {
    return ResponseSocial(
        message: json['message'],
        token: json['token'] ?? '',
        status: json['status'],
        userId: json['user_id'] ?? 0,
        userName: json['user_name'] ?? '');
  }
}

class RequestOTPResend {
  String phone;
  String secretKey;

  RequestOTPResend({required this.phone, required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['secret_key'] = secretKey;
    return data;
  }
}

class ResponseOTPResend {
  final String message;
  final int code;
  final bool status;

  ResponseOTPResend(
      {required this.message, required this.code, required this.status});

  factory ResponseOTPResend.fromJson(Map<String, dynamic> json) {
    return ResponseOTPResend(
        message: json['message'],
        code: json['code'] ?? 0,
        status: json['status']);
  }
}

class RequestPasswordReset {
  String phone;
  String password;
  String secretKey;
  String deviceId;
  String deviceName;

  RequestPasswordReset(
      {required this.phone,
      required this.password,
      required this.secretKey,
      required this.deviceId,
      required this.deviceName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['secret_key'] = secretKey;
    data['device_id'] = deviceId;
    data['device_name'] = deviceName;
    return data;
  }
}

class LogoutRequest {
  int userId;
  String secretKey;
  String deviceId;

  LogoutRequest(
      {required this.userId, required this.secretKey, required this.deviceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['secret_key'] = secretKey;
    data['device_id'] = deviceId;
    return data;
  }
}

class LoveContentRequest {
  final int userId;
  final int contentId;
  final String secretKey;
  final int loveAction;

  LoveContentRequest(
      {required this.userId,
      required this.contentId,
      required this.secretKey,
      required this.loveAction});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['content_id'] = contentId;
    data['secret_key'] = secretKey;
    data['love_action'] = loveAction;
    return data;
  }
}

class SaveContentRequest {
  final int userId;
  final int contentId;
  final String secretKey;
  final int saveAction;

  SaveContentRequest(
      {required this.userId,
      required this.contentId,
      required this.secretKey,
      required this.saveAction});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['content_id'] = contentId;
    data['secret_key'] = secretKey;
    data['save_action'] = saveAction;
    return data;
  }
}

class CategoryContentDetailRequest {
  final int contentId;
  final int userId;
  final String secretKey;

  CategoryContentDetailRequest(
      {required this.contentId, required this.userId, required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_id'] = contentId;
    data['user_id'] = userId;
    data['secret_key'] = secretKey;
    return data;
  }
}

class CategoryContentDetailResponse {
  final TBLContent data;
  final List<TBLContent> relatedContent;
  final String message;
  final bool status;

  CategoryContentDetailResponse(
      {required this.data,
      required this.relatedContent,
      required this.message,
      required this.status});

  factory CategoryContentDetailResponse.fromJson(
      Map<String, dynamic> jsonData) {
    TBLContent _data = TBLContent.fromJson(jsonData['data']);
    var _relatedContentList = jsonData['related_content'] as List;
    List<TBLContent> relatedContentList =
        _relatedContentList.map((e) => TBLContent.fromJson(e)).toList();
    return CategoryContentDetailResponse(
        data: _data,
        relatedContent: relatedContentList,
        message: jsonData['message'],
        status: jsonData['status']);
  }
}

class SaveListRequest {
  final String secretKey;
  final int userId;
  final int pageId;

  SaveListRequest(
      {required this.secretKey, required this.userId, required this.pageId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret_key'] = secretKey;
    data['user_id'] = userId;
    data['page_id'] = pageId;
    return data;
  }
}

class MessageListRequest {
  final String secretKey;
  final int userId;

  MessageListRequest({required this.secretKey, required this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret_key'] = secretKey;
    data['user_id'] = userId;
    return data;
  }
}

class CreateGroupRequest {
  final String secretKey;
  final int userId;
  final List<int> members;
  final String groupName;
  final String groupImage;

  CreateGroupRequest(
      {required this.secretKey,
      required this.userId,
      required this.members,
      required this.groupName,
      required this.groupImage});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret_key'] = secretKey;
    data['user_id'] = userId;
    data['group_name'] = groupName;
    data['group_img'] = groupImage;
    data['members'] = members;
    return data;
  }
}

class ChatMessageListRequest {
  final int userId;
  final String convKey;
  final String chatType;
  final int groupId;
  final int pageId;
  final String secretKey;

  ChatMessageListRequest(
      {required this.secretKey,
      required this.userId,
      required this.convKey,
      required this.chatType,
      required this.groupId,
      required this.pageId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['conversation_key'] = convKey;
    data['secret_key'] = secretKey;
    data['chat_type'] = chatType;
    data['page_id'] = pageId;
    data['group_id'] = groupId;
    return data;
  }
}

class ProfileRequest {
  final int userId;
  final String name;
  final String fullName;
  final String phone;
  final String password;
  final String email;
  final String dateBirth;
  final String gender;
  final int isParent;
  final int isPregnent;
  final String secretKey;
  final String imageUrl;

  ProfileRequest(
      {required this.userId,
      required this.name,
      required this.fullName,
      required this.phone,
      required this.password,
      required this.email,
      required this.dateBirth,
      required this.gender,
      required this.isParent,
      required this.isPregnent,
      required this.secretKey,
      required this.imageUrl});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['password'] = password;
    data['email'] = email;
    data['date_birth'] = dateBirth;
    data['gender'] = gender;
    data['is_parent'] = isParent;
    data['is_pregnent'] = isPregnent;
    data['secret_key'] = secretKey;
    data['image_url'] = imageUrl;
    return data;
  }
}

class CommonDataRequest {
  final String secretKey;
  final int userId;

  CommonDataRequest({required this.secretKey, required this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret_key'] = secretKey;
    data['user_id'] = userId;
    return data;
  }
}

class HomeDataRequest {
  final String secretKey;
  final int userId;
  final String firebaseToken;
  final String deviceId;

  HomeDataRequest(
      {required this.secretKey,
      required this.userId,
      required this.firebaseToken,
      required this.deviceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret_key'] = secretKey;
    data['user_id'] = userId;
    data['firebase_token'] = firebaseToken;
    data['device_id'] = deviceId;
    return data;
  }
}

class CommonSecretKeyRequest {
  final String secretKey;

  CommonSecretKeyRequest({required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secret_key'] = secretKey;
    return data;
  }
}

class RequestCheckDiscount {
  final String discountCode;
  final String secretKey;
  RequestCheckDiscount({required this.discountCode, required this.secretKey});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount_code'] = discountCode;
    data['secret_key'] = secretKey;
    return data;
  }
}

class ResponseCheckDiscount {
  final TBLCheckDiscount data;
  final String message;
  final bool status;
  ResponseCheckDiscount(
      {required this.data, required this.message, required this.status});
  factory ResponseCheckDiscount.fromJson(Map<String, dynamic> jsonData) {
    TBLCheckDiscount _data = TBLCheckDiscount();
    if (jsonData['data'] != null) {
      _data = TBLCheckDiscount.fromJson(jsonData['data']);
    }

    return ResponseCheckDiscount(
        data: _data, message: jsonData['message'], status: jsonData['status']);
  }
}

class ResponseSlide {
  final List<TBLSlide> data;
  final bool status;

  ResponseSlide({required this.data, required this.status});
  factory ResponseSlide.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLSlide> dataList =
          _dataList.map((e) => TBLSlide.fromJson(e)).toList();
      return ResponseSlide(data: dataList, status: jsonData['status']);
    } else {
      return ResponseSlide(data: [], status: false);
    }
  }
}

class ResponseSubscription {
  final List<TBLSubscription> data;
  final bool status;
  ResponseSubscription({required this.data, required this.status});
  factory ResponseSubscription.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLSubscription> dataList =
          _dataList.map((e) => TBLSubscription.fromJson(e)).toList();
      return ResponseSubscription(data: dataList, status: jsonData['status']);
    } else {
      return ResponseSubscription(data: [], status: jsonData['status']);
    }
  }
}

class ResponsePayment {
  final List<TBLPayment> data;
  final bool status;
  ResponsePayment({required this.data, required this.status});
  factory ResponsePayment.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLPayment> dataList =
          _dataList.map((e) => TBLPayment.fromJson(e)).toList();
      return ResponsePayment(data: dataList, status: jsonData['status']);
    } else {
      return ResponsePayment(data: [], status: jsonData['status']);
    }
  }
}

class AyaLoginRequest {
  final String phone;
  final String password;
  AyaLoginRequest({required this.phone, required this.password});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}

class CBRequestPayment {
  final String authenToken;
  final String ecommerceId;
  final String transactionType;
  final String orderId;
  final String orderDetails;
  final String amount;
  final String currency;
  final String notifyUrl;
  final String signature;
  final String subMerId;
  CBRequestPayment(
      {required this.authenToken,
      required this.ecommerceId,
      required this.transactionType,
      required this.orderId,
      required this.orderDetails,
      required this.amount,
      required this.currency,
      required this.notifyUrl,
      required this.signature,
      required this.subMerId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authenToken'] = authenToken;
    data['ecommerceId'] = ecommerceId;
    data['transactionType'] = transactionType;
    data['orderId'] = orderId;
    data['orderDetails'] = orderDetails;
    data['amount'] = amount;
    data['currency'] = currency;
    data['notifyUrl'] = notifyUrl;
    data['signature'] = signature;
    data['subMerId'] = subMerId;
    return data;
  }
}

class KPayRequestPayment {
  final String timestamp;
  final String method;
  final String notifyUrl;
  final String nonceStr;
  final String signType;
  final String sign;
  final String version;
  final BizContent bizContent;

  KPayRequestPayment({
    required this.timestamp,
    required this.method,
    required this.notifyUrl,
    required this.nonceStr,
    required this.signType,
    required this.sign,
    required this.version,
    required this.bizContent,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['method'] = method;
    data['notify_url'] = notifyUrl;
    data['nonce_str'] = nonceStr;
    data['sign_type'] = signType;
    data['sign'] = sign;
    data['version'] = version;
    data['biz_content'] = bizContent.toJson();
    return data;
  }
}

class BizContent {
  final String merchOrderId;
  final String merchCode;
  final String appid;
  final String tradeType;
  final String title;
  final String totalAmount;
  final String currency;
  final String callbackInfo;
  BizContent(
      {required this.merchOrderId,
      required this.merchCode,
      required this.appid,
      required this.tradeType,
      required this.title,
      required this.totalAmount,
      required this.currency,
      required this.callbackInfo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merch_order_id'] = merchOrderId;
    data['merch_code'] = merchCode;
    data['appid'] = appid;
    data['trade_type'] = tradeType;
    data['title'] = title;
    data['total_amount'] = totalAmount;
    data['trans_currency'] = currency;
    data['callback_info'] = callbackInfo;
    return data;
  }
}

class KpayCreateOrderResponseBody {
  final KpayCreateOrderResponse response;

  KpayCreateOrderResponseBody({required this.response});
  factory KpayCreateOrderResponseBody.fromJson(Map<String, dynamic> jsonData) {
    return KpayCreateOrderResponseBody(
        response: KpayCreateOrderResponse.fromJson(jsonData["Response"]));
  }
}

class KpayCreateOrderResponse {
  final String prepayId;
  final String sign;
  final String nonceStr;
  final String msg;

  KpayCreateOrderResponse({
    required this.prepayId,
    required this.sign,
    required this.nonceStr,
    required this.msg,
  });

  factory KpayCreateOrderResponse.fromJson(Map<String, dynamic> jsonData) {
    return KpayCreateOrderResponse(
      prepayId: jsonData['prepay_id'],
      sign: jsonData['sign'],
      nonceStr: jsonData['nonce_str'],
      msg: jsonData['msg'],
    );
  }
}

class KpayQueryOrderResponseBody {
  final KpayQueryOrderResponse response;

  KpayQueryOrderResponseBody({required this.response});
  factory KpayQueryOrderResponseBody.fromJson(Map<String, dynamic> jsonData) {
    return KpayQueryOrderResponseBody(
        response: KpayQueryOrderResponse.fromJson(jsonData["Response"]));
  }
}

class KpayQueryOrderResponse {
  final String result;
  final String tradeStatus;
  final String signType;
  final String sign;

  KpayQueryOrderResponse({
    required this.result,
    required this.tradeStatus,
    required this.signType,
    required this.sign,
  });

  factory KpayQueryOrderResponse.fromJson(Map<String, dynamic> jsonData) {
    return KpayQueryOrderResponse(
      result: jsonData['result'],
      tradeStatus: jsonData['trade_status'],
      signType: jsonData['sign_type'],
      sign: jsonData['sign'],
    );
  }
}

class KpayQueryOrderBizContent {
  final String appId;
  final String merchCode;
  final String merchOrderId;

  KpayQueryOrderBizContent({
    required this.appId,
    required this.merchCode,
    required this.merchOrderId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appid'] = appId;
    data['merch_code'] = merchCode;
    data['merch_order_id'] = merchOrderId;
    return data;
  }
}

class KpayQueryOrderRequest {
  final String timeStamp;
  final String nonceStr;
  String method = "kbz.payment.queryorder";
  final String signType;
  final String sign;
  final String version;
  final KpayQueryOrderBizContent bizContent;

  KpayQueryOrderRequest(
      {required this.timeStamp,
      required this.nonceStr,
      required this.signType,
      required this.sign,
      required this.version,
      required this.bizContent});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timeStamp;
    data['nonce_str'] = nonceStr;
    data['method'] = method;
    data['sign_type'] = signType;
    data['sign'] = sign;
    data['version'] = version;
    data['biz_content'] = bizContent.toJson();
    return data;
  }
}

class AyaResponseAccessToken {
  final String accessToken;
  final String tokenType;
  AyaResponseAccessToken({required this.accessToken, required this.tokenType});
  factory AyaResponseAccessToken.fromJson(Map<String, dynamic> jsonData) {
    return AyaResponseAccessToken(
        accessToken: jsonData['access_token'],
        tokenType: jsonData['token_type']);
  }
}

class AyaRefundPaymentRequest {
  final String referenceNumber;
  final String externalTransactionId;
  AyaRefundPaymentRequest(
      {required this.referenceNumber, required this.externalTransactionId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceNumber'] = referenceNumber;
    data['externalTransactionId'] = externalTransactionId;
    return data;
  }
}

class AyaRefundPaymentResponse {
  final int err;
  final String message;
  final AyaRefundData data;
  AyaRefundPaymentResponse(
      {required this.err, required this.message, required this.data});
  factory AyaRefundPaymentResponse.fromJson(Map<String, dynamic> jsonData) {
    final AyaRefundData _data = AyaRefundData.fromJson(jsonData['data']);
    return AyaRefundPaymentResponse(
        err: jsonData['err'], message: jsonData['message'], data: _data);
  }
}

class AyaRefundData {
  final String name;
  final String desc;
  final String currency;
  final String transRefId;
  final int totalAmount;
  final int amount;
  final AyaMerchant ayaMerchant;
  final AyaCustomer ayaCustomer;
  AyaRefundData(
      {required this.name,
      required this.desc,
      required this.currency,
      required this.transRefId,
      required this.totalAmount,
      required this.amount,
      required this.ayaMerchant,
      required this.ayaCustomer});
  factory AyaRefundData.fromJson(Map<String, dynamic> jsonData) {
    final AyaMerchant _merchantData =
        AyaMerchant.fromJson(jsonData['merchant']);
    final AyaCustomer _data = AyaCustomer.fromJson(jsonData['customer']);
    return AyaRefundData(
        name: jsonData['name'],
        desc: jsonData['desc'],
        currency: jsonData['currency'],
        transRefId: jsonData['transRefId'],
        totalAmount: jsonData['totalAmount'],
        amount: jsonData['amount'],
        ayaMerchant: _merchantData,
        ayaCustomer: _data);
  }
}

class AyaMerchant {
  final String name;
  final String phone;
  AyaMerchant({required this.name, required this.phone});
  factory AyaMerchant.fromJson(Map<String, dynamic> jsonData) {
    return AyaMerchant(name: jsonData['name'], phone: jsonData['phone']);
  }
}

class AyaCustomer {
  final String name;
  final String phone;
  AyaCustomer({required this.name, required this.phone});
  factory AyaCustomer.fromJson(Map<String, dynamic> jsonData) {
    return AyaCustomer(name: jsonData['name'], phone: jsonData['phone']);
  }
}

class AyaRequestPayment {
  final String customerPhone;
  final String amount;
  final String currency;
  final String externalTransactionId;
  final String externalAdditionalData;
  AyaRequestPayment(
      {required this.customerPhone,
      required this.amount,
      required this.currency,
      required this.externalTransactionId,
      required this.externalAdditionalData});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerPhone'] = customerPhone;
    data['amount'] = amount;
    data['currency'] = currency;
    data['externalTransactionId'] = externalTransactionId;
    data['externalAdditionalData'] = externalAdditionalData;
    return data;
  }
}

class AyaRequestPaymentResponse {
  final int err;
  final String message;
  final AyaData data;
  AyaRequestPaymentResponse(
      {required this.err, required this.message, required this.data});
  factory AyaRequestPaymentResponse.fromJson(Map<String, dynamic> jsonData) {
    AyaData? _data;
    try {
      _data = AyaData.fromJson(jsonData['data']);
    } catch (e) {
      debugPrint(e.toString());
    }
    return AyaRequestPaymentResponse(
        err: jsonData['err'], message: jsonData['message'], data: _data!);
  }
}

class AyaData {
  final String externalTransactionId;
  final String referenceNumber;
  AyaData({required this.externalTransactionId, required this.referenceNumber});
  factory AyaData.fromJson(Map<String, dynamic> jsonData) {
    return AyaData(
        externalTransactionId: jsonData['externalTransactionId'],
        referenceNumber: jsonData['referenceNumber']);
  }
}

class AyaLoginResponse {
  final int err;
  final String message;
  final AyaToken ayaToken;
  AyaLoginResponse(
      {required this.err, required this.message, required this.ayaToken});
  factory AyaLoginResponse.fromJson(Map<String, dynamic> jsonData) {
    AyaToken _data = AyaToken.fromJson(jsonData['token']);
    return AyaLoginResponse(
        err: jsonData['err'], message: jsonData['message'], ayaToken: _data);
  }
}

class AyaToken {
  final String token;
  AyaToken({required this.token});
  factory AyaToken.fromJson(Map<String, dynamic> jsonData) {
    return AyaToken(token: jsonData['token']);
  }
}

class CBResponsePayment {
  final String generateRefOrder;
  final String code;
  final String msg;
  CBResponsePayment(
      {required this.generateRefOrder, required this.code, required this.msg});
  factory CBResponsePayment.fromJson(Map<String, dynamic> jsonData) {
    return CBResponsePayment(
        generateRefOrder: jsonData['generateRefOrder'],
        code: jsonData['code'],
        msg: jsonData['msg']);
  }
}

class CBRequestPinVerify {
  final String generateRefOrder;
  final String ecommerceId;
  final String orderId;

  CBRequestPinVerify(
      {required this.generateRefOrder,
      required this.ecommerceId,
      required this.orderId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generateRefOrder'] = generateRefOrder;
    data['ecommerceId'] = ecommerceId;
    data['orderId'] = orderId;
    return data;
  }
}

class CBResponsePaymentPinVerify {
  final String generateRefOrder;
  final String orderId;
  final String transactionStatus;
  final String transactionId;
  final String transactionDate;
  final String currency;
  final double amount;
  final double totalAmount;
  final double feeAmount;
  final String discount;
  final String code;
  final String msg;
  CBResponsePaymentPinVerify(
      {required this.generateRefOrder,
      required this.orderId,
      required this.transactionStatus,
      required this.transactionId,
      required this.transactionDate,
      required this.currency,
      required this.amount,
      required this.totalAmount,
      required this.feeAmount,
      required this.discount,
      required this.code,
      required this.msg});
  factory CBResponsePaymentPinVerify.fromJson(Map<String, dynamic> jsonData) {
    return CBResponsePaymentPinVerify(
        generateRefOrder: jsonData['generateRefOrder'],
        orderId: jsonData['orderId'],
        transactionStatus: jsonData['transactionStatus'],
        transactionId: jsonData['transactionId'],
        transactionDate: jsonData['transactionDate'],
        currency: jsonData['currency'],
        amount: jsonData['amount'],
        totalAmount: jsonData['totalAmount'],
        feeAmount: jsonData['feeAmount'],
        discount: jsonData['discount'],
        code: jsonData['code'],
        msg: jsonData['msg']);
  }
}

class RequestGetProfile {
  final int userId;
  final String secretKey;

  RequestGetProfile({required this.userId, required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['secret_key'] = secretKey;
    return data;
  }
}

class ResponseGetProfile {
  final TBLProfile data;
  final bool status;

  ResponseGetProfile({required this.data, required this.status});

  factory ResponseGetProfile.fromJson(Map<dynamic, dynamic> jsonData) {
    TBLProfile _data = TBLProfile.fromJson(jsonData['data']);
    return ResponseGetProfile(data: _data, status: jsonData['status']);
  }
}

class HomeResponse {
  final List<TBLData> data;

  HomeResponse({required this.data});

  factory HomeResponse.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLData> dataList =
          _dataList.map((e) => TBLData.fromJson(e)).toList();
      return HomeResponse(data: dataList);
    } else {
      return HomeResponse(data: []);
    }
  }
}

class RequestUseCoupon {
  final int userId;
  final String couponCode;
  final String secretKey;
  RequestUseCoupon(
      {required this.userId,
      required this.couponCode,
      required this.secretKey});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['coupon_code'] = couponCode;
    data['secret_key'] = secretKey;
    return data;
  }
}

class ResponseUseCoupon {
  final String message;
  final bool status;
  final TBLUseCoupon data;

  ResponseUseCoupon(
      {required this.message, required this.status, required this.data});

  factory ResponseUseCoupon.fromJson(Map<String, dynamic> json) {
    TBLUseCoupon? _data;
    try {
      _data = TBLUseCoupon?.fromJson(json['data']!);
    } catch (e) {
      debugPrint(e.toString());
    }

    return ResponseUseCoupon(
        message: json['message'], status: json['status'], data: _data!);
  }
}

class ContentCategoryRequest {
  final int userId;
  final int categoryId;
  final int pageId;
  final String secretKey;

  ContentCategoryRequest(
      {required this.userId,
      required this.categoryId,
      required this.pageId,
      required this.secretKey});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['page_id'] = pageId;
    data['secret_key'] = secretKey;
    return data;
  }
}

class ContentResponse {
  final List<TBLContent> data;
  final String message;
  final bool status;

  ContentResponse(
      {required this.data, required this.message, required this.status});

  factory ContentResponse.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLContent> dataList =
          _dataList.map((e) => TBLContent.fromJson(e)).toList();
      return ContentResponse(
          data: dataList,
          message: jsonData['message'],
          status: jsonData['status']);
    } else {
      return ContentResponse(
          data: [], message: jsonData['message'], status: jsonData['status']);
    }
  }
}

class ChatListResponse {
  final List<TBLChat> data;
  final bool status;

  ChatListResponse({required this.data, required this.status});

  factory ChatListResponse.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLChat> dataList =
          _dataList.map((e) => TBLChat.fromJson(e)).toList();
      return ChatListResponse(data: dataList, status: jsonData['status']);
    } else {
      return ChatListResponse(data: [], status: jsonData['status']);
    }
  }
}

class UserListResponse {
  final List<TBLUser> data;
  final bool status;

  UserListResponse({required this.data, required this.status});

  factory UserListResponse.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLUser> dataList =
          _dataList.map((e) => TBLUser.fromJson(e)).toList();
      return UserListResponse(data: dataList, status: jsonData['status']);
    } else {
      return UserListResponse(data: [], status: jsonData['status']);
    }
  }
}

class BlockUserListResponse {
  final List<TBLBlockUser> data;
  final bool status;

  BlockUserListResponse({required this.data, required this.status});

  factory BlockUserListResponse.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['data'] != null) {
      var _dataList = jsonData['data'] as List;
      List<TBLBlockUser> dataList =
          _dataList.map((e) => TBLBlockUser.fromJson(e)).toList();
      return BlockUserListResponse(data: dataList, status: jsonData['status']);
    } else {
      return BlockUserListResponse(data: [], status: jsonData['status']);
    }
  }
}

class AdsData {
  final String id;
  final String custom_IOS_ONOFF;
  final String custom_Android_ONOFF;
  final String custom_advertisement_IOS;
  final String custom_advertisement_Android;
  final String admod_IOS_ONOFF;
  final String admod_Android_ONOFF;
  final String options;
  final String Frequency_ONOFF;
  final String frequency;
  final String duration;
  final String site_url;

  AdsData(
      {required this.id,
      required this.custom_IOS_ONOFF,
      required this.custom_Android_ONOFF,
      required this.custom_advertisement_IOS,
      required this.custom_advertisement_Android,
      required this.admod_IOS_ONOFF,
      required this.admod_Android_ONOFF,
      required this.options,
      required this.Frequency_ONOFF,
      required this.frequency,
      required this.duration,
      required this.site_url});

  factory AdsData.fromJson(Map<String, dynamic> jsonData) {
    return AdsData(
        id: jsonData['id'],
        custom_IOS_ONOFF: jsonData['custom_IOS_ONOFF'],
        custom_Android_ONOFF: jsonData['custom_Android_ONOFF'],
        custom_advertisement_IOS: jsonData['custom_advertisement_IOS'],
        custom_advertisement_Android: jsonData['custom_advertisement_Android'],
        admod_IOS_ONOFF: jsonData['admod_IOS_ONOFF'],
        admod_Android_ONOFF: jsonData['admod_Android_ONOFF'],
        options: jsonData['options'],
        Frequency_ONOFF: jsonData['Frequency_ONOFF'],
        frequency: jsonData['frequency'],
        duration: jsonData['duration'],
        site_url: jsonData['site_url']);
  }
}

class RequestUserSubscribe {
  final int userId;
  final int subscribeId;
  final int discountId;
  final int paymentId;
  final String total;
  final String secretKey;
  final String referenceNumber;
  final String externalTransactionId;
  final String merchOrderId;
  RequestUserSubscribe(
      {required this.userId,
      required this.subscribeId,
      required this.discountId,
      required this.paymentId,
      required this.total,
      required this.secretKey,
      required this.referenceNumber,
      required this.externalTransactionId,
      required this.merchOrderId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['subscribe_id'] = subscribeId;
    data['discount_id'] = discountId;
    data['payment_id'] = paymentId;
    data['total'] = total;
    data['secret_key'] = secretKey;
    data['referenceNumber'] = referenceNumber;
    data['transaction_id'] = externalTransactionId;
    data['merch_order_id'] = merchOrderId;

    return data;
  }
}

class RequestGetSubscribe {
  final String user_id;
  final String secret_key;
  RequestGetSubscribe({required this.user_id, required this.secret_key});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = user_id;
    data['secret_key'] = secret_key;
    return data;
  }
}

class ResponseGetSubscribe {
  final String message;
  final bool status;
  final TBLPremium data;
  ResponseGetSubscribe(
      {required this.message, required this.status, required this.data});
  factory ResponseGetSubscribe.fromJson(Map<String, dynamic> jsonData) {
    TBLPremium? _data;
    if (jsonData['message'] == 'no subscription') {
      _data = TBLPremium();
    } else {
      try {
        _data = TBLPremium.fromJson(jsonData['data']);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return ResponseGetSubscribe(
        data: _data!, message: jsonData['message'], status: jsonData['status']);
  }
}

class ResponseDeviceList {
  final String message;
  final bool status;
  final List<TBLDevice> data;
  ResponseDeviceList(
      {required this.message, required this.status, required this.data});
  factory ResponseDeviceList.fromJson(Map<String, dynamic> jsonData) {
    List<TBLDevice> deviceList = [];
    try {
      var _deviceList = jsonData['data'] as List;
      deviceList = _deviceList.map((e) => TBLDevice.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    return ResponseDeviceList(
        message: jsonData['message'],
        status: jsonData['status'],
        data: deviceList);
  }
}

class ResponseNotificationList {
  final String message;
  final bool status;
  final List<TblNotification> data;
  ResponseNotificationList(
      {required this.message, required this.status, required this.data});
  factory ResponseNotificationList.fromJson(Map<String, dynamic> jsonData) {
    List<TblNotification> notiList = [];
    try {
      var _notiList = jsonData['data'] as List;
      notiList = _notiList.map((e) => TblNotification.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    return ResponseNotificationList(
        message: jsonData['message'],
        status: jsonData['status'],
        data: notiList);
  }
}

class ResponseTermAndCondition {
  final bool status;
  final TBLTermAndCondition data;
  ResponseTermAndCondition({required this.status, required this.data});
  factory ResponseTermAndCondition.fromJson(Map<String, dynamic> jsonData) {
    TBLTermAndCondition? _data;

    try {
      _data = TBLTermAndCondition.fromJson(jsonData['data']);
    } catch (e) {
      debugPrint(e.toString());
    }

    return ResponseTermAndCondition(status: jsonData['status'], data: _data!);
  }
}

class ResponseAboutUs {
  final bool status;
  final TblAboutUs data;
  ResponseAboutUs({required this.status, required this.data});
  factory ResponseAboutUs.fromJson(Map<String, dynamic> jsonData) {
    TblAboutUs? _data;
    try {
      _data = TblAboutUs.fromJson(jsonData['data']);
    } catch (e) {
      debugPrint(e.toString());
    }
    return ResponseAboutUs(status: jsonData['status'], data: _data!);
  }
}

class ResponsePrivacyPolicy {
  final bool status;
  final TblPrivacyPolicy data;
  ResponsePrivacyPolicy({required this.status, required this.data});
  factory ResponsePrivacyPolicy.fromJson(Map<String, dynamic> jsonData) {
    TblPrivacyPolicy? _data;
    try {
      _data = TblPrivacyPolicy.fromJson(jsonData['data']);
    } catch (e) {
      debugPrint(e.toString());
    }
    return ResponsePrivacyPolicy(status: jsonData['status'], data: _data!);
  }
}

// class Premium {
//   final int id;
//   final bool is_premium;
//   final String last_day;
//   Premium({required this.id, required this.is_premium, required this.last_day});
//   factory Premium.fromJson(Map<String, dynamic> jsonData) {
//     return Premium(
//         id: jsonData['id'],
//         is_premium: jsonData['is_primium'],
//         last_day: jsonData['last_day']);
//   }
// }

class RequestDeviceOtp {
  final String phone;
  final int userId;
  final String secretKey;
  RequestDeviceOtp(
      {required this.phone, required this.userId, required this.secretKey});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['user_id'] = userId;
    data['secret_key'] = secretKey;
    return data;
  }
}

class RequestDeviceRemove {
  final int userId;
  final String secretKey;
  final List<String> deviceId;
  final String otp;
  RequestDeviceRemove(
      {required this.userId,
      required this.secretKey,
      required this.deviceId,
      required this.otp});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['secret_key'] = secretKey;
    data['device_id'] = deviceId;
    data['otp_code'] = otp;
    return data;
  }
}

class RequestSaveContacts {
  final int userId;
  final String secretKey;
  final List<String> phones;
  RequestSaveContacts(
      {required this.userId, required this.secretKey, required this.phones});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['secret_key'] = secretKey;
    data['contacts'] = phones;
    return data;
  }
}
