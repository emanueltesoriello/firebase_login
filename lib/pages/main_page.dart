import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/decorations/text_default_bold.dart';
import 'package:firebase_login/widgets/drawer.dart';
import 'package:firebase_login/widgets/drawer_web.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final Widget body;
  final FloatingActionButton floatingActionButton;
  MainPage({this.body, this.floatingActionButton});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserStore _userStore;
  QueryStore _queryStore;
  double targetHeight;
  double targetWidth;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
    //_showWelcomeMessage();
  }

  /*_showWelcomeMessage() {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createInformation(
        message: 'Enjoy our app!',
        title: 'Welcome!',
        duration: Duration(seconds: 3),
      )..show(context);
    });

    return SizedBox.shrink();
  }*/

  Widget _buildTopBarWeb() {
    return Container(
      height: targetHeight / 12,
      padding: EdgeInsets.only(left: targetWidth / 20, right: targetWidth / 30),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextDefaultBold(
            text: 'Company Logo',
            color: Colors.white,
          ),
          Container(
            height: targetHeight / 17,
            width: targetHeight / 17,
            child: Container(
              child: CircleAvatarImage(
                color: CustomColors.backGroundColor,
                imageURL: _userStore.getAuth?.currentUser?.photoURL,
                text:
                    '${_userStore.getAuth?.currentUser?.displayName?.split(' ')[0].substring(0, 2).toUpperCase()}',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        print(_queryStore.getTheUser.isCompanyAdmin);
        targetHeight = MediaQuery.of(context).size.height;
        targetWidth = MediaQuery.of(context).size.width;
        return Scaffold(
            appBar: targetWidth > 890.0
                ? targetWidth > 1280.0
                    ? null
                    : AppBar(backgroundColor: CustomColors.backGroundColor)
                : AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black)),
            drawer: CustomDrawer(),
            floatingActionButton: widget.floatingActionButton,
            body: targetWidth > 890.0 //is a large screen?
                ? Column(children: [
                    // is screen width > 1280?
                    targetWidth > 1280.0 ? _buildTopBarWeb() : Container(),
                    Container(
                        height: targetHeight - targetHeight / 12,
                        child: Row(children: [
                          // is screen width > 1280?
                          targetWidth > 1280.0
                              ? Container(
                                  width: targetWidth / 5,
                                  child: CustomDrawerWeb(),
                                )
                              : Container(),
                          // is screen width > 1280?
                          Container(
                              width: targetWidth > 1280.0
                                  ? (targetWidth - targetWidth / 5)
                                  : targetWidth,
                              height: targetHeight,
                              child: Center(
                                  // is screen ultra wide?
                                  child: Container(
                                      width: targetWidth > 1920.0
                                          ? targetWidth / 5
                                          : targetWidth / 3,
                                      height: targetHeight / 1.3,
                                      padding: const EdgeInsets.all(25),
                                      alignment: Alignment.center,
                                      child: widget.body)))
                        ]))
                  ])
                // mobile View
                : Container(
                    padding: EdgeInsets.only(
                      left: targetHeight / 30,
                      right: targetHeight / 30,
                      top: targetHeight / 30,
                      bottom: targetHeight / 30,
                    ),
                    child: widget.body));
      });
}
