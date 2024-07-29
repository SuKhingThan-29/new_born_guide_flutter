import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/style.dart';

class LanguageController extends GetxController {
  final isMyanmarLang = false.obs;

  @override
  void onInit() {
    initLocale();
    super.onInit();
  }

  final Map<String, dynamic> optionsLocales = {
    'en': {'languageCode': 'en', 'countryCode': 'US', 'description': 'English'},
    'mm': {'languageCode': 'mm', 'countryCode': 'MM', 'description': 'Myanmar'},
  };

  Future<void> initLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(lang) != null) {
      if (pref.getString(lang) == 'mm') {
        updateLocale("mm");
        isMyanmarLang.value = true;
      } else {
        updateLocale("en");
        isMyanmarLang.value = false;
      }
    } else {
      updateLocale("mm");
      isMyanmarLang.value = true;
    }
  }

  Future<void> updateLanguage() async {
    if (isMyanmarLang.value) {
      updateLocale("en");
      isMyanmarLang.value = false;
    } else {
      updateLocale("mm");
      isMyanmarLang.value = true;
    }
  }

  Future<void> updateLocale(String key) async {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // save
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(lang, key);
  }
}
