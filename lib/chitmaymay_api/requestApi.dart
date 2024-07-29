import 'dart:convert';
import 'dart:io';
import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/db/dbModel/tbl_profile.dart';
import 'package:chitmaymay/screen/home/bottom_nav/home_screen.dart';
import 'package:chitmaymay/screen/launch/launch_screen.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../db/dbModel/tbl_chat_message.dart';
import '../model/requesr_social.dart';

class RequestApi {
  static Future<CommonResponseMessage?> requestRegister(
      RequestRegister data, BuildContext context) async {
    CommonResponseMessage? responseRegister;
    var response = await http.post(Uri.parse(requestRegisterApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseRegister =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return responseRegister;
  }

  static Future<RegisterVerifyResponse?> requestOTP(
      RequestOTP data, BuildContext context) async {
    RegisterVerifyResponse? responseUserId;
    var response = await http.post(Uri.parse(requestOTPApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseUserId =
          RegisterVerifyResponse.fromJson(jsonDecode(response.body));
    }
    return responseUserId;
  }

  static Future<CommonResponseMessage?> requestForgetOTPVerify(
      RequestForgetOTPVerify data, BuildContext context, String name) async {
    CommonResponseMessage? responseUserId;

    var response = await http.post(Uri.parse(requestForgetOTPVerifyApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseUserId =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    } else {
      ConstantUtils.showAlertDialog(
          context, '${response.statusCode} , ${response.reasonPhrase}');
    }
    return responseUserId;
  }

  static Future<String> requestCBPayment(
      CBRequestPayment cbRequestPayment) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String generateRefOrder = '';
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      try {
        var response = await http.post(Uri.parse(CBRequestPaymentApi),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(cbRequestPayment.toJson()));
        if (response.statusCode == 200) {
          CBResponsePayment responsePayment =
              CBResponsePayment.fromJson(jsonDecode(response.body));
          if (responsePayment.code == '0000') {
            generateRefOrder = responsePayment.generateRefOrder;
            pref.setString(mGenerateRefOrder, generateRefOrder);
          } else {
            pref.setString(generateRefOrder, '');
          }
        } else {
          pref.setString(generateRefOrder, '');
        }
      } catch (e) {
        pref.setString(generateRefOrder, '');
      }
    } else {
      pref.setString(generateRefOrder, '');
    }
    return generateRefOrder;
  }

  static Future<void> requestAYAPayAccessToken(
      BuildContext context,
      String amount,
      String currency,
      int subscribtionID,
      int paymentID,
      int discountID,
      String subscribtionTitle) async {
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      try {
        var response = await http.post(
          Uri.parse(AyaRequestTokenApi),
          headers: <String, String>{
            'Authorization': 'Basic $ayaAuthToken',
            'Content-Type': requestTokenContentType,
          },
        );
        if (response.statusCode == 200) {
          AyaResponseAccessToken responseAccessToken =
              AyaResponseAccessToken.fromJson(jsonDecode(response.body));
          AyaLoginRequest ayaLoginRequest =
              AyaLoginRequest(phone: '09793770810', password: '849521');
          var loginResponse = await http.post(Uri.parse(AyaLoginApi),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Token':
                    '${responseAccessToken.tokenType} ${responseAccessToken.accessToken}'
              },
              body: jsonEncode(ayaLoginRequest.toJson()));
          if (loginResponse.statusCode == 200) {
            AyaRequestPayment ayaRequestPayment = AyaRequestPayment(
                customerPhone: ayaLoginRequest.phone,
                amount: amount,
                currency: currency,
                externalTransactionId: subscribtionID.toString(),
                externalAdditionalData: subscribtionTitle);
            AyaLoginResponse ayaLoginResponse =
                AyaLoginResponse.fromJson(jsonDecode(loginResponse.body));
            var requestPaymentResponse =
                await http.post(Uri.parse(AyaRequestPaymentApi),
                    headers: <String, String>{
                      'Content-Type': 'application/json',
                      'Token':
                          '${responseAccessToken.tokenType} ${responseAccessToken.accessToken}',
                      'Authorization':
                          'Bearer ${ayaLoginResponse.ayaToken.token}'
                    },
                    body: jsonEncode(ayaRequestPayment.toJson()));
            if (requestPaymentResponse.statusCode == 200) {
              AyaRequestPaymentResponse ayaRequestPaymentResponse =
                  AyaRequestPaymentResponse.fromJson(
                      jsonDecode(requestPaymentResponse.body));
              debugPrint(
                  'AyaPaymentResponse: ${ayaRequestPaymentResponse.message}');
              debugPrint(
                  'AyaPaymentResponse id: ${ayaRequestPaymentResponse.data.externalTransactionId}');
              debugPrint(
                  'AyaPaymentResponse referenceNo: ${ayaRequestPaymentResponse.data.referenceNumber}');
              if (ayaRequestPaymentResponse.message == 'Success') {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString(request_access_token,
                    '${responseAccessToken.tokenType} ${responseAccessToken.accessToken}');
                pref.setString(
                    login_token, 'Bearer ${ayaLoginResponse.ayaToken.token}');
                pref.setString(referenceNumber,
                    ayaRequestPaymentResponse.data.referenceNumber);
                pref.setString(externalTransactionId,
                    ayaRequestPaymentResponse.data.externalTransactionId);

                pref.setInt(subscribeId, subscribtionID);
                pref.setInt(discountId, discountID);
                pref.setInt(paymentId, paymentID);
                // Create button
                Widget okButton = GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    Get.to(() =>
                        const HomeScreen(selectedIndex: 0, isDeepLink: false));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: cl1_dark_purple),
                      child: const Center(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                );
                // Create AlertDialog
                AlertDialog alert = AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 50,
                          height: 50,
                          child: SvgPicture.asset('assets/icon/crown.svg'),
                        ),
                        const Text(
                          'Aya Announcement',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const Text(
                          'Please click aya notification or go to aya pay app',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    Center(
                      child: okButton,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                );
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            }
          }
        } else {}
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {}
  }

  static Future<AyaRefundPaymentResponse?> refundPayment(
      AyaRefundPaymentRequest ayaRefundPaymentRequest) async {
    bool isInternet = await ConstantUtils.isInternet();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(request_access_token).toString();
    String authorization = pref.getString(login_token).toString();
    if (isInternet) {
      try {
        var response = await http.post(Uri.parse(AyaRefundPaymentApi),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Token': token,
              'Authorization': authorization
            },
            body: jsonEncode(ayaRefundPaymentRequest.toJson()));
        debugPrint('AyaRefundPaymentResponse: ${response.statusCode}');

        if (response.statusCode == 200) {
          AyaRefundPaymentResponse ayaRefundPaymentResponse =
              AyaRefundPaymentResponse.fromJson(jsonDecode(response.body));
          debugPrint(
              'AyaRefundPaymentResponse: ${ayaRefundPaymentResponse.data.totalAmount}');
          return ayaRefundPaymentResponse;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<CBResponsePaymentPinVerify?> requestCBPinVerify(
      CBRequestPinVerify cbRequestPinVerify) async {
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      try {
        var response = await http.post(Uri.parse(CBPinVerifyApi),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(cbRequestPinVerify.toJson()));
        if (response.statusCode == 200) {
          CBResponsePaymentPinVerify responsePayment =
              CBResponsePaymentPinVerify.fromJson(jsonDecode(response.body));
          if (responsePayment.code == '0000') {
            return responsePayment;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<RegisterVerifyResponse?> requestLogin(
      RequestLogin data, BuildContext context) async {
    RegisterVerifyResponse? responseUserId;
    var response = await http.post(Uri.parse(requestLoginApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseUserId =
          RegisterVerifyResponse.fromJson(jsonDecode(response.body));
    } else {
      ConstantUtils.showAlertDialog(
          context, '${response.statusCode} , ${response.reasonPhrase}');
    }

    return responseUserId;
  }

  static Future<ResponseSocial?> requestSocial(
      RequestSocial data, BuildContext context, bool isGoogleLogin) async {
    ResponseSocial? responseSocial;
    var response = await http.post(Uri.parse(requestSocialSignupApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseSocial = ResponseSocial.fromJson(jsonDecode(response.body));
    } else {
      ConstantUtils.showAlertDialog(
          context, '${response.statusCode} , ${response.reasonPhrase}');
    }

    return responseSocial;
  }

  static Future<ResponseOTPResend?> requestForgetOTP(
      RequestOTPResend data, BuildContext context) async {
    ResponseOTPResend? responseStatus;
    var response = await http.post(Uri.parse(requestForgetOTPApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseStatus = ResponseOTPResend.fromJson(jsonDecode(response.body));
    } else {
      ConstantUtils.showAlertDialog(
          context, '${response.statusCode} , ${response.reasonPhrase}');
    }

    return responseStatus;
  }

  static Future<ResponseOTPResend?> requestOTPResend(
      RequestOTPResend data, BuildContext context) async {
    ResponseOTPResend? responseStatus;
    var response = await http.post(Uri.parse(requestOTPResendApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseStatus = ResponseOTPResend.fromJson(jsonDecode(response.body));
    }
    return responseStatus;
  }

  static Future<RegisterVerifyResponse?> requestPasswordReset(
      RequestPasswordReset data, BuildContext context) async {
    RegisterVerifyResponse? responseUserId;
    var response = await http.post(Uri.parse(requestResetPasswordApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      responseUserId =
          RegisterVerifyResponse.fromJson(jsonDecode(response.body));
    } else {
      ConstantUtils.showAlertDialog(
          context, '${response.statusCode} , ${response.reasonPhrase}');
    }
    return responseUserId;
  }

  static Future<CommonResponseMessage?> requestProfileUpdate(
      TBLProfile profile, String tokenKey) async {
    var mUrl = requestProfileApi;
    CommonResponseMessage? responseMessage;

    var response = await http.post(
      Uri.parse(mUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenKey',
      },
      body: jsonEncode(profile.profileToJson()),
    );
    if (response.statusCode == 200) {
      responseMessage =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return responseMessage;
  }

  static Future<ResponseGetProfile?> requestGetProfile(
      int profileId, String tokenKey) async {
    ResponseGetProfile? responseMessage;
    RequestGetProfile request =
        RequestGetProfile(userId: profileId, secretKey: secret_key);
    var mUrl = requestGetProfileApi;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      responseMessage = ResponseGetProfile.fromJson(jsonDecode(response.body));
    }
    return responseMessage;
  }

  static String encodeImg(File? image) {
    final bytes = image!.readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  static Future<ContentResponse?> requestSaveList(
      String tokenKey, int pageId, int userId) async {
    var mUrl = requestSaveListApi;
    ContentResponse? contentResponse;
    SaveListRequest request =
        SaveListRequest(secretKey: secret_key, userId: userId, pageId: pageId);
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      contentResponse = ContentResponse.fromJson(jsonDecode(response.body));
    }
    return contentResponse;
  }

  static Future<void> requestLogout(
      BuildContext context, LogoutRequest requestData, String tokenKey) async {
    var mUrl = requestLogoutApi;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(requestData.toJson()));
    if (response.statusCode == 200) {
      CommonResponseMessage logoutResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
      if (logoutResponse.status) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        Get.deleteAll();
        Hive.deleteFromDisk();
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LaunchScreen()),
            (route) => false);
      }
    } else {
      showToast(response.reasonPhrase ?? '');
    }
  }

  static Future<ResponseSlide?> requestGetSlide(String tokenKey) async {
    CommonSecretKeyRequest request =
        CommonSecretKeyRequest(secretKey: secret_key);
    ResponseSlide? responseSlide;
    var mUrl = requestGetSlideApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        responseSlide = ResponseSlide.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseSlide;
  }

  static Future<ResponseCheckDiscount?> requestCheckDiscount(
      RequestCheckDiscount requestCheckDiscount, String tokenKey) async {
    var mUrl = requestCheckDiscountApi;
    ResponseCheckDiscount? responseCheckDiscount;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(requestCheckDiscount.toJson()));
    if (response.statusCode == 200) {
      responseCheckDiscount =
          ResponseCheckDiscount.fromJson(jsonDecode(response.body));
    }
    return responseCheckDiscount;
  }

  static Future<ResponseSubscription?> requestGetSubscription(
      String tokenKey, int userId) async {
    CommonSecretKeyRequest request =
        CommonSecretKeyRequest(secretKey: secret_key);
    var mUrl = requestGetSubscriptionApi;
    ResponseSubscription? responseSubscription;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        responseSubscription =
            ResponseSubscription.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseSubscription;
  }

  static Future<ResponsePayment?> requestGetPayment(String tokenKey) async {
    CommonSecretKeyRequest request =
        CommonSecretKeyRequest(secretKey: secret_key);
    var mUrl = requestGetPaymentApi;
    ResponsePayment? responsePayment;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(request.toJson()));
      if (response.statusCode == 200) {
        responsePayment = ResponsePayment.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return responsePayment;
  }

  static Future<HomeResponse?> getHomeRequest(int userId, String tokenKey,
      String deviceId, String firebaseTokenKey) async {
    var mUrl = requestHome;
    HomeResponse? homeResponse;
    HomeDataRequest requestData = HomeDataRequest(
        secretKey: secret_key,
        userId: userId,
        deviceId: deviceId,
        firebaseToken: firebaseTokenKey);
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(requestData.toJson()));
      if (response.statusCode == 200) {
        homeResponse = HomeResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return homeResponse;
  }

  static Future<CategoryContentDetailResponse?> getCategoryContentDetailRequest(
      int contentId, int userId, String tokenKey) async {
    var mUrl = requestContentCategoryDetail;
    CategoryContentDetailRequest requestData = CategoryContentDetailRequest(
        contentId: contentId, userId: userId, secretKey: secret_key);
    CategoryContentDetailResponse? categoryContentDetailResponse;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(requestData.toJson()));
    if (response.statusCode == 200) {
      categoryContentDetailResponse =
          CategoryContentDetailResponse.fromJson(jsonDecode(response.body));
    }

    return categoryContentDetailResponse;
  }

  static Future<CommonResponseMessage?> requestLoveContent(
      TBLContent content, int userId, String tokenKey) async {
    var mUrl = requestLoveContentApi;
    CommonResponseMessage? commonResponseMessage;
    LoveContentRequest requestData = LoveContentRequest(
        contentId: content.id ?? 0,
        userId: userId,
        secretKey: secret_key,
        loveAction: content.loveAction ?? 0);
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(requestData.toJson()));
    if (response.statusCode == 200) {
      commonResponseMessage =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return commonResponseMessage;
  }

  static Future<CommonResponseMessage?> requestSaveContent(
      TBLContent content, int userId, String tokenKey) async {
    var mUrl = requestSaveContentApi;
    CommonResponseMessage? commonResponseMessage;
    SaveContentRequest requestData = SaveContentRequest(
        contentId: content.id ?? 0,
        userId: userId,
        secretKey: secret_key,
        saveAction: content.saveAction ?? 0);
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(requestData.toJson()));

    if (response.statusCode == 200) {
      commonResponseMessage =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return commonResponseMessage;
  }

  static Future<ContentResponse?> getContentCategoryRequest(
      ContentCategoryRequest contentCategoryRequest, String tokenKey) async {
    ContentResponse? contentCategoryResponse;
    var mUrl = requestContentCategory;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(contentCategoryRequest.toJson()));

    if (response.statusCode == 200) {
      contentCategoryResponse =
          ContentResponse.fromJson(jsonDecode(response.body));
    }
    return contentCategoryResponse;
  }

  static Future<ResponseUseCoupon?> requestUseCoupon(
      RequestUseCoupon useCouponRequest, String tokenKey) async {
    ResponseUseCoupon? responseMessage;
    var mUrl = requestUseCouponApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(useCouponRequest.toJson()));
      if (response.statusCode == 200) {
        responseMessage = ResponseUseCoupon.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseMessage;
  }

  static Future<bool> requestUserSubscribe(
      RequestUserSubscribe userSubscribe) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = '';
    if (preferences.getString(token_key) != null) {
      token = preferences.getString(token_key).toString();
    }
    var mUrl = requestUserSubscribeApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(userSubscribe.toJson()));

      if (response.statusCode == 200) {
        CommonResponseMessage responseMessage =
            CommonResponseMessage.fromJson(jsonDecode(response.body));
        if (responseMessage.status) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<ResponseGetSubscribe?> requestGetSubscribe(
      int userId, String tokenKey) async {
    CommonDataRequest dataRequest =
        CommonDataRequest(userId: userId, secretKey: secret_key);
    var mUrl = requestGetSubscribeApi;
    ResponseGetSubscribe? responseMessage;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(dataRequest.toJson()));
      if (response.statusCode == 200) {
        responseMessage =
            ResponseGetSubscribe.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseMessage;
  }

  static Future<ResponseDeviceList?> requestGetDeviceManagerList(
      String deviceId, int userId, String tokenKey) async {
    ResponseDeviceList? responseMessage;

    CommonDataRequest dataRequest =
        CommonDataRequest(userId: userId, secretKey: secret_key);
    var mUrl = requestGetDeviceListApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(dataRequest.toJson()));
      if (response.statusCode == 200) {
        responseMessage =
            ResponseDeviceList.fromJson(jsonDecode(response.body));
      }
      return responseMessage;
    } catch (e) {
      return null;
    }
  }

  static Future<ResponseNotificationList?> requestNotificationList(
      String tokenKey) async {
    CommonSecretKeyRequest dataRequest =
        CommonSecretKeyRequest(secretKey: secret_key);
    var mUrl = requestNotificationApi;
    ResponseNotificationList? responseMessage;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(dataRequest.toJson()));
      if (response.statusCode == 200) {
        responseMessage =
            ResponseNotificationList.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseMessage;
  }

  static Future<CommonResponseMessage?> requestGetDeviceOTP(
      String tokenKey, int userId, String phoneNumber) async {
    RequestDeviceOtp dataRequest = RequestDeviceOtp(
        phone: phoneNumber, userId: userId, secretKey: secret_key);
    var mUrl = requestGetDeviceOTPApi;
    CommonResponseMessage? responseMessage;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(dataRequest.toJson()));
      if (response.statusCode == 200) {
        responseMessage =
            CommonResponseMessage.fromJson(jsonDecode(response.body));
      }
      return responseMessage;
    } catch (e) {
      return null;
    }
  }

  static Future<CommonResponseMessage?> requestDeviceRemove(
      RequestDeviceRemove requestDeviceRemove, String tokenKey) async {
    CommonResponseMessage? responseMessage;
    var mUrl = requestDeviceRemoveApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(requestDeviceRemove.toJson()));
      if (response.statusCode == 200) {
        responseMessage =
            CommonResponseMessage.fromJson(jsonDecode(response.body));
      }
      return responseMessage;
    } catch (e) {
      return null;
    }
  }

  static Future<ResponseTermAndCondition?> requestTermAndCondition() async {
    CommonSecretKeyRequest dataRequest =
        CommonSecretKeyRequest(secretKey: secret_key);
    var mUrl = requestTermAndConditionApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
          body: jsonEncode(dataRequest.toJson()));

      if (response.statusCode == 200) {
        ResponseTermAndCondition responseMessage =
            ResponseTermAndCondition.fromJson(jsonDecode(response.body));

        return responseMessage;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<ResponseAboutUs?> requestAboutUs(String tokenKey) async {
    CommonSecretKeyRequest dataRequest =
        CommonSecretKeyRequest(secretKey: secret_key);
    var mUrl = requestAboutUsApi;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(dataRequest.toJson()));

      if (response.statusCode == 200) {
        ResponseAboutUs responseMessage =
            ResponseAboutUs.fromJson(jsonDecode(response.body));

        return responseMessage;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<ResponsePrivacyPolicy?> requestPrivacyPolicy(
      String tokenKey) async {
    ResponsePrivacyPolicy? responseMessage;
    CommonSecretKeyRequest dataRequest =
        CommonSecretKeyRequest(secretKey: secret_key);
    var mUrl = requestPrivacyPolicyApi;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(dataRequest.toJson()));

    if (response.statusCode == 200) {
      responseMessage =
          ResponsePrivacyPolicy.fromJson(jsonDecode(response.body));
    }
    return responseMessage;
  }

  static Future<AdsData?> getAds50Response() async {
    AdsData? adsData;
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(requestAds50Api));
      if (response.statusCode == 200) {
        adsData = AdsData.fromJson(jsonDecode(response.body));
        debugPrint('RequestResponse adsData50: $adsData');
        return adsData;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  static Future<AdsData?> getAds250Response() async {
    AdsData? adsData;
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(requestAds250Api));
      if (response.statusCode == 200) {
        adsData = AdsData.fromJson(jsonDecode(response.body));
        return adsData;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  static Future<AdsData?> getAds480Response() async {
    AdsData? adsData;
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(requestAds480Api));
      if (response.statusCode == 200) {
        adsData = AdsData.fromJson(jsonDecode(response.body));
        return adsData;
      } else {
        return null;
      }
    } finally {
      client.close();
    }
  }

  //MHK
  static Future<CommonResponseMessage?> requestSendFeedback(
      feedbackModel, tokenKey) async {
    var mUrl = requestSendFeedbackApi;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(feedbackModel.toJson()));
    if (response.statusCode == 200) {
      CommonResponseMessage responseMessage =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
      return responseMessage;
    }
    return null;
  }

  static Future<ChatListResponse?> requestChatList(
      String tokenKey, int userId) async {
    var mUrl = requestChatListApi;
    ChatListResponse? contentResponse;
    MessageListRequest request =
        MessageListRequest(secretKey: secret_key, userId: userId);
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      contentResponse = ChatListResponse.fromJson(jsonDecode(response.body));
    }
    return contentResponse;
  }

  static Future<UserListResponse?> requestUserList(
      String tokenKey, int userId) async {
    var mUrl = requestUserListApi;
    UserListResponse? contentResponse;
    MessageListRequest request =
        MessageListRequest(secretKey: secret_key, userId: userId);
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      contentResponse = UserListResponse.fromJson(jsonDecode(response.body));
    }
    return contentResponse;
  }

