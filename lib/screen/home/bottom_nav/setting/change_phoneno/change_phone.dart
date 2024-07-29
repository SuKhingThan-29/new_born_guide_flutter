import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/style.dart';
import '../../../../../utils/widgets/custom_alertdialog.dart';
import '../../../../../utils/widgets/custom_button.dart';
import '../../../../../utils/widgets/custom_text.dart';

class ChangePhone extends StatelessWidget {
  final SettingController controller;
  ChangePhone({Key? key, required this.controller}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blackColor,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'change_phoneno'.tr,
          textStyle: kTextStyleBlack(16),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CustomText(
            text: 'new_no'.tr,
            textStyle: kTextStyleGrey(14),
          ),
        ),
        kVerticalSpace(8),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: borderLineColor),
                  bottom: BorderSide(width: 1, color: borderLineColor)),
              color: whiteColor),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Myanmar(Burma)',
              textStyle: TextStyle(fontSize: 14, color: blackColor),
            ),
          ),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: borderLineColor)),
              color: whiteColor),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const CustomText(
                  text: '+95',
                  textStyle: TextStyle(fontSize: 14, color: blackColor),
                ),
                kHorizontalSpace(12),
                Container(
                  width: 1,
                  color: borderLineColor,
                ),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    style: kTextStyleBlack(14),
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      filled: true,
                      fillColor: whiteColor,
                      contentPadding: EdgeInsets.all(15),
                      hintText: '',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        kVerticalSpace(4),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CustomText(
              text: 'change_no_text'.tr, textStyle: kTextStyleGrey(12)),
        ),
        kVerticalSpace(30),
        Center(
            child: CustomButton(
                label: 'save'.tr,
                onTap: () {
                  if (phoneController.text.isNotEmpty) {
                    if (!phoneController.text.startsWith('+95')) {
                      phoneController.text = '+95' + phoneController.text;
                    }
                    controller.updatePhone(phoneController.text);
                  } else {
                    showAlertDialog(
                        context, 'Error', 'Please fill all the fields!', 'OK',
                        () {
                      Navigator.pop(context);
                    });
                  }
                }))
      ]),
    );
  }
}
