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
        ? FloatingActionButton(onPressed: () {}, child: Icon(Icons.add))
        : Container();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          return Observer(builder: (_) {
            print(_queryStore.getTheUser.isCompanyAdmin);
            return Scaffold(
              floatingActionButton: _floatingActionButton(),
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WELCOME TO YOUR HOMEPAGE!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                            onData: (_) =>
                                'UserId: ${_queryStore.getTheUser.objectId}'),
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
              ),
            );
          });
        },
      );
}
