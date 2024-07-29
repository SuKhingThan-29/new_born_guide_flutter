import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

class SendMessageTextField extends StatelessWidget {
  final VoidCallback onSend;
  final TextEditingController controller;
  final VoidCallback pickImage;
  final VoidCallback pickFile;
  const SendMessageTextField(
      {Key? key,
      required this.onSend,
      required this.controller,
      required this.pickFile,
      required this.pickImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: whiteColor,
        child: Row(
          children: [
            IconButton(
                onPressed: pickImage,
                icon: const Icon(
                  Icons.image,
                  color: backgroundDarkPurple,
                  size: 25,
                )),
            // IconButton(
            //     onPressed: pickFile,
            //     icon: const Icon(
            //       Icons.attach_file,
            //       color: backgroundDarkPurple,
            //       size: 20,
            //     )),
            Expanded(
                child: Container(
              margin: const EdgeInsets.all(4),
              height: 45,
              child: TextField(
                controller: controller,
                style: kTextStyleBlack(14),
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                autofocus: false,
                maxLength: 1500,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                    counterText: '',
                    isDense: true,
                    filled: true,
                    fillColor: whiteColor,
                    contentPadding: const EdgeInsets.all(14),
                    hintText: 'Message...',
                    border: InputBorder.none,
                    enabledBorder: _borders(),
                    focusedBorder: _borders(),
                    disabledBorder: _borders()),
              ),
            )),
            IconButton(
                onPressed: onSend,
                icon: const Icon(
                  Icons.send,
                  color: backgroundDarkPurple,
                ))
          ],
        ));
  }

  _borders() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(width: 1, color: lightGrey));
  }
}
