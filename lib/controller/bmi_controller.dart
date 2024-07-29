import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BMIController extends GetxController{
  final ageController=TextEditingController();
  final feetController=TextEditingController();
  final inchesController=TextEditingController();
  final weightController=TextEditingController();
  late bool isMale=false;
  late bool isFemale=true;
  late String female='true';
  @override
  void onInit(){
    super.onInit();
  }
}