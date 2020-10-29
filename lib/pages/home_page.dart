import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserStore _userStore;
  QueryStore _queryStore;
  double targetHeight;
  double targetWidth;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
    _showWelcomeMessage();
  }

  _showWelcomeMessage() {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createInformation(
        message: 'Enjoy our app!',
        title: 'Welcome!',
        duration: Duration(seconds: 3),
      )..show(context);
    });

    return SizedBox.shrink();
  }

  Widget _floatingActionButton() {
    return _queryStore.getTheUser.isCompanyAdmin
        ? FloatingActionButton(
            backgroundColor: CustomColors.primaryColor,
            onPressed: () {},
            child: Icon(Icons.add))
        : Container();
  }

  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'WELCOME TO YOUR HOMEPAGE!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 10),
              ObserverText(
                  onData: (_) =>
                      'Email: ${_userStore.getAuth?.currentUser?.email}'),
              ObserverText(
                  onData: (_) =>
                      'Username: ${_queryStore.getTheUser.userName}'),
              ObserverText(
                  onData: (_) =>
                      'Company Vat Number: ${_queryStore.getTheUser.companyVatNumber}'),
              ObserverText(
                  onData: (_) => 'UserId: ${_queryStore.getTheUser.objectId}'),
              _queryStore.getTheUser.isCompanyAdmin
                  ? ObserverText(
                      onData: (_) =>
                          'MagicCode: ${_queryStore.getTheUser.magicCode}')
                  : Container(),
            ],
          ),
          SizedBox(height: 100),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width / 1.2,
            child: GenericRoundedButtonDecoration(
              buttonColor: CustomColors.primaryColor,
              splashColor: CustomColors.backGroundColor,
              disabledColor: Colors.grey,
              child: LogoutButton(),
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
            floatingActionButton: _floatingActionButton(),
            body: targetWidth > 890.0
                ? Container(
                    width: targetWidth,
                    height: targetHeight,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'web/images/desktop_background.jpg'))),
                    child: Center(
                        child: Container(
                            color: Colors.white,
                            width: targetWidth > 1920.0
                                ? targetWidth / 5
                                : targetWidth / 3,
                            height: targetHeight / 1.3,
                            padding: const EdgeInsets.all(25),
                            alignment: Alignment.center,
                            child: _buildBody())))
                : Container(
                    padding: EdgeInsets.only(
                      left: targetHeight / 30,
                      right: targetHeight / 30,
                      top: targetHeight / 30,
                      bottom: targetHeight / 30,
                    ),
                    child: _buildBody()));
      });
}
