import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CardWithIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  const CardWithIcon(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Icon(
                icon,
                color: backgroundDarkPurple,
              ),
            ),
            CustomText(
                text: title, textStyle: textStyle ?? kTextStyleBlack(12)),
            kVerticalSpace(8)
          ]),
        ),
      ),
    );
  }
}
