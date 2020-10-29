import 'package:firebase_login/widgets/buttons/send_reset_password_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/password_textformfield.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatelessWidget {
  double targetHeight;
  double targetWidth;

  Widget _appBar() {
    return Container(
      width: targetWidth,
      child: Center(
        child: Text(
          'Reset your password',
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
          EmailTextFormField(),
          Container(
            height: targetHeight / 16,
            width: targetWidth / 1.2,
            child: GenericRoundedButtonDecoration(
              buttonColor: Colors.blue,
              splashColor: Colors.blue[100],
              disabledColor: Colors.grey,
              child: SendResetPasswordButton(),
            ),
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
        child: targetWidth > 830.0
            ? Container(
                width: targetWidth > 1920.0
                    ? targetWidth / 5.2
                    : targetWidth / 3.2,
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
              )
            : Container(
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
