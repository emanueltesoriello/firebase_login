import 'package:firebase_login/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:provider/provider.dart';

class NavigatorPage extends StatefulWidget {
  final Widget homePage;
  final Widget noCompany;
  final Widget splashScreen;

  NavigatorPage(
      {@required this.homePage,
      @required this.noCompany,
      @required this.splashScreen});
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
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          return Observer(builder: (_) {
            if (_queryStore.loading)
              return widget.splashScreen;
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
