import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LaunchScreenButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final TextStyle? textStyle;
  final Widget? widget;
  final Color? backgroundColor;
  const LaunchScreenButton(
      {Key? key,
      required this.label,
      this.textStyle,
      required this.onTap,
      this.widget,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  backgroundColor ?? whiteColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),
          onPressed: onTap,
          child: widget != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget ?? Container(),
                    const Spacer(),
                    CustomText(
                        text: label,
                        textStyle: textStyle ?? kTextStyleColor(14)),
                    const Spacer(),
                  ],
                )
              : CustomText(
                  text: label, textStyle: textStyle ?? kTextStyleColor(14))),
    );
  }
}
