import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPWidget extends StatefulWidget{
   ValueChanged onChanged;
   ValueChanged onCompleted;
   int otpLength;
  OTPWidget({Key? key, required this.onChanged,required this.onCompleted,required this.otpLength}) : super(key: key);

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  @override
  Widget build(BuildContext context){
    return OTPTextField(
        length: widget.otpLength,
        width: MediaQuery.of(context).size.width/1.7,
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldWidth: 30,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 15,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        onChanged:widget.onChanged,
        onCompleted: widget.onCompleted
    );
  }
}