import 'package:firebase_login/example/auth_page.dart';
import 'package:firebase_login/example/home_page.dart';
import 'package:firebase_login/example/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/user_store.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => new Observer(
        builder: (_) {
          UserStore _userStore = context.read();
          if (_userStore.loading) {
            print('ConnectionState waiting');
            return SplashScreen();
          } else if (_userStore.getIsUserLogged) {
            print('User logged');
            return HomePage();
          } else {
            print('No user');
            return AuthPage();
          }
        },
      );
}
