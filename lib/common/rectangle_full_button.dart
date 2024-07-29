import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RectangleFullButton extends StatelessWidget {
  const RectangleFullButton(
      {Key? key, required this.onPressed, required this.buttonTitle})
      : super(key: key);
  final VoidCallback onPressed;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.all(10),
          width: 140,
          height: 45,
          decoration: BoxDecoration(
            color: cl1_dark_purple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: CustomText(
              text:buttonTitle,
              textStyle: kTextStyleWhite(14),
            ),
          )),
    );
  }
}
