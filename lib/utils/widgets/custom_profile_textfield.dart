import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomProfileTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hintText;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool? isObsecure;
  final bool? isTextArea;
  final String? suffixLabel;
  const CustomProfileTextfield(
      {Key? key,
      this.controller,
      required this.label,
      required this.hintText,
      this.onTap,
      this.readOnly,
      this.isObsecure,
      this.isTextArea,
      this.suffixLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kTextStyleBlack(14),
        ),
        kVerticalSpace(8),
        SizedBox(
          height: 45,
          child: Stack(
            children: [
              TextField(
                obscureText: isObsecure ?? false,
                readOnly: readOnly ?? false,
                controller: controller,
                maxLines: (isTextArea ?? false) ? 6 : 1,
                style: kTextStyleBlack(16),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    fillColor: whiteColor,
                    contentPadding: const EdgeInsets.all(14),
                    hintText: hintText,
                    hintStyle: kTextStyleGrey(16),
                    border: InputBorder.none,
                    enabledBorder: _borders(),
                    focusedBorder: _borders(),
                    disabledBorder: _borders()),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CustomText(
                      text: suffixLabel ?? '',
                      textStyle: kTextStyleColor(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _borders() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: borderLineColor));
  }
}