  static Future<BlockUserListResponse?> requestBlockUserList(
      String tokenKey, int userId) async {
    var mUrl = requestBlockUserListApi;
    BlockUserListResponse? contentResponse;
    MessageListRequest request =
        MessageListRequest(secretKey: secret_key, userId: userId);
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      contentResponse =
          BlockUserListResponse.fromJson(jsonDecode(response.body));
    }
    return contentResponse;
  }

  static Future<TBLChatMessage?> requestChatMessageList(
      ChatMessageListRequest request, String tokenKey) async {
    var mUrl = requestChatMessageListApi;
    TBLChatMessage? chatMessageResponse;
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(request.toJson()));
    if (response.statusCode == 200) {
      chatMessageResponse = TBLChatMessage.fromJson(jsonDecode(response.body));
    }
    return chatMessageResponse;
  }

  static Future<UserListResponse?> requestMemberList(
      String tokenKey, int groupId) async {
    var mUrl = requestGroupMemberApi;
    UserListResponse? memberResponse;
    Map body = {'group_id': groupId, 'secret_key': secret_key};
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      memberResponse = UserListResponse.fromJson(jsonDecode(response.body));
    }
    return memberResponse;
  }

  static Future<CommonResponseMessage?> requestDeleteGroup(
      String tokenKey, int groupId, int memberId) async {
    var mUrl = requestDeleteGroupApi;
    CommonResponseMessage? deleteGroupResponse;
    Map body = {
      'group_id': groupId,
      'member_id': memberId,
      'secret_key': secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      deleteGroupResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return deleteGroupResponse;
  }

  static Future<CommonResponseMessage?> requestDeleteUser(
      String tokenKey, int toDeleteUserId, int memberId, String convKey) async {
    var mUrl = requestLeaveGroupApi;
    CommonResponseMessage? deleteGroupResponse;
    Map body = {
      'group_id': '',
      'member_id': memberId,
      'deleted_user': toDeleteUserId,
      'chat_conv': convKey,
      'chat_type': 'user',
      'secret_key': secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      deleteGroupResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return deleteGroupResponse;
  }

  static Future<CommonResponseMessage?> requestLeaveGroup(
      String tokenKey, int groupId, int memberId) async {
    var mUrl = requestLeaveGroupApi;
    CommonResponseMessage? deleteGroupResponse;
    Map body = {
      "group_id": groupId,
      "member_id": memberId,
      "deleted_user": "",
      "chat_conv": "",
      "chat_type": "group",
      "secret_key": secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      deleteGroupResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return deleteGroupResponse;
  }

  static Future<CommonResponseMessage?> requestMuteGroup(
      String tokenKey, int groupId, int memberId, int muteStatus) async {
    var mUrl = requestMuteGroupApi;
    CommonResponseMessage? deleteGroupResponse;
    Map body = {
      'group_id': groupId,
      'member_id': memberId,
      'mute_action': muteStatus,
      'secret_key': secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      deleteGroupResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return deleteGroupResponse;
  }

  static Future<CommonResponseMessage?> requestBlockUser(
      String tokenKey, int userId, int blockTo, int blockAction) async {
    var mUrl = requestBlockUserApi;
    CommonResponseMessage? commonResponse;
    Map body = {
      'user_id': userId,
      'block_to': blockTo,
      'block_action': blockAction,
      'secret_key': secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      commonResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return commonResponse;
  }

  static Future<CommonResponseMessage?> requestMuteUser(
      String tokenKey, int userId, int muteTo, int muteAction) async {
    var mUrl = requestMuteUserApi;
    CommonResponseMessage? commonResponse;
    Map body = {
      'user_id': userId,
      'mute_to': muteTo,
      'mute_action': muteAction,
      'secret_key': secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      commonResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return commonResponse;
  }

  static Future<void> requestSendNoti(String tokenKey, int userId, int sendTo,
      String title, String message, String type) async {
    var mUrl = requestSendNotiApi;
    Map body = {
      'user_id': userId,
      'received_id': sendTo,
      'chat_type': type,
      'title': title,
      'messages': message,
      'secret_key': secret_key
    };
    await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
  }

  static Future<UserListResponse?> requestSendContacts(
      RequestSaveContacts requestSaveContacts, String tokenKey) async {
    var mUrl = requestUserListApi;
    UserListResponse? userListResponse;
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(requestSaveContacts.toJson()));
      if (response.statusCode == 200) {
        userListResponse = UserListResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userListResponse;
  }

  static Future<UserListResponse?> requestGetGroupContacts(
      int userId, int groupId, List<String> contacts, String tokenKey) async {
    var mUrl = requestGroupUserListApi;
    UserListResponse? userListResponse;
    Map body = {
      'user_id': userId,
      'group_id': groupId,
      'contacts': contacts,
      'secret_key': secret_key
    };
    try {
      var response = await http.post(Uri.parse(mUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenKey',
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        userListResponse = UserListResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return userListResponse;
  }

  static Future<CommonResponseMessage?> requestAddGroupMember(
      String tokenKey, int groupId, int userId, List<int> members) async {
    var mUrl = requestGroupAddMembersApi;
    CommonResponseMessage? addGroupMemberResponse;
    Map body = {
      'group_id': groupId,
      'user_id': userId,
      'member_id': members,
      'secret_key': secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      addGroupMemberResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return addGroupMemberResponse;
  }

  static Future<UserListResponse?> requestSearchUser(
      String tokenKey, int userId, String keyword) async {
    var mUrl = requestSearchUserApi;
    UserListResponse? searchUserResponse;
    Map body = {'user_id': userId, 'search': keyword, 'secret_key': secret_key};
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      searchUserResponse = UserListResponse.fromJson(jsonDecode(response.body));
    }
    return searchUserResponse;
  }

  static Future<CommonResponseMessage?> requestChangePassword(
    String tokenKey,
    int userId,
    String oldPassword,
    String newPassword,
  ) async {
    var mUrl = requestChangePasswordApi;
    CommonResponseMessage? changePasswordResponse;
    Map body = {
      "user_id": userId,
      "old_password": oldPassword,
      "new_password": newPassword,
      "secret_key": secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      changePasswordResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return changePasswordResponse;
  }

  static Future<CommonResponseMessage?> requestChangePhone(
    String tokenKey,
    int userId,
    String phone,
  ) async {
    var mUrl = requestChangePhoneApi;
    CommonResponseMessage? changePasswordResponse;
    Map body = {"user_id": userId, "phone": phone, "secret_key": secret_key};
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      changePasswordResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return changePasswordResponse;
  }

  static Future<CommonResponseMessage?> requestChangePhoneOtpVerify(
      String tokenKey, int userId, String phone, String otp) async {
    var mUrl = requestChangePhoneVerifyApi;
    CommonResponseMessage? changePasswordResponse;
    Map body = {
      "user_id": userId,
      "otp_code": otp,
      "phone": phone,
      "secret_key": secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      changePasswordResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return changePasswordResponse;
  }

  static Future<CommonResponseMessage?> requestChangeEmail(
    String tokenKey,
    int userId,
    String newEmail,
  ) async {
    var mUrl = requestChangeEmailApi;
    CommonResponseMessage? changeEmailResponse;
    Map body = {"user_id": userId, "email": newEmail, "secret_key": secret_key};
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      changeEmailResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return changeEmailResponse;
  }

  static Future<CommonResponseMessage?> requestChangeEmailOtpVerify(
      String tokenKey, int userId, String email, String otp) async {
    var mUrl = requestChangeEmailVerifyApi;
    CommonResponseMessage? changeEmailResponse;
    Map body = {
      "user_id": userId,
      "code": otp,
      "email": email,
      "secret_key": secret_key
    };
    var response = await http.post(Uri.parse(mUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      changeEmailResponse =
          CommonResponseMessage.fromJson(jsonDecode(response.body));
    }
    return changeEmailResponse;
  }

  static Future<String> requestKpayPayment(
      KPayRequestPayment request, String tokenKey) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Request'] = request.toJson();
    var response = await http.post(Uri.parse(kbzPayUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      KpayCreateOrderResponseBody kpayCreateOrderResponse =
          KpayCreateOrderResponseBody.fromJson(jsonDecode(response.body));

      if (kpayCreateOrderResponse.response.msg == 'success') {
        String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
        String prepayId = kpayCreateOrderResponse.response.prepayId;
        String rawSign =
            "appid=$appId&merch_code=$merchCode&nonce_str=$nonceStr&prepay_id=$prepayId&timestamp=$timeStamp";
        var signInBytes = utf8.encode(rawSign + "&key=" + appKey);
        String sign = sha256.convert(signInBytes).toString().toUpperCase();
        String launchurl =
            "http://app.chitmaymay.com/payment/kbzPage?link=$kbzReferUrl&app_id=$appId&merch_code=$merchCode&nonce_str=$nonceStr&prepay_id=$prepayId&timestamp=$timeStamp&sign=$sign";
        await launch(launchurl, enableJavaScript: true, forceSafariVC: false);
        return prepayId;
      }
    }
    return "";
  }

  static Future<KpayQueryOrderResponseBody?> queryKpayPayment(
      KpayQueryOrderRequest request, String tokenKey) async {
    KpayQueryOrderResponseBody? kpayQueryOrderResponseBody;
    final Map<String, dynamic> queryData = <String, dynamic>{};
    queryData['Request'] = request.toJson();
    var queryOrderResponse = await http.post(Uri.parse(kbzPayQueryOrderUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(queryData));
    if (queryOrderResponse.statusCode == 200) {
      kpayQueryOrderResponseBody = KpayQueryOrderResponseBody.fromJson(
          jsonDecode(queryOrderResponse.body));
    }
    return kpayQueryOrderResponseBody;
  }
}
