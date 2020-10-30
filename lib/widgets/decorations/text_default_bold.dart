import 'package:flutter/material.dart';

class TextDefaultBold extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double fontHeight;

  TextDefaultBold(
      {this.text,
      this.color = Colors.black,
      this.textAlign = TextAlign.left,
      this.fontWeight = FontWeight.bold,
      this.fontHeight = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: this.textAlign,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.017, //16.0,
        color: color,
        fontWeight: fontWeight,
        height: fontHeight,
      ),
    );
  }
}
