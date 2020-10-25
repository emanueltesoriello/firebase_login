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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
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
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WELCOME TO MARKETING VALHALLA!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    ObserverText(
                      onData: (_) =>
                          'USER: ${_userStore.getAuth?.currentUser?.email}',
                    ),
                    //_username(),
                    SizedBox(height: 30),
                    //_test(),
                    SizedBox(height: 100),
                    Container(
                      height: MediaQuery.of(context).size.height / 16,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: GenericRoundedButtonDecoration(
                        buttonColor: Colors.blue,
                        splashColor: Colors.blue[100],
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
