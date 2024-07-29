import 'package:chitmaymay/screen/home/nav/bmi_calculation/calculator_brain.dart';
import 'package:chitmaymay/screen/home/nav/bmi_calculation/resultPage.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_edittext.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum Gender { male, female }

class BMICalculation extends StatefulWidget {
  const BMICalculation({Key? key}) : super(key: key);

  @override
  _BMICalculationState createState() => _BMICalculationState();
}

class _BMICalculationState extends State<BMICalculation> {
  late Gender selectedGender = Gender.female;
  final ageController = TextEditingController();
  final feetController = TextEditingController();
  final inchesController = TextEditingController();
  final weightController = TextEditingController();

  late CalculatorBrain cal;
  bool isCalculate = false;

  @override
  void initState() {
    super.initState();
    ConstantUtils.sendFirebaseAnalyticsEvent(bmiScreen);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: CustomText(
            text: 'bmi_calculation'.tr,
            textStyle: kTextStyleBlack(16),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              height: height * 0.3,
              child: SvgPicture.asset('assets/icon/${'BMI myanmar.svg'}'),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(width: 1, color: cl1_dark_purple),
                  borderRadius: BorderRadius.circular(15)),
              child: (Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                            text: 'age'.tr, textStyle: kTextStyleBlack(14)),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CustomEditText(
                              controller: ageController,
                            ),
                            CustomText(
                                text: 'year'.tr,
                                textStyle: kTextStyleColor(12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kVerticalSpace(8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                            text: 'gender'.tr, textStyle: kTextStyleBlack(14)),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender = Gender.male;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: borderLineColor),
                                      color: selectedGender == Gender.male
                                          ? cl1_dark_purple
                                          : Colors.white),
                                )),
                            CustomText(
                                text: 'male'.tr,
                                textStyle: kTextStyleColor(12)),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender = Gender.female;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: borderLineColor),
                                      color: selectedGender == Gender.female
                                          ? cl1_dark_purple
                                          : Colors.white),
                                )),
                            CustomText(
                                text: 'female'.tr,
                                textStyle: kTextStyleColor(12)),
                          ],
                        ),
                      )
                    ],
                  ),
                  kVerticalSpace(8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                            text: 'height'.tr, textStyle: kTextStyleBlack(14)),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CustomEditText(
                              controller: feetController,
                            ),
                            CustomText(
                                text: 'feet'.tr,
                                textStyle: kTextStyleColor(12)),
                            CustomEditText(
                              controller: inchesController,
                            ),
                            CustomText(
                                text: 'inches'.tr,
                                textStyle: kTextStyleColor(12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kVerticalSpace(8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                            text: 'weight'.tr, textStyle: kTextStyleBlack(14)),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CustomEditText(
                              controller: weightController,
                            ),
                            CustomText(
                                text: 'pound'.tr,
                                textStyle: kTextStyleColor(12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kVerticalSpace(20),
                  CustomButton(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        int height = 0;
                        int weight = 0;
                        if (ageController.text.isNotEmpty &&
                            feetController.text.isNotEmpty &&
                            inchesController.text.isNotEmpty &&
                            weightController.text.isNotEmpty) {
                          height = (12 * int.parse(feetController.text)) +
                              int.parse(inchesController.text);
                          weight = int.parse(weightController.text);
                          cal = CalculatorBrain(
                              height: height,
                              weight: weight,
                              image: 'assets/bmi_icon/right.svg',
                              color: normalWeightColor);
                          isCalculate = true;
                        } else {
                          showToast('Please fill all fields');
                        }
                      });
                    },
                    backgroundColor: deepPurple,
                    label: 'calculate'.tr,
                  ),
                ],
              )),
            ),
            isCalculate
                ? ResultPage(
                    bmiResult: cal.calculateBMI(),
                    resultText: cal.getResult(),
                    interpretation: cal.getInterpretation(),
                    image: cal.image,
                    color: cal.color)
                : Container()
          ]),
        ));
  }
}
