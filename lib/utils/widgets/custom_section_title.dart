import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CustomSectionTitle extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Widget? widget;
  final bool? bottomBorder;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;
  final bool? topBorder;
  final bool? noBorder;
  const CustomSectionTitle(
      {Key? key,
      required this.onTap,
      required this.title,
      this.widget,
      this.backgroundColor,
      this.iconColor,
      this.titleColor,
      this.topBorder,
      this.noBorder,
      this.bottomBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            border: (noBorder ?? false)
                ? null
                : Border(
                    top: BorderSide(
                        width: 1,
                        color: (topBorder ?? false)
                            ? borderLineColor
                            : whiteColor),
                    bottom: BorderSide(
                        width: 1,
                        color: (bottomBorder ?? false)
                            ? borderLineColor
                            : whiteColor)),
            color: backgroundColor ?? whiteColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              textStyle:
                  TextStyle(fontSize: 14, color: titleColor ?? blackColor),
            ),
            (widget != null)
                ? widget ?? Container()
                : Icon(
                    Icons.arrow_forward_ios,
                    color: iconColor ?? arrowForwardColor,
                    size: 20,
                  )
          ],
        ),
      ),
    );
  }
}
