import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lang/en_us.dart';
import '../lang/mm_uni.dart';

class AppTranslations extends Translations {
  // Default locale
  static const locale = Locale('mm', 'Uni');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Myanmar',
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'mm_Uni': mmUni,
      };
}
