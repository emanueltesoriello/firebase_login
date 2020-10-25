import 'package:firebase_login/widgets/buttons/send_magic_code_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/textfields/magic_code_textformfield.dart';
import 'package:flutter/material.dart';

class MagicCodeDialog extends StatelessWidget {
  double targetHeight;
  double targetWidth;

  Widget _appBar() {
    return Container(
      width: targetWidth,
      child: Center(
        child: Text(
          'Insert your Magic Code',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: targetHeight / 40,
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: targetWidth / 25, right: targetWidth / 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MagicCodeTextFormField(),
          GenericRoundedButtonDecoration(
            buttonColor: Colors.blue,
            splashColor: Colors.blue[100],
            disabledColor: Colors.grey,
            child: SendMagicCodeButton(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    targetHeight = MediaQuery.of(context).size.height;
    targetWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Form(
        child: Container(
          height: targetHeight / 2.6,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(flex: 18, child: _appBar()),
              Expanded(
                flex: 40,
                child: _body(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
