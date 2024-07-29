import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWithTitle extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const AppBarWithTitle(
      {Key? key, required this.onPressed, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset('assets/icon/back_arrow.svg'),
            iconSize: 30,
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          const Spacer(),
          Container(
            width: 30,
          )
        ],
      ),
    );
  }
}
