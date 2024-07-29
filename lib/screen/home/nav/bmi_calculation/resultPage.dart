
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;
  final String image;
  final Color color;
  const ResultPage(
      {Key? key,
      required this.bmiResult,
      required this.resultText,
      required this.interpretation,
      required this.image,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BMI = $bmiResult',
                style: kTextStyleWhite(18),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 40,
                height: 40,
                child: SvgPicture.asset(image),
              ),
              CustomText(
                text: resultText,
                textStyle: kTextStyleWhite(12),
              )
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.all(15),
            child: CustomText(
              text: interpretation,
              textStyle: kTextStyleBlack(14),
            ))
      ],
    );
  }
}
