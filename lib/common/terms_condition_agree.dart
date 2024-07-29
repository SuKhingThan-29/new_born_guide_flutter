import 'package:chitmaymay/common/terms_and_condition_widget.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';


class TermsAndConditionAgree extends StatelessWidget {
  final bool isCheck;
  final ValueChanged onChanged;
  const TermsAndConditionAgree(
      {Key? key, required this.isCheck, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isCheck,
          onChanged: onChanged,
          checkColor: whiteColor,
          activeColor: backgroundDarkPurple,
        ),
        TermsAndConditionWidget()
      ],
    );
  }
}
