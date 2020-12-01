import 'package:flutter/material.dart';

class GenericRoundedButtonDecoration extends StatelessWidget {
  @required
  final Radius borderRadius;
  final Widget child;
  final Color borderColor;
  final Color buttonColor;
  final Color splashColor;
  final Color disabledColor;

  GenericRoundedButtonDecoration({
    this.child,
    this.borderRadius = const Radius.circular(90),
    this.borderColor = Colors.transparent,
    this.buttonColor = Colors.green,
    this.disabledColor = Colors.grey,
    this.splashColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: buttonColor,
      child: Center(
        child: child,
      ),
      disabledColor: disabledColor,
      splashColor: splashColor,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 2),
        borderRadius: BorderRadius.all(borderRadius),
      ),
    );
  }
}
