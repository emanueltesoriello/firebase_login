import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/decorations/text_default_bold.dart';
import 'package:firebase_login/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CustomDrawerWeb extends StatefulWidget {
  @override
  _CustomDrawerWebState createState() => _CustomDrawerWebState();
}

class _CustomDrawerWebState extends State<CustomDrawerWeb> {
  double targetWidth;
  double targetHeight;
  UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
  }

  Widget _buildBody() {
    return Expanded(
      child: Container(
        padding:
            EdgeInsets.only(left: targetHeight / 30, right: targetHeight / 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: targetHeight / 100),
                SizedBox(height: targetHeight / 100),
                CustomListTile(
                    title: 'Page 1',
                    iconPath: 'web/icons/stats_purple.png',
                    pagePath: '/home',
                    color: Colors.white,
                    func: () {}),
                CustomListTile(
                    title: 'Page 2',
                    iconPath: 'web/icons/stats_purple.png',
                    pagePath: '/team',
                    color: Colors.white,
                    func: () {}),
                Divider(color: Colors.white.withOpacity(0.5)),
                CustomListTile(
                    title: 'Settings',
                    iconPath: 'web/icons/stats_purple.png',
                    pagePath: '/settings',
                    color: Colors.white,
                    func: () {}),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: targetHeight / 40),
              height: MediaQuery.of(context).size.height / 20,
              child: GenericRoundedButtonDecoration(
                buttonColor: Colors.white,
                splashColor: CustomColors.primaryColor,
                disabledColor: Colors.grey,
                child: LogoutButton(textColor: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    targetWidth = deviceWidth;
    targetHeight = deviceHeight;
    return Observer(
      builder: (_) {
        return Container(
          color: CustomColors.backGroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //_buildTop(),
              _buildBody(),
            ],
          ),
        );
      },
    );
  }
}
