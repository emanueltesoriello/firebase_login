import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/pages/auth_page.dart';
import 'package:firebase_login/pages/fetch_app_page.dart';
import 'package:firebase_login/pages/home_page.dart';
import 'package:firebase_login/pages/navigator_page.dart';
import 'package:firebase_login/pages/no_company.dart';
import 'package:firebase_login/pages/splash_screen.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:flutter/material.dart';
import './stores/form_store.dart';
import './stores/user_store.dart';
import 'package:provider/provider.dart';

// Example
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initApp = Firebase.initializeApp();

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
            homePage: HomePage(),
            noCompany: NoCompany(
                title: 'Welcome to Marketing Valhalla', enableMagicCode: true)),
        authPage: AuthPage(
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
