import 'package:firebase_login/widgets/buttons/logout.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_widget/mobx_widget.dart';
import '../stores/user_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void initState() {
    super.initState();
    _showWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          UserStore _userStore = context.read();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ObserverText(
                    onData: (_) =>
                        'USER: ${_userStore.getAuth?.currentUser?.email}',
                  ),
                  LogoutButton(),
                ],
              ),
            ),
          );
        },
      );
}
