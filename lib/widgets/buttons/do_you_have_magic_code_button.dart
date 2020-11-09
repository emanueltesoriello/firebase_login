import 'package:firebase_login/widgets/buttons/transparent_button_widget.dart';
import 'package:firebase_login/widgets/dialogs/magic_code_dialog.dart';
import 'package:flutter/material.dart';

class DoYouHaveMagicCodeButton extends StatefulWidget {
  final String buttonText;
  final Radius borderRadius;
  DoYouHaveMagicCodeButton(
      {this.buttonText = 'Use magic code', @required this.borderRadius});
  @override
  _DoYouHaveMagicCodeButtonState createState() =>
      _DoYouHaveMagicCodeButtonState();
}

class _DoYouHaveMagicCodeButtonState extends State<DoYouHaveMagicCodeButton> {
  @override
  Widget build(BuildContext context) {
    return TransparentButtonWidget(
      buttonText: widget.buttonText,
      textColor: Colors.white,
      onPressed: () async {
        showDialog(
            context: context,
            child: MagicCodeDialog(
              borderRadius: widget.borderRadius,
            ));
      },
    );
  }
}
