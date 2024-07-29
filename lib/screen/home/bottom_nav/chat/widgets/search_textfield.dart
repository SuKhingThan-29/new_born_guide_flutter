import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChange;
  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 45,
      child: TextField(
        controller: controller,
        style: kTextStyleBlack(14),
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChange,
        decoration: InputDecoration(
            filled: true,
            fillColor: lightGrey,
            contentPadding: const EdgeInsets.all(14),
            prefixIcon: const Icon(
              Icons.search,
              color: greyColor,
            ),
            hintText: 'search'.tr,
            border: InputBorder.none,
            enabledBorder: _borders(),
            focusedBorder: _borders(),
            disabledBorder: _borders()),
      ),
    );
  }

  _borders() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(width: 1, color: lightGrey));
  }
}
