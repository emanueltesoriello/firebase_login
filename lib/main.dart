import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/pages/auth_page.dart';
import 'package:firebase_login/pages/fetch_app_page.dart';
import 'package:firebase_login/pages/home_page.dart';
import 'package:firebase_login/pages/navigator_page.dart';
import 'package:firebase_login/pages/no_company.dart';
import 'package:firebase_login/pages/splash_screen.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import './stores/form_store.dart';
import './stores/user_store.dart';
import 'package:provider/provider.dart';

// Example
void main() => runApp(RestartWidget(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initApp = Firebase.initializeApp();

  static const decoration = InputDecoration(
    fillColor: Color.fromRGBO(242, 245, 248, 1),
    border: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      //  borderSide: BorderSide(color: Color.fromRGBO(233, 203, 150, 1))
    ),
    filled: true,
    contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FormStore>(
          create: (_) => FormStore(),
        ),
        Provider<UserStore>(
          create: (_) => UserStore(firebaseApp: _initApp),
        ),
        Provider<QueryStore>(
          create: (_) => QueryStore(),
        ),
      ],
      child: FetchAppPage(
        navigatorPage: NavigatorPage(
            splashScreen: SplashScreen(),
            homePage: HomePage(),
            noCompany: NoCompany(
                textFormFieldsDecoration: decoration,
                useAsset: true,
                title: 'Welcome to Marketing Valhalla',
                enableMagicCode: true)),
        authPage: AuthPage(
            textFormFieldsDecoration: decoration,
            buttonsBorderRadius: const Radius.circular(90),
            useAsset: true,
            loginImageAsset: 'web/images/logo.png',
            registerImageAsset: 'web/images/logo.png',
            appName: 'MarketingValhalla',
            loginDescription:
                'Login to reach again the Valhalla for Marketers?',
            signupDescription:
                'Are you ready to join the Valhalla for Marketers?'),
        noData: Scaffold(
          body: Center(
            child: Text('NO DATA'),
          ),
        ),
        splashScreen: SplashScreen(),
      ),
    );
  }
}
