import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/widgets/custom_text.dart';

class PrivacySecurityItem extends StatelessWidget {
  final String title;
  final String data;
  final VoidCallback onTap;
  final bool? topBorder;
  const PrivacySecurityItem(
      {Key? key,
      required this.title,
      required this.data,
      required this.onTap,
      this.topBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: const BorderSide(width: 1, color: borderLineColor),
              top: BorderSide(
                  width: 1,
                  color: (topBorder ?? false) ? borderLineColor : whiteColor)),
          color: Colors.white,
        ),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kHorizontalSpace(15),
            CustomText(text: title, textStyle: kTextStyleBlack(14)),
            const Spacer(),
            CustomText(text: data, textStyle: kTextStyleGrey(14)),
            kHorizontalSpace(10),
            const Icon(
              Icons.arrow_forward_ios,
              color: greyColor,
              size: 15,
            ),
            kHorizontalSpace(15)
          ],
        ),
      ),
    );
  }
}
