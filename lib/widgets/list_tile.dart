import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/widgets/texts/text_default.dart';
import 'package:firebase_login/widgets/texts/text_default.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  @required
  final String title;
  @required
  final String iconPath;
  final String pagePath;
  final Color color;
  final Function func;

  CustomListTile(
      {this.title,
      this.iconPath,
      this.pagePath,
      this.func,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.name);
    return ListTile(
        leading: Container(
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.height * 0.035,
          child: Image.asset(
            iconPath,
            color: CustomColors.primaryColor,
          ),
        ),
        title: TextDefault(
          text: title,
          color: color,
          fontWeight: FontWeight.bold,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: color,
          size: MediaQuery.of(context).size.height * 0.020,
        ),
        onTap: func != null
            ? func
            : () {
                pagePath == '/'
                    ? Navigator.popAndPushNamed(
                        context,
                        pagePath,
                      )
                    : Navigator.pushNamed<bool>(context, pagePath);
              });
  }
}
