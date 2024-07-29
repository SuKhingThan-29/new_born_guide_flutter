import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestApiFromData.dart';
import 'package:chitmaymay/chitmaymay_api/requestApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestModel.dart';
import 'package:chitmaymay/db/dbModel/tbl_premium.dart';
import 'package:chitmaymay/db/dbModel/tbl_profile.dart';
import 'package:chitmaymay/db/dbModel/tbl_slide.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/change_phoneno/change_phone_otp_verify.dart';
import 'package:chitmaymay/screen/home/nav/bmi_calculation/_bmi_calculation.dart';
import 'package:chitmaymay/screen/launch/launch_screen.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db/dbModel/tbl_about_us.dart';
import '../db/dbModel/tbl_device.dart';
import '../db/dbModel/tbl_privacy_policy.dart';
import '../model/feedback_model.dart';
import '../screen/home/bottom_nav/setting/change_email/change_email_verify.dart';
import '../screen/home/nav/device_manager/device_delete_otp.dart';
import '../service/boxes.dart';
import '../service/init_service.dart';

class SettingController extends GetxController {
  var isSwitched = false.obs;
  bool noSubscribtion = true;
  int premiumDay = 0;
  Color mTopColor = blueTopColor;
  Color mBottomColor = blueBottomColor;

  var userProfile = TBLProfile().obs;
  bool isLoading = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  var dayValue = '1'.obs;
  var monthValue = 'January'.obs;
  var yearValue = '1960'.obs;
  var isMale = true.obs;
  var isParent = true.obs;
  var isPregnent = true.obs;
  var urlImageEncode = ''.obs;
  var profileSaveLoading = false.obs;
  var isPremium = false.obs;
  var premium = TBLPremium().obs;
  List<TBLSlide> slides = [];

  final CarouselController carouselController = CarouselController();
  PersistentBottomSheetController? bottomSheetController;
  var selectedSlide = 0.obs;

  @override
  void onInit() {
    fetchUserData();
    fetchPremium();
    fetchSlideList();
    fetchDeviceList();
    //ConstantUtils.sendFirebaseAnalyticsEvent(settingScreen);
    super.onInit();
  }

  void updateSliderIndex(page) {
    selectedSlide.value = page;
  }

  Future<void> disposeProfileData() async {
    profileSaveLoading.value = false;
  }

  Future<void> initProfileData() async {
    fullNameController.text = userProfile.value.fullName ?? '';
    urlImageEncode.value = userProfile.value.image ?? "";
    userNameController.text = userProfile.value.username ?? '';
    passwordController.text =
        (userProfile.value.password == '') ? '' : '12345678';
    phoneNoController.text = userProfile.value.phoneNo ?? '';
    emailController.text = userProfile.value.email ?? '';
    isMale.value =
        (userProfile.value.gender ?? Gender.male) == Gender.male ? true : false;
    isParent.value = (userProfile.value.isParent ?? 1) == 0 ? false : true;
    isPregnent.value = (userProfile.value.isPregnent ?? 1) == 0 ? false : true;
    if (userProfile.value.dob != null) {
      DateTime bd = DateTime.parse(userProfile.value.dob ?? "");
      dayValue.value = bd.day.toString();
      yearValue.value = bd.year.toString();
    }
  }

