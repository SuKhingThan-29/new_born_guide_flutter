import 'package:chitmaymay/controller/language_controller.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguateChangeWidget extends StatefulWidget {
  const LanguateChangeWidget({Key? key}) : super(key: key);

  @override
  State<LanguateChangeWidget> createState() => _LanguateChangeWidgetState();
}

class _LanguateChangeWidgetState extends State<LanguateChangeWidget> {
  final LanguageController _controller = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'english'.tr,
            textStyle: (_controller.isMyanmarLang.value == true)
                ? kTextStyleGrey(12)
                : kTextStyleError(12),
          ),
          Switch(
            value: _controller.isMyanmarLang.value,
            onChanged: (value) {
              _controller.updateLanguage();
            },
            activeTrackColor: cl1_box_color,
            activeColor: Colors.white,
          ),
          CustomText(
            text: 'myanmar'.tr,
            textStyle: (_controller.isMyanmarLang.value == true)
                ? kTextStyleError(12)
                : kTextStyleGrey(12),
          )
        ],
      );
    });
  }
}
