import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class MoreItemWidget extends StatelessWidget {
  final String title;
  const MoreItemWidget({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: 229,
      height: height * 0.33,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 7,
        shadowColor: blackColor,
        child: Center(
          child: CustomText(
            text: title,
            textStyle: kTextStyleColor(16),
          ),
        ),
      ),
    );
  }
}
