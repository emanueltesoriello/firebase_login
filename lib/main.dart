import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/example/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_widget/mobx_widget.dart';
import './example/splash_screen.dart';
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
    return MultiProvider(providers: [
      Provider<FormStore>(
        create: (_) => FormStore(),
      ),
      Provider<UserStore>(
        create: (_) => UserStore(firebaseApp: _initApp),
      ),
    ], child: MainBody());
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.orange,
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ObserverFuture<FirebaseApp, Exception>(
            // Use this widget to handle ObservableFuture events
            retry: 2, // It will retry 2 times after the first error event
            autoInitialize:
                true, // If true, it will call [fetchData] automatically
            fetchData: () => _userStore.fetchApp(), // VoidCallback
            observableFuture: () => _userStore.myFirebaseApp,
            onData: (_, data) => MainPage(),
            onNull: (_) => Scaffold(
              body: Center(
                child: Text('NO DATA'),
              ),
            ),
            onError: (_, error) => Scaffold(
              body: Scaffold(
                body: Center(
                  child: Text('${error.toString()}'),
                ),
              ),
            ),
            onPending: (_) => SplashScreen(),
            onUnstarted: (_) => SplashScreen(),
          ),
        );
      },
    );
  }
}
