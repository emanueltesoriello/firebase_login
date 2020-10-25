import 'package:firebase_login/pages/splash_screen.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:provider/provider.dart';

class NavigatorPage extends StatefulWidget {
  final Widget homePage;
  final Widget noCompany;
  NavigatorPage({@required this.homePage, @required this.noCompany});
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  QueryStore _queryStore;

  @override
  void initState() {
    super.initState();
    _queryStore = context.read();
    _queryStore.fetchTheUser();
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

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          return Observer(builder: (_) {
            if (_queryStore.loading)
              return SplashScreen();
            else {
              if (_queryStore.getTheUser.companyVatNumber == null) {
                return widget.noCompany;
              } else {
                return widget.homePage;
              }
            }
          });
        },
      );
}
