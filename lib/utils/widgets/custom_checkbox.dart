import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxTextField extends StatelessWidget {
  final VoidCallback onCheck;
  final bool isCheckFirst;
  final String firstLabel;
  final String secondLabel;
  final String title;
  const CustomCheckBoxTextField(
      {Key? key,
      required this.title,
      required this.onCheck,
      required this.isCheckFirst,
      required this.firstLabel,
      required this.secondLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextStyleBlack(14),
        ),
        kVerticalSpace(8),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: borderLineColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: onCheck,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: borderLineColor),
                      color: isCheckFirst ? checkedColor : whiteColor),
                ),
              ),
              CustomText(
                text: firstLabel,
                textStyle: kTextStyleBlack(14),
              ),
              const Spacer(),
              InkWell(
                onTap: onCheck,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: borderLineColor),
                      color: isCheckFirst ? whiteColor : checkedColor),
                ),
              ),
              Text(
                secondLabel,
                style: kTextStyleBlack(14),
              ),
              const Spacer()
            ],
          ),
        ),
      ],
    );
  }
}
