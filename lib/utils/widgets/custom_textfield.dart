import 'package:flutter/material.dart';
import '../constants.dart';
import '../style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hintText;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool? isObsecure;
  final bool? isTextArea;
  final bool? isKeyboardTypeNumber;
  final VoidCallback? updateSeen;
  final bool? showSuffixIcon;
  const CustomTextField(
      {Key? key,
      this.controller,
      required this.label,
      required this.hintText,
      this.onTap,
      this.readOnly,
      this.isObsecure,
      this.isTextArea,
      this.isKeyboardTypeNumber,
      this.updateSeen,
      this.showSuffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kTextFieldTitle(label),
        kVerticalSpace(4),
        SizedBox(
          height: 45,
          child: Center(
            child: TextField(
              obscureText: isObsecure ?? false,
              readOnly: readOnly ?? false,
              keyboardType:
                  (isKeyboardTypeNumber ?? false) ? TextInputType.number : null,
              controller: controller,
              maxLines: (isTextArea ?? false) ? 6 : 1,
              style: kTextStyleBlack(14),
              onTap: onTap,
              decoration: InputDecoration(
                  suffixIcon: (showSuffixIcon ?? false)
                      ? IconButton(
                          icon: Icon(
                            (isObsecure ?? false)
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: backgroundDarkPurple,
                          ),
                          onPressed: updateSeen,
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(14),
                  hintText: hintText,
                  hintStyle: kTextStyleGrey(16),
                  border: InputBorder.none,
                  enabledBorder: _borders(),
                  focusedBorder: _focusedBorders(),
                  disabledBorder: _borders()),
            ),
          ),
        ),
      ],
    );
  }

  _focusedBorders() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(width: 1, color: cl1_dark_purple));
  }

  _borders() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(width: 1, color: Colors.white));
  }
}
