import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/widgets/custom_alertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/requesr_social.dart';
import '../screen/home/bottom_nav/home_screen.dart';
import '../screen/login/otp/otp_screen.dart';
import '../service/init_service.dart';
import '../utils/constant_util.dart';
import '../utils/style.dart';

class SignUpController extends GetxController {
  bool isLoading = false;

  bool checkBox = false;
  bool isCheck = true;
  bool filledUserName = true;
  bool filledPhoneNo = true;
  bool filledPassword = true;
  bool filledConfirmedPassword = true;
  bool passwordSeen = true;
  bool confirmSeen = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();


  void validate(BuildContext context) {
    filledUserName = usernameController.text.isNotEmpty;
    filledPhoneNo = phoneNoController.text.isNotEmpty;
    filledPassword = passwordController.text.isNotEmpty;
    filledConfirmedPassword = (confirmPasswordController.text.isNotEmpty) &&
        (passwordController.text == confirmPasswordController.text);
    isCheck = checkBox;
    update();
    if (filledUserName &&
        filledPhoneNo &&
        filledPassword &&
        filledConfirmedPassword &&
        isCheck) {
      saveRegister(context);
    }
  }

  void updateCheckBox(bool value) {
    checkBox = value;
    update();
  }

//register
  void saveRegister(context) async {
    isLoading = true;
    update();
    if (!phoneNoController.text.startsWith('+95')) {
      phoneNoController.text = '+95' + phoneNoController.text;
    }
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      RequestRegister data = RequestRegister(
          name: usernameController.text,
          phone: phoneNoController.text,
          password: passwordController.text,
          deviceId: initService.getDeviceId,
          secretKey: secret_key);
      final response = await RequestApi.requestRegister(data, context);
      if (response?.status ?? false) {
        ConstantUtils.sendFirebaseAnalyticsEvent(singUpResquestSuccess);
        Get.off(() => OTPScreen(
              phoneNo: data.phone,
            ));
      } else {
        showAlertDialog(
            context, 'error'.tr, response?.message ?? 'Error Sign Up', 'ok'.tr,
            () {
          Navigator.pop(context);
        });
      }
    } else {
      showAlertDialog(context, 'error'.tr, 'no_internet'.tr, 'ok'.tr, () {
        Navigator.pop(context);
      });
    }
    isLoading = false;
    update();
  }

  var verifyRegisterLoading = false.obs;
  void verifyRegister(context, phone, otp) async {
    verifyRegisterLoading.value = true;
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      RequestOTP data = RequestOTP(
          phone: phone,
          otpCode: otp,
          secretKey: secret_key,
          deviceId: initService.getDeviceId,
          deviceName: initService.getDeviceName);
      final response = await RequestApi.requestOTP(data, context);
      if (response?.status ?? false) {
        await initService.savePrefsUserData(response);
        ConstantUtils.sendFirebaseAnalyticsEvent(signUpOtpSuccess);
        Get.off(() => const HomeScreen(selectedIndex: 0, isDeepLink: false));
      } else {
        showAlertDialog(
            context, 'error'.tr, response?.message ?? 'Error Sign Up', 'ok'.tr,
            () {
          Navigator.pop(context);
        });
      }
    } else {
      showAlertDialog(context, 'error'.tr, 'no_internet'.tr, 'ok'.tr, () {
        Navigator.pop(context);
      });
    }
    verifyRegisterLoading.value = false;
  }

  void resendOtpRegister(context, phoneNo) async {
    verifyRegisterLoading.value = true;

    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      RequestOTPResend data =
          RequestOTPResend(phone: phoneNo, secretKey: secret_key);
      final response = await RequestApi.requestOTPResend(data, context);
      if (response?.status ?? false) {
        showToast('OTP sent!');
      } else {
        showAlertDialog(context, 'error'.tr,
            response?.message ?? 'Error Resend OTP code', 'ok'.tr, () {
          Navigator.pop(context);
        });
      }
    } else {
      showAlertDialog(context, 'error'.tr, 'no_internet'.tr, 'ok'.tr, () {
        Navigator.pop(context);
      });
    }
    verifyRegisterLoading.value = false;
  }

  var googleSignInLoading = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> signInWithGoogle(BuildContext context) async {
    googleSignInLoading.value = true;
    bool isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      await _googleSignIn.signOut();
      final userData = await _googleSignIn.signIn();
      debugPrint(userData?.email ?? "");
      if (userData != null) {
        GoogleSignInAccount user = userData;
        RequestSocial requestSocial = RequestSocial();
        requestSocial.socialId = user.id;
        requestSocial.name = user.displayName;
        requestSocial.fullName = user.displayName;
        requestSocial.email = user.email;
        requestSocial.deviceId = initService.getDeviceId;
        requestSocial.deviceName = initService.getDeviceName;
        requestSocial.secretKey = secret_key;
        final response =
            await RequestApi.requestSocial(requestSocial, context, true);
        if (response != null) {
          if (response.status) {
            initService.sharedPreferences.setString(token_key, response.token);
            initService.sharedPreferences.setInt(mUserId, response.userId);
            initService.sharedPreferences.setString(phoneNo, "");
            initService.sharedPreferences.setBool(IsLogin, true);
            String now =
                ConstantUtils.dayMonthNumberYearFormat.format(DateTime.now());
            initService.sharedPreferences.setString(currentDate, now);
            ConstantUtils.sendFirebaseAnalyticsEvent(loginSuccess);
            initService.initUserData();
            initService.registerBoxes();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const HomeScreen(selectedIndex: 0, isDeepLink: false)));
          }
        }
        googleSignInLoading.value = false;
      }
    }
    googleSignInLoading.value = false;
  }

  var fbSignInLoading = false.obs;
  Future<void> signInWithFacebook(BuildContext context) async {
    fbSignInLoading.value = true;

    bool isInternet = await ConstantUtils.isInternet();

    if (isInternet) {
      await FacebookAuth.instance.logOut();
      final facebookLogin = await FacebookAuth.instance.login();

      if (facebookLogin.status == LoginStatus.success) {
        final user = await FacebookAuth.instance.getUserData(
          fields: "email, name",
        );
        RequestSocial requestSocial = RequestSocial();
        requestSocial.socialId = user['id'];
        requestSocial.name = user['name'];
        requestSocial.fullName = user['name'];
        requestSocial.email = user['email'];
        requestSocial.deviceId = initService.getDeviceId;
        requestSocial.deviceName = initService.getDeviceName;
        requestSocial.secretKey = secret_key;
        ResponseSocial? response =
            await RequestApi.requestSocial(requestSocial, context, false);
        if (response != null) {
          if (response.status) {
            initService.sharedPreferences.setString(token_key, response.token);
            initService.sharedPreferences.setInt(mUserId, response.userId);
            initService.sharedPreferences.setString(phoneNo, "");
            initService.sharedPreferences.setBool(IsLogin, true);
            String now =
                ConstantUtils.dayMonthNumberYearFormat.format(DateTime.now());
            initService.sharedPreferences.setString(currentDate, now);
            ConstantUtils.sendFirebaseAnalyticsEvent(loginSuccess);
            initService.initUserData();
            initService.registerBoxes();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const HomeScreen(selectedIndex: 0, isDeepLink: false)));
          }
        }
        fbSignInLoading.value = false;
      }
    }
    fbSignInLoading.value = false;
  }
}
