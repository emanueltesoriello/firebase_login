import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/pages/main_page.dart';
import 'package:firebase_login/pages/profile_page.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/drawer/drawer.dart';
import 'package:firebase_login/widgets/list_tile.dart';
import 'package:firebase_login/widgets/top_bar_web.dart';
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
  }

  Widget _floatingActionButton() {
    return _queryStore.getTheUser.isCompanyAdmin
        ? FloatingActionButton(
            backgroundColor: CustomColors.primaryColor,
            onPressed: () {},
            child: Icon(Icons.add))
        : Container();
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        print(_queryStore.getTheUser.isCompanyAdmin);
        targetHeight = MediaQuery.of(context).size.height;
        targetWidth = MediaQuery.of(context).size.width;
        return MainPage(
          floatingActionButton: _floatingActionButton(),
          topBarWeb: TopBarWeb(),
          padding: EdgeInsets.all(0),
          body: Container(
            child: Center(child: Text('HomePage')),
          ),
        );
      });
}
