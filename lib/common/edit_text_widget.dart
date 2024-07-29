import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTextWidget extends StatelessWidget{
  TextEditingController mController;
  TextInputType mTextInputType;
  Color mColor;
  String mHintText;
  String name;
  Function(String)? onChanged;
  String errorText;
  bool isPasswordSecure;

  EditTextWidget({required this.mController,required this.mTextInputType,required this.isPasswordSecure,required this.mColor,required this.mHintText,required this.name,required this.errorText,required this.onChanged});

  @override
  Widget build(BuildContext context){
    return FractionallySizedBox(
      widthFactor: 1.0,
      child:Center(
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s'))
          ],
          obscureText: isPasswordSecure,
         keyboardType: mTextInputType,
          controller: mController,
          onChanged: onChanged,
          decoration: InputDecoration(
              errorText: errorText.isNotEmpty?errorText:null,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mColor,width: 3.0),
                  borderRadius: BorderRadius.circular(35)
              ),
              filled: true,
              fillColor: mColor,
              hintText: name=='Phoneno'?'+95':mHintText,
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: mColor, width: 3.0),
                  borderRadius: BorderRadius.circular(35)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 3, color: mColor),
                  borderRadius: BorderRadius.circular(35))
          ),

        ),
      ),
    );
    }
}