  Future<void> uploadProfileImage(File image) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response =
          await ImageUploadApi.profileImageUpload(image, initService.getToken);
      if (response?.status ?? false) {
        urlImageEncode.value = response?.data ?? '';
        userProfile.value.image = response?.data ?? '';
      } else {
        debugPrint('error image upload');
      }
    }
  }

  updateProfileLoading(bool value) {
    profileSaveLoading.value = value;
  }

  Future<void> saveProfile(BuildContext context) async {
    try {
      updateProfileLoading(true);
      if (phoneNoController.text.startsWith("+95")) {
        userProfile.value.phoneNo = phoneNoController.text;
      } else {
        userProfile.value.phoneNo = "+95" + phoneNoController.text;
      }
      var inputDate = ConstantUtils.dayMonthNameYearFormat.parse(
          '${dayValue.value}-${monthValue.value}-${yearValue.value}'); // // <-- dd-LLLL-yyyy (full month name)
      var outputDate = ConstantUtils.yearMonthDateFormat
          .format(inputDate); // <-- dd-MM-yyyy (month number)
      userProfile.value.id = initService.getUserId;
      userProfile.value.username = userNameController.text;
      userProfile.value.fullName = fullNameController.text;
      userProfile.value.password = passwordController.text;
      userProfile.value.email = emailController.text;
      userProfile.value.dob = outputDate;
      userProfile.value.gender = isMale.value == true ? "male" : "female";
      userProfile.value.isParent = (isParent.value == true) ? 1 : 0;
      userProfile.value.isPregnent = (isPregnent.value == true) ? 1 : 0;
      final response = await RequestApi.requestProfileUpdate(
          userProfile.value, initService.getToken);
      if (response?.status ?? false) {
        showToast('Successfully saved!');
        fetchUserData();
        Get.back();
      } else {
        showToast(response?.message ?? 'error'.tr);
      }
      updateProfileLoading(false);
    } catch (e) {
      debugPrint(e.toString());
      updateProfileLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    final isInternet = await ConstantUtils.isInternet();
    final box = Boxes.getProfile();
    if (isInternet) {
      final response = await RequestApi.requestGetProfile(
          initService.getUserId, initService.getToken);
      if (response?.status ?? false) {
        userProfile.value = response?.data ?? TBLProfile();
        box.put('profile', userProfile.value);
      } else {
        userProfile.value = box.get('profile')!;
      }
    } else {
      userProfile.value = box.get('profile')!;
    }
    updateLoading(false);
  }

  updateLoading(bool value) {
    isLoading = value;
  }

  void fetchSlideList() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestGetSlide(initService.getToken);
      if (response?.status ?? false) {
        slides = response?.data ?? [];
        update();
      } else {
        debugPrint('error slide list');
      }
    }
  }

  void fetchPremium() async {
    final box = Boxes.getPremium();
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestGetSubscribe(
          initService.getUserId, initService.getToken);
      if (response?.status ?? false) {
        premium.value = response?.data ?? TBLPremium();
        box.put('premium', premium.value);
      } else {
        premium.value = box.get('premium')!;
      }
    } else {
      premium.value = box.get('premium')!;
    }

    isPremium.value = premium.value.isPremium ?? false;
    premiumDay = int.parse(premium.value.lastDay ?? "0");
    if (premiumDay >= 16) {
      mTopColor = blueTopColor;
      mBottomColor = blueBottomColor;
    } else if (premiumDay >= 11 && premiumDay <= 15) {
      mTopColor = greenTopColor;
      mBottomColor = greenBottomColor;
    } else if (premiumDay >= 6 && premiumDay <= 10) {
      mTopColor = yellowTopColor;
      mBottomColor = yellowBottomColor;
    } else {
      mTopColor = redTopColor;
      mBottomColor = redBottomColor;
    }
    update();
  }

  void logoutRequest(BuildContext context) async {
    LogoutRequest data = LogoutRequest(
        userId: initService.getUserId,
        secretKey: secret_key,
        deviceId: initService.getDeviceId);
    RequestApi.requestLogout(context, data, initService.getToken);
  }

  //change password
  var changePasswordLoading = false.obs;
  void updatePassword(String newPassword, String oldPassword) async {
    changePasswordLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestChangePassword(
          initService.getToken,
          initService.getUserId,
          oldPassword,
          newPassword);
      if (response?.status ?? false) {
        showToast('successfully changed!');
        Get.back();
      } else {
        showToast(response?.message ?? '');
      }
    }
    changePasswordLoading.value = false;
  }

  //change phone
  var changePhoneLoading = false.obs;
  void updatePhone(String phone) async {
    changePasswordLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestChangePhone(
          initService.getToken, initService.getUserId, phone);
      if (response?.status ?? false) {
        Get.off(ChangePhoneOTPScreen(phoneNo: phone));
      } else {
        showToast(response?.message ?? '');
      }
    }
    changePhoneLoading.value = false;
  }

  void phoneOtpVerify(String phone, String otp) async {
    changePasswordLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestChangePhoneOtpVerify(
          initService.getToken, initService.getUserId, phone, otp);
      if (response?.status ?? false) {
        userProfile.value.phoneNo = phone;
        phoneNoController.text = phone;
        Get.back();
      } else {
        showToast(response?.message ?? '');
      }
    }
    changePhoneLoading.value = false;
  }

  void resendPhVerify(String phone) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestChangePhone(
          initService.getToken, initService.getUserId, phone);
      if (response?.status ?? false) {
        showToast('Send OTP successfully!');
      } else {
        showToast(response?.message ?? '');
      }
    }
  }

  //change email
  var changeEmailLoading = false.obs;
  void updateEmail(String newEmail) async {
    changeEmailLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestChangeEmail(
          initService.getToken, initService.getUserId, newEmail);
      if (response?.status ?? false) {
        Get.off(ChangeEmailVerify(
          email: newEmail,
        ));
      } else {
        showToast(response?.message ?? '');
      }
    }
    changeEmailLoading.value = false;
  }

  void emailVerify(String email, String code) async {
    changeEmailLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestChangeEmailOtpVerify(
          initService.getToken, initService.getUserId, email, code);
      if (response?.status ?? false) {
        userProfile.value.email = email;
        emailController.text = email;
        Get.back();
      } else {
        showToast(response?.message ?? '');
      }
    }
    changeEmailLoading.value = false;
  }

  //device list
  var deviceLoading = true.obs;
  var deviceList = <TBLDevice>[].obs;
  var deviceId = "".obs;
  var removeDeviceList = <String>[].obs;
  var phoneNo = ''.obs;
  void fetchDeviceList() async {
    final box = Boxes.getDevice();
    final isInternet = await ConstantUtils.isInternet();
    deviceId.value = initService.getDeviceId;
    if (isInternet) {
      final response = await RequestApi.requestGetDeviceManagerList(
          initService.getDeviceId, initService.getUserId, initService.getToken);
      if (response?.status ?? false) {
        deviceList.value = response?.data ?? [];
        box.addAll(deviceList);
        int index = deviceList.indexWhere((element) =>
            element.deviceId.toString() == initService.getDeviceId);
        if (index < 0) {
          initService.clearData();
          Get.off(() => LaunchScreen());
        }
      } else {
        deviceList.value = box.values.toList();
      }
    } else {
      deviceList.value = box.values.toList();
    }
    deviceLoading.value = false;
  }

  void clearSelectList() {
    removeDeviceList.value = [];
    for (var element in deviceList) {
      element.isSelected = false;
    }
  }

  void addRemoveDeviceList(TBLDevice device, int index) {
    if (device.isSelected ?? false) {
      removeDeviceList.remove(device.deviceId);
    } else {
      removeDeviceList.add(device.deviceId ?? '');
    }
    device.isSelected = !(device.isSelected ?? false);
    deviceList[index] = device;
  }

  void requestDeviceOtp() async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestGetDeviceOTP(
          initService.getToken,
          initService.getUserId,
          userProfile.value.phoneNo ?? '');
      if (response?.status ?? false) {
        Get.off(() => DeviceDeleteOtp(selectedDeviceList: removeDeviceList));
      }
    }
  }

  void getPhoneNo() {
    String ph = userProfile.value.phoneNo ?? '';
    if (ph.isNotEmpty) {
      var startPhoneNo = ph.substring(0, 3);
      var endPhoneNo = ph.substring(11, 14);
      phoneNo.value = '$startPhoneNo ******** $endPhoneNo';
    }
  }

  void deviceOTP(String otpCode) async {
    RequestDeviceRemove deviceRemove = RequestDeviceRemove(
        userId: initService.getUserId,
        secretKey: secret_key,
        deviceId: removeDeviceList,
        otp: otpCode);
    final response = await RequestApi.requestDeviceRemove(
        deviceRemove, initService.getToken);
    if (response?.status ?? false) {
      fetchDeviceList();
      Get.back();
    }
  }

