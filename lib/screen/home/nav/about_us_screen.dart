import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../controller/language_controller.dart';
import '../../../controller/setting_controller.dart';

class AboutUs extends StatelessWidget {
  final SettingController controller;
  AboutUs({Key? key, required this.controller}) : super(key: key);
  final LanguageController _langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchAboutUs();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'about_chitmaymay'.tr),
      body: Obx(
        () {
          return controller.aboutUsLoading.value
              ? const Center(
                  child: CustomLoading(),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  child: Html(
                    data: _langController.isMyanmarLang.value
                        ? controller.aboutUs.value.aboutMM
                        : controller.aboutUs.value.aboutEng,
                  ),
                );
        },
      ),
    );
  }
}
