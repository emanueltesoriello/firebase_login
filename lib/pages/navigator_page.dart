import 'package:firebase_login/pages/home_page.dart';
import 'package:firebase_login/pages/no_company.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  UserStore _userStore;
  QueryStore _queryStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
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

  /*Widget _test() {
    return Container(
        child: ObserverText(
      style: TextStyle(color: Colors.blue, fontSize: 16),
      onData: (_) => '${_queryStore.getTheTest}',
    ));
  }*/

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          return Observer(builder: (_) {
            if (_queryStore.getTheUser.companyVatNumber == null) {
              return NoCompany();
            } else {
              return HomePage();
            }
          });
        },
      );
}
