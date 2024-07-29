import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/common/custom_ads.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/widgets/custom_text.dart';

class Apperance extends StatefulWidget {
  const Apperance({Key? key}) : super(key: key);

  @override
  _Apperance createState() => _Apperance();
}

class _Apperance extends State<Apperance> {
  final ComWidgets _comWidgets = ComWidgets();
  late double _currentSliderValue = 12;
  bool isClassic1Tap = true;
  bool isClassic2Tap = false;
  bool isClassic3Tap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(
          title: 'appearance'.tr,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          width: 1,
                          color: borderLineColor,
                        )),
                        color: Colors.white),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, top: 20, bottom: 10),
                            child: CustomText(
                                text: 'Repair', textStyle: kTextStyleGrey(14)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isClassic1Tap = true;
                                    isClassic2Tap = false;
                                    isClassic3Tap = false;
                                    ConstantUtils.isClassic1 = true;
                                  });
                                },
                                child: _comWidgets.apperanceWidget(
                                    'Classic 1',
                                    cl1_background_grey,
                                    Colors.white,
                                    cl1_box2,
                                    isClassic1Tap),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isClassic1Tap = false;
                                    isClassic2Tap = true;
                                    isClassic3Tap = false;
                                    ConstantUtils.isClassic2 = true;
                                  });
                                },
                                child: _comWidgets.apperanceWidget(
                                    'Classic 2',
                                    cl2_background_color,
                                    cl2_box1,
                                    cl2_box2,
                                    isClassic2Tap),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isClassic1Tap = false;
                                    isClassic2Tap = false;
                                    isClassic3Tap = true;
                                    ConstantUtils.isDarkMode = true;
                                  });
                                },
                                child: _comWidgets.apperanceWidget(
                                    'Dark',
                                    Colors.black,
                                    Colors.grey,
                                    cl1_dark_purple,
                                    isClassic3Tap),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: borderLineColor),
                          top: BorderSide(width: 1, color: backgroundColor)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 25, top: 10),
                            child: CustomText(
                              text: 'Font Size'.tr,
                              textStyle: kTextStyleGrey(_currentSliderValue),
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1, color: cl1_dark_purple),
                              top: BorderSide(width: 1, color: cl1_dark_purple),
                              right:
                                  BorderSide(width: 1, color: cl1_dark_purple),
                              left:
                                  BorderSide(width: 1, color: cl1_dark_purple),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: 'A', textStyle: kTextStyleBoldColor(8)),
                              Slider(
                                inactiveColor: borderLineColor,
                                activeColor: cl1_dark_purple,
                                value: _currentSliderValue,
                                min: 12,
                                max: 20,
                                divisions: 3,
                                label: _currentSliderValue.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                              CustomText(
                                  text: 'A',
                                  textStyle: kTextStyleBoldColor(24)),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomAds(
                height: 50,
                myBanner: 'myBanner',
              ),
            )
          ],
        ));
  }
}
