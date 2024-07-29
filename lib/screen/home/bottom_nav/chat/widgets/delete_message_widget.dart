import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DeleteMessageWidget extends StatelessWidget {
  final bool isOther;
  final String name;
  const DeleteMessageWidget({Key? key, required this.isOther,required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isOther ? Container() : const Spacer(),
        Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
              color: borderLineColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(children: [
            const Icon(
              Icons.delete,
              color: greyColor,
            ),
            CustomText(
                text: '$name deleted a message', textStyle: kTextStyleGrey(12)),
          ]),
        ),
        kHorizontalSpace(8),
        isOther ? const Spacer() : Container(),
      ],
    );
  }
}
