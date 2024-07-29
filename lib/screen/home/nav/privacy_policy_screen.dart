import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../controller/language_controller.dart';
import '../../../utils/widgets/custom_loading.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final SettingController controller;
  PrivacyPolicyScreen({Key? key,required this.controller}) : super(key: key);
  final LanguageController _langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchPrivacyPolicy();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'privacy_policy'.tr),
      body: Obx(
        () {
          return controller.privacyLoading.value
              ? const Center(
                  child: CustomLoading(),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  child: Html(
                    data: _langController.isMyanmarLang.value
                        ? controller.privacyPolicy.value.titleMM
                        : controller.privacyPolicy.value.titleEng,
                  ),
                );
        },
      ),
    );
  }
}
