import 'package:flutter/material.dart';

//For SharePreference
const lang = 'Lang';
String mDeviceId = 'mDeviceId';
String mDeviceName = 'mDeviceName';
String token_key = 'token_key';
String firebase_token_key = 'firebase_token_key';
String phoneNo = 'phoneNo';
String mUserId = 'mUserId';
String mGenerateRefOrder = 'mGenerateRefOrder';
String subscribeId = 'subscribeId';
String discountId = 'discountId';
String paymentId = 'paymentId';
String paymentName = 'paymentName';
String request_access_token = 'request_access_token';
String login_token = 'login_token';
String referenceNumber = 'referenceNumber';
String externalTransactionId = 'externalTransactionId';
String IsLogin = 'IsLogin';
String currentDate = 'currentDate';

//Screen Height
double spaceBase = 20.0;
double spaceMedium = 20.0; //Space between logo
double spaceLeft = 30;
double spaceRight = 30;
double logoWidth = 150.0;
double logoHeight = 150.0;

//TitleSize
const double titleSize = 24.0;
const double mediumSize = 22.0;
const double labelSize = 14.0;
const double size_16 = 16.0;
const double size_12 = 12.0;
const double toolbar_title_size = 18.0;

//Classic 1 Light
const backgroundColor = Color(0xFFF7F7F7);
const titlePurpleColor = Color(0xFF6C539B);
const arrowForwardColor = Colors.grey;
const redColor = Colors.red;
const blackColor = Colors.black;
const whiteColor = Colors.white;
const greyColor = Colors.grey;
const greenColor = Colors.green;
const borderLineColor = Color(0xFFEEE1FF);
const checkedColor = Color(0xFF6C539B);
const backgroundDarkPurple = Color(0xFF714FA0);
const backgroundLightPurple = Color(0xFFB79FD9);
const boderLightPurple = Color(0xFFF1E5FF);
const deepPurple = Color(0xFF611E84);
const orangeColor = Color(0xFFFE9601);
const spinGreenColor = Color(0xFF00B88F);
const darkBlueColor = Color(0xFF00376E);
const lightGrey = Color(0xE6E0E0E0);

Color cl1_dark_purple = HexColor("#714FA0"); //puple
Color cl1_box2 = HexColor("#714FA0");
Color cl1_background_grey = HexColor("#F2F2F2");

Color cl1_box_color = HexColor("#714FA0"); //purple

//Classic 2 Pink
Color cl2_background_color = HexColor("#F7E3D9");
Color cl2_box1 = HexColor("#C6D8D5");
Color cl2_box2 = HexColor("#F3A49D");

Color normalWeightColor = HexColor("#6FAF4D");
Color overWeightColor = HexColor("#F0C430");
Color underWeightColor = HexColor("#4D8DAF");
Color obesityColor = HexColor("#DC1B53");

Color topColor = HexColor('#823FA5');
Color bottomColor = HexColor('#3C1052');

Color blueTopColor = HexColor('#427BBE');
Color blueBottomColor = HexColor('#0D3F84');

Color greenTopColor = HexColor('#30A380');
Color greenBottomColor = HexColor('#095340');

Color yellowTopColor = HexColor('#DDCE5F');
Color yellowBottomColor = HexColor('#B77822');

Color redTopColor = HexColor('#EA5D5D');
Color redBottomColor = HexColor('#AC1400');

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

const String CurrentDate50 = 'CurrentDate';
const String CurrentDate250 = 'CurrentDate250';
const String CurrentDate480 = 'CurrentDate480';
const String check_internet_connection =
    'Please Check Your Internet Connection';
const String message = 'Success';

//Testing

const String bannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
const String bannerIOS = 'ca-app-pub-3940256099942544/2934735716';
const String interstitialAndroid = 'ca-app-pub-3940256099942544/1033173712';
const String interstitialIOS = 'ca-app-pub-3940256099942544/4411468910';
const String nativeAdvancedAndroid = 'ca-app-pub-3940256099942544/2247696110';
const String nativeAdvanceIOS = 'ca-app-pub-3940256099942544/3986624511';

//API Response
const String resend_otp = 'Please Resend OTP';
const String forgotpasswordscreen = 'forgotpasswodscreen';
const String otpscreen = 'otpscreen';
const String resetpasswordscreen = 'resetpasswordscreen';

const String notPremium = 'You are not premium';
const String profileWithPhoneNumber =
    'Please update your profile with phoneNumber';

//Event
const String homeScreen = 'HomeScreen';
const String settingScreen = 'SettingScreen';
const String downloadScreen = 'DownloadScreen';
const String saveDetailScreen = 'SaveDetailScreen';
//Register Event
const String singUpResquestSuccess = 'SingUpRequstSuccess';
const String signUpOtpSuccess = 'SignUpOtpSuccess';
const String otpResendSuccess = 'OtpResendSuccess';
const String loginSuccess = 'LoginSuccess';
const String passwordResetSuccess = 'PasswordResetSuccess';
const String fbSignupSuccess = 'FBSignupSuccess';
const String googleSignupSuccess = 'GoogleSignupSuccess';
//ViewMore
const String viewMoreEvent = 'ViewMoreEvent';
//Detail
const String contentDetailScreen = 'ContentDetailScreen';
const String videoDetailScreen = 'VideoDetailScreen';
const String comicDetailScreen = 'ComicDetailScreen';
//Nav
const String bmiScreen = 'BMICalculationScreen';
const String deviceManagerScreen = 'DeviceManagerScreen';
const String deviceRemoveOtpSuccess = 'DeviceRemoveOTPSuccess';
//Premium
const String subscribe = 'Subscribe';
const String payEvent = 'Event';
const String paymentConfirmation = 'PaymentConfirmEvent';

//CB Pay
const String cbAuthToken =
    '21b4e40fb4dd2e438bd6034a582da44e7d3afa451b8b702299f59178056c215fc7496074992a7e93d8945c966e55dad6d204ca85bcfaf507cedffc881b2d3ed0';
const String ecommerceId = 'M010101';
const String subMerId = '0000000004400001';
const String orderId = 'AA1111';
const String amounts = '1999.00';
const String currency = 'MMK';
const String transactionType = '1';
const String orderDetails = 'CB Test Order 001';
const String notifyUrl = 'http://www.example.com';

//Aya Pay
const String ayaAuthToken =
    'WUc0WktjN1hXYjVDS0xPZUg4VGVRQjJLVVdRYTp0emtaT1J0X3hRb2FFOWNhVnhMbHRUOWt4SDhh';
const String requestTokenContentType = 'application/x-www-form-urlencoded';
const String client_credentials = 'client_credentials';

//Kbz Pay
const String kbzPayUrl = "http://api.kbzpay.com/payment/gateway/uat/precreate";
const String kbzPayQueryOrderUrl =
    "http://api.kbzpay.com/payment/gateway/uat/queryorder";
const String kbzReferUrl = "https://static.kbzpay.com/pgw/uat/pwa/";
const String method = "kbz.payment.precreate";
const String kbzNotifyUrl = "https://app.chitmaymay.com/api/notify_url";
const String signType = "SHA256";
const String nonceStr = "5K8264ILTKCH16CQ2502SI8ZNMTM67VS";
const String version = "1.0";
const String appId = "kp26f13a1c2b874bfeb877a0eb1ed74a";
const String tradeType = "PWAAPP";
const String merchCode = "200249";
const String appKey = "chitmaymay@123";
const String paySuccess = "PAY_SUCCESS";
const String waitPay = "WAIT_PAY";

//socket
const String serverUrl = 'http://chat.chitmaymay.com';
const String tokenValue = 'chitmaymay@2022';
