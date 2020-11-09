import 'package:firebase_login/widgets/dialogs/reset_pwd_dialog.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatefulWidget {
  final String text;
  final String popupImageAsset;
  final Radius buttonBorderRadius;
  final Color buttonColor;
  final Color buttonSplashColor;
  final Color buttonDisabledColor;
  ForgotPasswordButton({
    @required this.text,
    @required this.popupImageAsset,
    @required this.buttonBorderRadius,
    @required this.buttonColor,
    @required this.buttonDisabledColor,
    @required this.buttonSplashColor,
  });
  @override
  _ForgotPasswordButtonState createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(
          widget.text,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(decoration: TextDecoration.underline),
        ),
        onPressed: () async {
          showDialog(
              context: context,
              child: ResetPasswordDialog(
                buttonBorderRadius: widget.buttonBorderRadius,
                imageAsset: widget.popupImageAsset,
                buttonColor: widget.buttonColor,
                buttonDisabledColor: widget.buttonDisabledColor,
                buttonSplashColor: widget.buttonSplashColor,
              ));
        },
      ),
    );
  }
}
