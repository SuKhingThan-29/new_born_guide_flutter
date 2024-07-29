import 'dart:io';
import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_profile.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/user_image_widget.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/change_email/change_email.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/change_password/change_password.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/change_phoneno/change_phone.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_checkbox.dart';
import 'package:chitmaymay/utils/widgets/custom_dropdown.dart';
import 'package:chitmaymay/utils/widgets/custom_profile_textfield.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/widgets/custom_button.dart';
import '../../../../../utils/widgets/custom_loading_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final _picker = ImagePicker();
  final SettingController _controller = Get.find<SettingController>();
  @override
  void initState() {
    _controller.initProfileData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.disposeProfileData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Obx(() {
            TBLProfile profile = _controller.userProfile.value;
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: borderLineColor))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kVerticalSpace(7),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset('assets/icon/back_arrow.svg'),
                        iconSize: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                width: 80,
                                height: 80,
                                child:
                                    (_controller.urlImageEncode.value.isEmpty)
                                        ? SvgPicture.asset(
                                            'assets/icon/profile.svg')
                                        : UserImageWidget(
                                            imageUrl: _controller
                                                    .userProfile.value.image ??
                                                '',
                                            name: _controller.userProfile.value
                                                    .fullName ??
                                                ''),
                              ),
                              _controller.isPremium.value
                                  ? Positioned(
                                      bottom: 3,
                                      right: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.blue),
                                            color: backgroundColor,
                                            shape: BoxShape.circle),
                                        width: 30,
                                        height: 30,
                                        child: SvgPicture.asset(
                                            'assets/icon/crown.svg'),
                                      ),
                                    )
                                  : Positioned(
                                      bottom: 3, right: 2, child: Container())
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: greyColor,
                          ),
                          onPressed: () {
                            _showPicker(context);
                          },
                        ),
                      ),
                      Center(
                        child: CustomText(
                          text: profile.username ?? "",
                          textStyle: kTextStyleBlack(14),
                        ),
                      ),
                      kVerticalSpace(15),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomProfileTextfield(
                            label: 'full_name'.tr,
                            hintText: '',
                            controller: _controller.fullNameController,
                          ),
                          kVerticalSpace(8),
                          CustomProfileTextfield(
                            label: 'username'.tr,
                            hintText: '',
                            controller: _controller.userNameController,
                          ),
                          kVerticalSpace(8),
                          _controller.userProfile.value.password == ''
                              ? CustomProfileTextfield(
                                  label: 'password'.tr,
                                  hintText: '',
                                  isObsecure: true,
                                  controller: _controller.passwordController,
                                )
                              : CustomProfileTextfield(
                                  readOnly: true,
                                  label: 'password'.tr,
                                  hintText: '',
                                  isObsecure: true,
                                  suffixLabel: 'change_password'.tr,
                                  controller: _controller.passwordController,
                                  onTap: () {
                                    Get.to(ChangePassword(
                                      controller: _controller,
                                    ));
                                  },
                                ),
                          kVerticalSpace(8),
                          _controller.userProfile.value.phoneNo == ''
                              ? CustomProfileTextfield(
                                  label: 'phoneno'.tr,
                                  hintText: '',
                                  controller: _controller.phoneNoController,
                                )
                              : CustomProfileTextfield(
                                  readOnly: true,
                                  label: 'phoneno'.tr,
                                  hintText: '',
                                  suffixLabel: 'change_phoneno'.tr,
                                  controller: _controller.phoneNoController,
                                  onTap: () {
                                    Get.to(ChangePhone(controller: _controller,));
                                  },
                                ),
                          kVerticalSpace(8),
                          _controller.userProfile.value.email == ''
                              ? CustomProfileTextfield(
                                  label: 'email'.tr,
                                  hintText: '',
                                  controller: _controller.emailController,
                                )
                              : CustomProfileTextfield(
                                  readOnly: true,
                                  label: 'email'.tr,
                                  hintText: '',
                                  suffixLabel: 'change_email'.tr,
                                  controller: _controller.emailController,
                                  onTap: () {
                                    Get.to(ChangeEmail(
                                      controller: _controller,
                                    ));
                                  },
                                ),
                          kVerticalSpace(8),
                          CustomCheckBoxTextField(
                              title: 'gender'.tr,
                              onCheck: () {
                                _controller.isMale.value =
                                    !_controller.isMale.value;
                              },
                              isCheckFirst: _controller.isMale.value,
                              firstLabel: 'male'.tr,
                              secondLabel: 'female'.tr),
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 8),
                            child: CustomText(
                              text: 'birth_date'.tr,
                              textStyle: kTextStyleBoldBlack(14),
                            ),
                          ),
                          Row(
                            children: [
                              CustomDropDown(
                                  data: dayList,
                                  onSelect: (selectedValue) {
                                    _controller.dayValue.value =
                                        selectedValue ?? '1';
                                  },
                                  initialValue: _controller.dayValue.value),
                              kHorizontalSpace(10),
                              CustomDropDown(
                                  data: monthList,
                                  onSelect: (selectedValue) {
                                    _controller.monthValue.value =
                                        selectedValue ?? 'January';
                                  },
                                  initialValue: _controller.monthValue.value),
                              kHorizontalSpace(10),
                              CustomDropDown(
                                  data: yearList,
                                  onSelect: (selectedValue) {
                                    _controller.yearValue.value =
                                        selectedValue ?? '1990';
                                  },
                                  initialValue: _controller.yearValue.value),
                            ],
                          ),
                          kVerticalSpace(8),
                          CustomCheckBoxTextField(
                              title: 'parental_status'.tr,
                              onCheck: () {
                                _controller.isParent.value =
                                    !_controller.isParent.value;
                              },
                              isCheckFirst: _controller.isParent.value,
                              firstLabel: 'parents'.tr,
                              secondLabel: 'non_parents'.tr),
                          kVerticalSpace(8),
                          CustomCheckBoxTextField(
                              title: 'pregnancy_status'.tr,
                              onCheck: () {
                                _controller.isPregnent.value =
                                    !_controller.isPregnent.value;
                              },
                              isCheckFirst: _controller.isPregnent.value,
                              firstLabel: 'pregnent'.tr,
                              secondLabel: 'non_pregnent'.tr),
                        ],
                      ),
                    ),
                    kVerticalSpace(20),
                    _controller.profileSaveLoading.value
                        ? const SizedBox(
                            width: 180, child: CustomLoadingButton())
                        : CustomButton(
                            onTap: () {
                              if (_controller.phoneNoController.text.isEmpty) {
                                ConstantUtils.showSnackBar(context,
                                    'Cannot Save Now, Please insert your phone number');
                              } else {
                                _controller.saveProfile(context);
                              }
                            },
                            label: 'save'.tr,
                            textStyle: kTextStyleWhite(14),
                          ),
                    kVerticalSpace(50)
                  ],
                )))
              ],
            );
          }),
        ));
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    final File file = File(image!.path);
    _controller.uploadProfileImage(file);
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    final File file = File(image!.path);
    _controller.uploadProfileImage(file);
  }

  void _showPicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext bc) {
          return CupertinoActionSheet(
            actions: <Widget>[
              Wrap(
                children: <Widget>[
                  CupertinoActionSheetAction(
                    onPressed: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'camera'.tr,
                        style: kTextStyleBlack(12),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'gallery'.tr,
                        style: kTextStyleBlack(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'cancel'.tr,
                  style: kTextStyleBlack(14),
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
          );
        });
  }
}
