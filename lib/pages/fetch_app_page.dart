import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class FetchAppPage extends StatefulWidget {
  final Widget splashScreen;
  final Widget noData;
  final Widget homePage;
  final Widget authPage;
  FetchAppPage({
    @required this.homePage,
    @required this.authPage,
    @required this.splashScreen,
    @required this.noData,
  });

  @override
  _FetchAppPageState createState() => _FetchAppPageState();
}

class _FetchAppPageState extends State<FetchAppPage> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ObserverFuture<FirebaseApp, Exception>(
            // Use this widget to handle ObservableFuture events
            retry: 2, // It will retry 2 times after the first error event
            autoInitialize:
                true, // If true, it will call [fetchData] automatically
            fetchData: () => _userStore.fetchApp(), // VoidCallback
            observableFuture: () => _userStore.myFirebaseApp,
            onData: (_, data) => MainPage(
              splashScreen: widget.splashScreen,
              homePage: widget.homePage,
              authPage: widget.authPage,
            ),
            onNull: (_) => widget.noData,
            onError: (_, error) => Scaffold(
              body: Scaffold(
                body: Center(
                  child: Text('${error.toString()}'),
                ),
              ),
            ),
            onPending: (_) => widget.splashScreen,
            onUnstarted: (_) => widget.splashScreen,
          ),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final Widget splashScreen;
  final Widget homePage;
  final Widget authPage;
  MainPage({
    @required this.homePage,
    @required this.splashScreen,
    @required this.authPage,
  });
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
            return widget.splashScreen;
          } else if (_userStore.getIsUserLogged) {
            print('User logged');
            return widget.homePage;
          } else {
            print('No user');
            return widget.authPage;
          }
        },
      );
}
