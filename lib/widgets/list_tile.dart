import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/widgets/decorations/text_default.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  @required
  final String title;
  @required
  final String iconPath;
  final String pagePath;
  final Function func;

  CustomListTile({this.title, this.iconPath, this.pagePath, this.func});

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
          color: Colors.black,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
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
