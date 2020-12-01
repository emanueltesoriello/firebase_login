import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Center(
          child: Text(
            buttonText,
            style:
                Theme.of(context).textTheme.button.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
