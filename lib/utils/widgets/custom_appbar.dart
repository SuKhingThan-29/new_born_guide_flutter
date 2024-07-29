import 'package:flutter/material.dart';

import '../constants.dart';
import '../style.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  const CustomAppBar(
      {Key? key, required this.title, this.color, this.textColor})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
          backgroundColor: color ?? backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: title,
            textStyle:
                textColor != null ? kTextStyleWhite(14) : kTextStyleBlack(14),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: textColor ?? blackColor,
            ),
            onPressed: () => Navigator.pop(context),
          )),
    );
  }
}
