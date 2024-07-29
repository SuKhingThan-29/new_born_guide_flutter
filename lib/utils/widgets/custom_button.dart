import 'package:flutter/material.dart';

import '../constants.dart';
import '../style.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final TextStyle? textStyle;
  final Widget? widget;
  final Color? backgroundColor;
  const CustomButton(
      {Key? key,
      required this.label,
      this.textStyle,
      required this.onTap,
      this.widget,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                backgroundColor ?? backgroundDarkPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)))),
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomText(
              text: label, textStyle: textStyle ?? kTextStyleWhite(14)),
        ));
  }
}
