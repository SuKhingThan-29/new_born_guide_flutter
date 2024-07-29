import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

class RoundedCornerButton extends StatelessWidget {
  const RoundedCornerButton(
      {Key? key, required this.onPressed, required this.buttonTitle})
      : super(key: key);
  final VoidCallback onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundDarkPurple, // background color
          foregroundColor: Colors.white, // text color
          shape:
              StadiumBorder(side: BorderSide(color: cl1_dark_purple, width: 0)),
        ),
        child: Text(buttonTitle),
      ),
    );
  }
}
