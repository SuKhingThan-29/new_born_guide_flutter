import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading extends StatelessWidget {
  final double? size;
  final Color? color;
  const CustomLoading({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: color ?? backgroundDarkPurple,
      size: size ?? 50.0,
    );
  }
}
