import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CustomLoadingButton extends StatelessWidget {
  final Color? color;
  const CustomLoadingButton({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(color ?? backgroundDarkPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)))),
        onPressed: null,
        child: const CustomLoading(
          size: 25,
          color: whiteColor,
        ));
  }
}
