import 'dart:math';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorBrain {
  final int height;
  final int weight;
  String image;
  Color color;

  CalculatorBrain(
      {required this.height,
      required this.weight,
      required this.image,
      required this.color});

  double _bmi = 0.0;

  String calculateBMI() {
    _bmi = (weight / pow(height, 2)) * 703;
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25 && _bmi <= 29.9) {
      image = 'assets/bmi_icon/cross.svg';
      color = overWeightColor;
      return 'ပုံမှန်ထက်များနေသည်';
    } else if (_bmi > 18.5 && _bmi <= 24) {
      image = 'assets/bmi_icon/right.svg';
      color = normalWeightColor;
      return 'ပုံမှန်ဖြစ်သည်';
    } else if (_bmi > 30) {
      image = 'assets/bmi_icon/cross.svg';
      color = obesityColor;
      return 'အ၀လွန်နေသည်';
    } else {
      image = 'assets/bmi_icon/minus.svg';
      color = underWeightColor;
      return 'ပုံမှန်အောက်လျော့နေသည်';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25 && _bmi <= 29.9) {
      return 'overWeightText'.tr;
    } else if (_bmi > 18.5 && _bmi <= 24) {
      return 'normalWeightText'.tr;
    } else if (_bmi > 30) {
      return 'ovesityWeightText'.tr;
    } else {
      return'underWeightText'.tr;
    }
  }
}