//feedback
  var feedbackLoading = false.obs;
  void sendFeedback(String title, String message, context) async {
    feedbackLoading.value = true;
    FeedBackModel model = FeedBackModel(
        title: title, description: message, userId: initService.getUserId);
    final response =
        await RequestApi.requestSendFeedback(model, initService.getToken);

    if (response != null) {
      showToast('Send Message Success');
      Get.back();
    } else {
      feedbackLoading.value = false;
    }
  }

  //privacy and policy
  var privacyPolicy = TblPrivacyPolicy().obs;
  final privacyLoading = true.obs;
  void fetchPrivacyPolicy() async {
    final box = Boxes.getPrivacyPolicy();
    privacyLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response =
          await RequestApi.requestPrivacyPolicy(initService.getToken);
      if (response != null) {
        privacyPolicy.value = response.data;
        box.put('privacyPolicy', privacyPolicy.value);
      } else {
        privacyPolicy.value = box.get('privacyPolicy')!;
      }
    } else {
      privacyPolicy.value = box.get('privacyPolicy')!;
    }
    privacyLoading.value = false;
  }

  //about us
  var aboutUs = TblAboutUs().obs;
  final aboutUsLoading = true.obs;
  void fetchAboutUs() async {
    final box = Boxes.getAboutUs();
    aboutUsLoading.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestAboutUs(initService.getToken);
      if (response != null) {
        aboutUs.value = response.data;
        box.put('aboutUs', aboutUs.value);
      } else {
        aboutUs.value = box.get("aboutUs")!;
      }
    } else {
      aboutUs.value = box.get("aboutUs")!;
    }
    aboutUsLoading.value = false;
  }
}
