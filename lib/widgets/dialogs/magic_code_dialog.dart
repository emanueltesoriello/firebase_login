import 'package:firebase_login/constants/colors.dart';
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
      margin: EdgeInsets.only(top: targetHeight / 40, left: 10, right: 10),
      child: Column(
        children: [
          Text(
            'Insert your Magic Code',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: targetHeight / 41, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Thanks to this magic code you will be able to access into your Company!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: targetWidth / 25,
          right: targetWidth / 25,
          bottom: targetHeight / 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MagicCodeTextFormField(),
          SizedBox(height: targetHeight / 20),
          GenericRoundedButtonDecoration(
            buttonColor: CustomColors.primaryColor,
            splashColor: CustomColors.backGroundColor,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _appBar(),
              _body(context),
            ],
          ),
        ),
      ),
    );
  }
}
