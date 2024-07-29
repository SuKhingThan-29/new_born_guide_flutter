import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class IOSTextFieldNumber extends StatelessWidget{
  final FocusNode _nodeText1 = FocusNode();
  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),

      ],
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: KeyboardActions(
          config: _buildConfig(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    focusNode: _nodeText1,
                    decoration: const InputDecoration(
                      hintText: "Input Number",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}