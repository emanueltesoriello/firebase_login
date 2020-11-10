import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/drawer_web.dart';
import 'package:firebase_login/widgets/texts/text_default.dart';
import 'package:firebase_login/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  final Color backgroundColor;
  final Color logoutColor;
  final Color logoutTextColor;
  final Color logoutColorWeb;
  final Color logoutTextColorWeb;
  final Color logoutSplashColor;
  final List<Widget> pages;
  final List<Widget> secondaryPages;
  CustomDrawer({
    this.backgroundColor = CustomColors.backGroundColor,
    this.logoutColor = CustomColors.backGroundColor,
    this.logoutTextColor = Colors.white,
    this.logoutColorWeb = Colors.white,
    this.logoutTextColorWeb = Colors.black,
    this.logoutSplashColor = CustomColors.primaryColor,
    this.pages = const [],
    this.secondaryPages = const [],
  });
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
      color: widget.backgroundColor,
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
          TextDefault(
            text: 'Hi ${_userStore.getAuth?.currentUser?.displayName}',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: targetHeight / 12,
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    var _pages = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.pages);
    var _secondaryPages = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.secondaryPages);
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
                SizedBox(height: targetHeight / 50),
                _pages,
                Divider(color: Colors.black.withOpacity(0.5)),
                _secondaryPages
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: targetHeight / 40),
              height: MediaQuery.of(context).size.height / 20,
              child: GenericRoundedButtonDecoration(
                buttonColor: widget.logoutColor,
                splashColor: widget.logoutSplashColor,
                disabledColor: Colors.grey,
                child: LogoutButton(
                  textColor: widget.logoutTextColor,
                ),
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
        return targetWidth > 1280.0
            ? Container(
                width: targetWidth / (targetWidth > 1920 ? 7 : 5),
                child: CustomDrawerWeb(
                  primaryColor: widget.backgroundColor,
                  logoutColor: widget.logoutColorWeb,
                  logoutTextColor: widget.logoutTextColorWeb,
                  pages: widget.pages, //widget.pages,
                  secondaryPages:
                      widget.secondaryPages, //widget.secondaryPages,
                ))
            : Drawer(
                child: Container(
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
