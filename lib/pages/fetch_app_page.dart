import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class FetchAppPage extends StatefulWidget {
  final Widget mainPage;
  final Widget splashScreen;
  final Widget noData;
  FetchAppPage({
    @required this.mainPage,
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
            onData: (_, data) => widget.mainPage,
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
