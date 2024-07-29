const mHttp = 'https://app.chitmaymay.com/api';
const categoryApi = mHttp + 'category_api.php';
const secret_key = 'yo7dbkmj4ufg6yix9eshwb';
const String aesKey =
    '11122233344455566677788822244455555555555555555231231321313aaaff';

const mHttpAthabyar = 'https://athabyar.dkmads.com';

//Ads
const requestAds250Api = mHttpAthabyar + '/admin_login/add_one_api.php';
const requestAds50Api = mHttpAthabyar + '/admin_login/add_two_api.php';
const requestAds480Api = mHttpAthabyar + '/admin_login/add_three_api.php';

//Register
const requestRegisterApi = mHttp + '/register';
//OTP Verify
const requestOTPApi = mHttp + '/otp_verified'; //Call HomeScreen
//Login
const requestLoginApi = mHttp + '/login';
//OTPResend
const requestOTPResendApi = mHttp + '/otp_resend'; //Go to OTPscreen
//RequestForgetOTP
const requestForgetOTPApi = mHttp + '/otp_forget'; //Go to ForgetVerifyOtp
//ForgetOTPVerify
const requestForgetOTPVerifyApi =
    mHttp + '/otp_forget_verified'; //Go to PasswordReset
//Social SignUP
const requestSocialSignupApi = mHttp + '/social_singup'; //Call HomeScreen

//PasswordReset
const requestResetPasswordApi = mHttp + '/reset_password'; //Call HomeScreen
//Logout
const requestLogoutApi = mHttp + '/customer_logout';
//Home
const requestHome = mHttp + '/home';
//Content Category
const requestContentCategory = mHttp + '/content_category';
//Content Category Detail
const requestContentCategoryDetail = mHttp + '/content_detail';
//love content_video request
const requestLoveContentApi = mHttp + '/love_content';
//component content_video
const requestSaveContentApi = mHttp + '/save_content';
//savelist
const requestSaveListApi = mHttp + '/save_list';
//profileUpdate
const requestProfileApi = mHttp + '/update_profile';
//profileUpload
const requestProfileUploadApi = mHttp + '/upload_profile';
//profileGET
const requestGetProfileApi = mHttp + '/profile';
//GetSlide
const requestGetSlideApi = mHttp + '/get_slides';
//GetSubscription
const requestGetSubscriptionApi = mHttp + '/get_subscriptions';
//GetPayment
const requestGetPaymentApi = mHttp + '/get_payments';
//CheckDiscount
const requestCheckDiscountApi = mHttp + '/check_discount';
//Use Coupon
const requestUseCouponApi = mHttp + '/use_coupon';
//userSubscribe
const requestUserSubscribeApi = mHttp + '/user_subscribe';
//getSubscrib for IsPremium or NonPremium
const requestGetSubscribeApi = mHttp + '/getsubscribe';
//getDeviceList
const requestGetDeviceListApi = mHttp + '/device_list';
//getDeviceOtp
const requestGetDeviceOTPApi = mHttp + '/device_otp';
//deviceRemove
const requestDeviceRemoveApi = mHttp + '/device_remove';
//Terms && Conditions
const requestTermAndConditionApi = mHttp + '/term_conditions';
//AboutUs
const requestAboutUsApi = mHttp + '/about';
//privacy_policy
const requestPrivacyPolicyApi = mHttp + '/privacy_policy';
//notification
const requestNotificationApi = mHttp + '/notiList';
//feedback
const requestSendFeedbackApi = mHttp + '/recommends';
//chat lists
const requestChatListApi = mHttp + '/userlists';
//user lists
const requestUserListApi = mHttp + '/customer_lists';
//chat message lists
const requestChatMessageListApi = mHttp + '/messages';
//create group
const requestCreateGroupApi = mHttp + '/create_group';
//group member list
const requestGroupMemberApi = mHttp + '/memberlists';
//group user lists
const requestGroupUserListApi = mHttp + '/add_member';
//delete group
const requestDeleteGroupApi = mHttp + '/delete_group';
//leave group
const requestLeaveGroupApi = mHttp + '/leave_group';
//mute group
const requestMuteGroupApi = mHttp + '/mute_group';
//block user
const requestBlockUserApi = mHttp + '/user_block';
//unblock user
const requestUnblockUserApi = mHttp + '/user_unblock';
//mute user
const requestMuteUserApi = mHttp + '/user_mute';
//send noti
const requestSendNotiApi = mHttp + '/send-notification';
//block user list
const requestBlockUserListApi = mHttp + '/block_userlists';
//save contacts
const requestSaveContactsApi = mHttp + '/contact_lists';
//search user
const requestSearchUserApi = mHttp + '/search_user';
//change password
const requestChangePasswordApi = mHttp + '/changePassword';
//change phone
const requestChangePhoneApi = mHttp + '/change_phone';
//change phone verify
const requestChangePhoneVerifyApi = mHttp + '/changeph_otpverified';
//change email
const requestChangeEmailApi = mHttp + '/email/verification-notification';
//change email verify
const requestChangeEmailVerifyApi = mHttp + '/email/codeVerified';
//group add member
const requestGroupAddMembersApi = mHttp + '/add_groupmember';
//Chat file upload
const requestChatFileUploadApi = mHttp + '/chat/upload';

/**
******************************************* Bank **************************************************************
 **/

//CB Request Payment
const CBRequestPaymentApi =
    'https://cbpayuat.cbbank.com.mm:4443/orderpayment-api/v1/request-payment-order.service';
//CB PinVerification
const CBPinVerifyApi =
    'https://cbpayuat.cbbank.com.mm:4443/orderpayment-api/v1/checkstatus-webpayment.service';

//AYA
const AyaURL = 'https://opensandbox.ayainnovation.com';

const AyaRequestTokenApi = AyaURL + '/token?grant_type=client_credentials';

const AyaLoginApi = AyaURL + '/om/1.0.0/thirdparty/merchant/login';

const AyaRequestPaymentApi =
    AyaURL + '/om/1.0.0/thirdparty/merchant/requestPushPayment';

const AyaRefundPaymentApi =
    AyaURL + '/om/1.0.0/thirdparty/merchant/refundPayment';
