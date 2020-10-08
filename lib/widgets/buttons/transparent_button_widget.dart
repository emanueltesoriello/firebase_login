import 'package:flutter/material.dart';

class TransparentButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final VoidCallback onPressed;
  final Color buttonColor;

  const TransparentButtonWidget({
    Key key,
    this.buttonText,
    this.textColor = Colors.white,
    this.buttonColor = Colors.transparent,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: buttonColor,
      child: Container(
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
