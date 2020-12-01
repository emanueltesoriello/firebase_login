import 'package:firebase_login/widgets/buttons/send_new_email.dart';
import 'package:firebase_login/widgets/buttons/send_reset_password_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/password_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ChangeEmailDialog extends StatelessWidget {
  double targetHeight;
  double targetWidth;
  Radius buttonBorderRadius;
  final Color buttonColor;
  final Color buttonSplashColor;
  final Color buttonDisabledColor;
  final InputDecoration textFormFieldDecoration;

  final String imageAsset;
  ChangeEmailDialog({
    @required this.imageAsset,
    @required this.buttonBorderRadius,
    @required this.buttonColor,
    @required this.buttonDisabledColor,
    @required this.buttonSplashColor,
    @required this.textFormFieldDecoration,
  });

  Widget _appBar() {
    return Container(
      width: targetWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: targetWidth / 1.2,
              padding: EdgeInsets.all(targetHeight / 40),
              child: Image.asset(imageAsset),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              'Change your email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: targetHeight / 40,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
            child: Text(
              'To change your email, please insert your current password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: targetHeight / 55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: targetWidth / 25, right: targetWidth / 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          PasswordTextFormField(
            decoration: textFormFieldDecoration,
          ),
          Container(
            height: targetHeight / 16,
            width: targetWidth / 1.2,
            child: GenericRoundedButtonDecoration(
              borderRadius: buttonBorderRadius,
              buttonColor: buttonColor,
              splashColor: buttonSplashColor,
              disabledColor: buttonDisabledColor,
              child: SendNewEmailButton(),
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
                height: targetHeight / 2.2,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(flex: 35, child: _appBar()),
                    Expanded(
                      flex: 30,
                      child: _body(context),
                    ),
                  ],
                ),
              )
            : Container(
                height: targetHeight / 2.2,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(flex: 35, child: _appBar()),
                    Expanded(
                      flex: 30,
                      child: _body(context),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
