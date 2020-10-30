import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/widgets/decorations/text_default_bold.dart';
import 'package:flutter/material.dart';

class CircleAvatarText extends StatelessWidget {
  final String text;
  final Color color;

  CircleAvatarText({this.text, this.color = CustomColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: TextDefaultBold(text: text, color: Colors.white),
      ),
    );
  }
}
