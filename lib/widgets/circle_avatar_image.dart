import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/widgets/circle_avatar_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CircleAvatarImage extends StatelessWidget {
  final String imageURL;
  final String text;
  final Color color;

  CircleAvatarImage({
    this.imageURL,
    this.text,
    this.color = CustomColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: imageURL != null
          ? Container(
              color: color,
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.contain,
                placeholder: kTransparentImage,
                image: imageURL,
              ),
            )
          : CircleAvatarText(
              text: text,
              color: color,
            ),
    );
  }
}
