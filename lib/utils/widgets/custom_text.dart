import 'package:flutter/material.dart';
import 'package:flutter_mdetect/flutter_mdetect.dart';
import 'package:rabbitx_converter/rabbitx_converter.dart';

class CustomText extends StatelessWidget {
  final TextStyle textStyle;
  final String text;
  final bool? isAlignCenter;
  final int? maxLines;
  const CustomText(
      {Key? key,
      required this.text,
      required this.textStyle,
      this.isAlignCenter,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      MDetect.isUnicode() ? text : RabbitxConverter.uni2zg(text),
      maxLines: maxLines,
      style: textStyle,
      textAlign: (isAlignCenter ?? false) ? TextAlign.center : null,
    );
  }
}
