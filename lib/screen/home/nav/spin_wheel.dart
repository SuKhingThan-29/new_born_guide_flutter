import 'dart:async';
import 'dart:math';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpinWheel extends StatelessWidget {
  SpinWheel({Key? key}) : super(key: key);
  final StreamController<int> controller = StreamController<int>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Spin'),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
              color: backgroundDarkPurple, shape: BoxShape.circle),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FortuneWheel(
                  animateFirst: false,
                  selected: controller.stream,
                  physics: CircularPanPhysics(
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate,
                  ),
                  onFling: () {
                    var selected = Random().nextInt(12);
                    controller.add(selected + 1);
                  },
                  // indicators: const <FortuneIndicator>[
                  //   FortuneIndicator(
                  //     alignment: Alignment.topCenter,
                  //     child: SizedBox.shrink(),
                  //   ),
                  // ],
                  items: [
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: 'Video နှစ်ခါကြည့်ရှူ့ခွင့်',
                          textStyle: kTextStyleWhite(10),
                        ),
                      ),
                      style: const FortuneItemStyle(
                        color: redColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: 'ဗလာ', textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: orangeColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: '၂ခါလှည့်ခွင့်',
                            textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: spinGreenColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: 'Premium ၃ရင်အသုံးပြုခွင့်',
                            textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: darkBlueColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: 'Video နှစ်ခါကြည့်ရှူ့ခွင့်',
                          textStyle: kTextStyleWhite(10),
                        ),
                      ),
                      style: const FortuneItemStyle(
                        color: redColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: 'ဗလာ', textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: orangeColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: '၂ခါလှည့်ခွင့်',
                            textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: spinGreenColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: 'Premium ၃ရင်အသုံးပြုခွင့်',
                            textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: darkBlueColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: 'Video နှစ်ခါကြည့်ရှူ့ခွင့်',
                          textStyle: kTextStyleWhite(10),
                        ),
                      ),
                      style: const FortuneItemStyle(
                        color: redColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: 'ဗလာ', textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: orangeColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: '၂ခါလှည့်ခွင့်',
                            textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: spinGreenColor,
                      ),
                    ),
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: 'Premium ၃ရင်အသုံးပြုခွင့်',
                            textStyle: kTextStyleWhite(10)),
                      ),
                      style: const FortuneItemStyle(
                        color: darkBlueColor,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      color: whiteColor, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
