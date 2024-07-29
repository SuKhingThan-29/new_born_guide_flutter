import 'package:flutter/material.dart';

import '../constants.dart';
import '../style.dart';
import 'custom_button.dart';
import 'custom_text.dart';

showAlertDialog(BuildContext context, String title, String message,
    String btnText, VoidCallback onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        contentPadding: const EdgeInsets.all(15),
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.cancel,
                  color: greyColor,
                ),
              ),
            ),
            kVerticalSpace(8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(text: title, textStyle: kTextStyleError(16)),
                  kVerticalSpace(15),
                  CustomText(
                    text: message,
                    textStyle: kTextStyleBlack(14),
                    isAlignCenter: true,
                  ),
                  kVerticalSpace(15),
                  CustomButton(label: btnText, onTap: onTap)
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
