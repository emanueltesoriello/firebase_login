import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/pages/home_page.dart';
import 'package:firebase_login/pages/main_page.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/list_tile.dart';
import 'package:firebase_login/widgets/top_bar_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore _userStore;
  QueryStore _queryStore;
  double targetHeight;
  double targetWidth;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        print(_queryStore.getTheUser.isCompanyAdmin);
        targetHeight = MediaQuery.of(context).size.height;
        targetWidth = MediaQuery.of(context).size.width;
        return MainPage(
          topBarWeb: TopBarWeb(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PROFILE PAGE!',
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
                      onData: (_) =>
                          'UserId: ${_queryStore.getTheUser.objectId}'),
                  _queryStore.getTheUser.isCompanyAdmin
                      ? _queryStore.getTheUser.magicCode != null
                          ? SelectableText(
                              'MagicCode: ${_queryStore.getTheUser.magicCode}')
                          : ObserverText(
                              onData: (_) =>
                                  'MagicCode: ${_queryStore.getTheUser.magicCode}')
                      : Container(),
                ],
              ),
            ],
          ),
        );
      });
}
