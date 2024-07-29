import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> data;
  final Function(String?) onSelect;
  final String initialValue;
  const CustomDropDown(
      {Key? key,
      required this.data,
      required this.onSelect,
      required this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderLineColor)),
        child: DropdownButton(
          underline: const SizedBox(),
          value: initialValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 25,
          ),
          items: data.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  width: 70,
                  child: Text(
                    items,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ));
          }).toList(),
          onChanged: onSelect,
        ),
      ),
    );
  }
}
