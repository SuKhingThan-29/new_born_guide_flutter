import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

class CustomSwitchButton extends StatelessWidget {
  final bool value;
  final Function(bool) onChange;
  const CustomSwitchButton(
      {Key? key, required this.value, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChange,
      activeTrackColor: titlePurpleColor,
      activeColor: Colors.white,
    );
  }
}
