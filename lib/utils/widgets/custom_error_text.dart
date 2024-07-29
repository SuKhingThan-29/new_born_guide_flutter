import 'package:chitmaymay/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomErrorText extends StatelessWidget {
  final String label;
  const CustomErrorText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(label, style: kTextStyleError(12)),
    );
  }
}
