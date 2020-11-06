import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CustomDrawerWeb extends StatefulWidget {
  final Color primaryColor;
  final Color logoutColor;
  final Color logoutSplashColor;
  final List<Widget> pages;
  final List<Widget> secondaryPages;
  CustomDrawerWeb({
    this.primaryColor = CustomColors.backGroundColor,
    this.logoutColor = Colors.white,
    this.logoutSplashColor = CustomColors.primaryColor,
    this.pages = const [],
    this.secondaryPages = const [],
  });
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
          color: widget.primaryColor,
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
