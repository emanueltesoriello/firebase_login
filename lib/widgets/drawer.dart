import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/decorations/text_default_bold.dart';
import 'package:firebase_login/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double targetWidth;
  double targetHeight;
  UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
  }

  Widget _buildTop() {
    return Container(
      height: targetHeight / 5,
      padding: EdgeInsets.only(top: targetHeight / 15),
      color: CustomColors.backGroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: targetHeight / 17,
            width: targetHeight / 17,
            child: Container(
              child: CircleAvatarImage(
                imageURL: _userStore.getAuth?.currentUser?.photoURL,
                text:
                    '${_userStore.getAuth?.currentUser?.displayName?.split(' ')[0].substring(0, 2).toUpperCase()}',
              ),
            ),
          ),
          TextDefaultBold(
            text: 'Hi ${_userStore.getAuth?.currentUser?.displayName}',
            color: Colors.white,
          ),
          SizedBox(
            width: targetHeight / 12,
          )
        ],
      ),
    );
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
                    title: 'Stats',
                    iconPath: 'web/icons/stats_purple.png',
                    pagePath: '/home',
                    func: () {}),
                Divider(color: Colors.black.withOpacity(0.5)),
                CustomListTile(
                    title: 'Team',
                    iconPath: 'web/icons/stats_purple.png',
                    pagePath: '/team',
                    func: () {}),
                CustomListTile(
                    title: 'Settings',
                    iconPath: 'web/icons/stats_purple.png',
                    pagePath: '/settings',
                    func: () {}),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: targetHeight / 40),
              height: MediaQuery.of(context).size.height / 20,
              child: GenericRoundedButtonDecoration(
                buttonColor: CustomColors.backGroundColor,
                splashColor: CustomColors.primaryColor,
                disabledColor: Colors.grey,
                child: LogoutButton(),
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
        return Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildTop(),
                _buildBody(),
              ],
            ),
          ),
        );
      },
    );
  }
}
