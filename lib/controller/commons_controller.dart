import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/db/dbModel/tbl_premium.dart';
import 'package:chitmaymay/db/dbModel/tbl_profile.dart';
import 'package:chitmaymay/screen/home/bottom_nav/home_screen.dart';
import 'package:chitmaymay/screen/login/login_screen.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/login/forget_password/forget_verity_otp_screen.dart';
import '../screen/login/forget_password/password_reset_screen.dart';
import '../service/init_service.dart';

class CommonsController extends GetxController {
  

  bool isLoading = false;
  int? userId;
  bool isLogin = false;
  String? tokenKey;
  
  bool isDownloadToday = false;

  List<TBLProfile> profileList = [];
  List<TBLPremium> premiumList = [];

  //Login
  bool passwordSeen = true;
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //change password
  final TextEditingController changePasswordController =
      TextEditingController();
  final TextEditingController changePasswordConfirmController =
      TextEditingController();

  //forgot password
  final TextEditingController forgotPasswordController =
      TextEditingController();

  void setLoading(bool isLoad) {
    isLoading = isLoad;
    update();
  }


  bool changePasswordValidate() {
    return (changePasswordController.text.isNotEmpty) &&
        (changePasswordController.text == changePasswordConfirmController.text);
  }

  void saveForgetOTPVerify(
      BuildContext context, String otp, String phoneNo) async {
    updateLoading(true);
    RequestForgetOTPVerify data = RequestForgetOTPVerify(
        phone: phoneNo, otpCode: otp, secretKey: secret_key);
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestForgetOTPVerify(
          data, context, resetpasswordscreen);
      if ((response?.status ?? false) == true) {
        Get.off(() => PasswordResetScreen(phone: data.phone));
      } else {
        ConstantUtils.showAlertDialog(context, response?.message ?? 'Error');
      }
    } else {
      ConstantUtils.showAlertDialog(context, check_internet_connection);
    }

    updateLoading(false);
  }

  bool validateField() {
    return (phoneNoController.text.isNotEmpty &&
        passwordController.text.isNotEmpty);
  }

  void updateLoading(bool value) {
    isLoading = value;
    update();
  }

  void saveLogin(
    BuildContext context,
  ) async {
    updateLoading(true);
    if (phoneNoController.text.isNumericOnly) {
      if (!phoneNoController.text.startsWith('+95')) {
        phoneNoController.text = '+95' + phoneNoController.text;
      }
    }
    RequestLogin model = RequestLogin(
        phone: phoneNoController.text,
        password: passwordController.text,
        secretKey: secret_key,
        deviceId: initService.getDeviceId,
        deviceName: initService.getDeviceName);
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestLogin(model, context);
      if ((response?.status ?? false) == true) {
        initService.savePrefsUserData(response);
        ConstantUtils.sendFirebaseAnalyticsEvent(loginSuccess);
        initService.initUserData();
        Get.off(() => const HomeScreen(selectedIndex: 0, isDeepLink: false));
      } else {
        ConstantUtils.showAlertDialog(context, response?.message ?? "Error");
      }
      updateLoading(false);
    } else {
      ConstantUtils.showAlertDialog(context, check_internet_connection);
    }
    updateLoading(false);
  }

  //change password
  void savePasswordReset(BuildContext context, String phoneNo) async {
    updateLoading(true);
    RequestPasswordReset data = RequestPasswordReset(
        phone: phoneNo,
        password: changePasswordController.text,
        secretKey: secret_key,
        deviceId: initService.getDeviceId,
        deviceName: initService.getDeviceName);
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final result = await RequestApi.requestPasswordReset(data, context);
      if ((result?.status ?? false) == true) {
        Get.off(() => const LoginScreen());
      } else {
        ConstantUtils.showAlertDialog(context, result?.message ?? 'Error');
      }
    } else {
      ConstantUtils.showAlertDialog(context, check_internet_connection);
    }
    updateLoading(false);
  }

  Future<void> requestForgetOTP(BuildContext context) async {
    updateLoading(true);
    String mPhoneNo;
    if (forgotPasswordController.text.contains('+95')) {
      mPhoneNo = forgotPasswordController.text;
    } else {
      mPhoneNo = '+95' + forgotPasswordController.text;
    }
    RequestOTPResend data =
        RequestOTPResend(phone: mPhoneNo, secretKey: secret_key);
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final result = await RequestApi.requestForgetOTP(data, context);
      if ((result?.status ?? false) == true) {
        Get.off(() => ForgetVerifyOTPScreen(
            phoneNo: data.phone, resetpasswordscreen: resetpasswordscreen));
      } else {
        ConstantUtils.showAlertDialog(context, result?.message ?? 'Error');
      }
    } else {
      ConstantUtils.showAlertDialog(context, check_internet_connection);
    }
    updateLoading(false);
  }
}
