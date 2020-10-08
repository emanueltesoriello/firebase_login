// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<User> _$getUserComputed;

  @override
  User get getUser => (_$getUserComputed ??=
          Computed<User>(() => super.getUser, name: '_UserStore.getUser'))
      .value;
  Computed<bool> _$getIsUserLoggedComputed;

  @override
  bool get getIsUserLogged =>
      (_$getIsUserLoggedComputed ??= Computed<bool>(() => super.getIsUserLogged,
              name: '_UserStore.getIsUserLogged'))
          .value;
  Computed<FirebaseAuth> _$getAuthComputed;

  @override
  FirebaseAuth get getAuth =>
      (_$getAuthComputed ??= Computed<FirebaseAuth>(() => super.getAuth,
              name: '_UserStore.getAuth'))
          .value;
  Computed<FirebaseApp> _$getAppComputed;

  @override
  FirebaseApp get getApp => (_$getAppComputed ??=
          Computed<FirebaseApp>(() => super.getApp, name: '_UserStore.getApp'))
      .value;

  final _$successAtom = Atom(name: '_UserStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$myFirebaseAuthAtom = Atom(name: '_UserStore.myFirebaseAuth');

  @override
  ObservableFuture<FirebaseAuth> get myFirebaseAuth {
    _$myFirebaseAuthAtom.reportRead();
    return super.myFirebaseAuth;
  }

  @override
  set myFirebaseAuth(ObservableFuture<FirebaseAuth> value) {
    _$myFirebaseAuthAtom.reportWrite(value, super.myFirebaseAuth, () {
      super.myFirebaseAuth = value;
    });
  }

  final _$myFirebaseAppAtom = Atom(name: '_UserStore.myFirebaseApp');

  @override
  ObservableFuture<FirebaseApp> get myFirebaseApp {
    _$myFirebaseAppAtom.reportRead();
    return super.myFirebaseApp;
  }

  @override
  set myFirebaseApp(ObservableFuture<FirebaseApp> value) {
    _$myFirebaseAppAtom.reportWrite(value, super.myFirebaseApp, () {
      super.myFirebaseApp = value;
    });
  }

  final _$loadingAtom = Atom(name: '_UserStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  ObservableFuture<User> get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ObservableFuture<User> value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$isUserLoggedAtom = Atom(name: '_UserStore.isUserLogged');

  @override
  ObservableFuture<bool> get isUserLogged {
    _$isUserLoggedAtom.reportRead();
    return super.isUserLogged;
  }

  @override
  set isUserLogged(ObservableFuture<bool> value) {
    _$isUserLoggedAtom.reportWrite(value, super.isUserLogged, () {
      super.isUserLogged = value;
    });
  }

  final _$fetchAuthAsyncAction = AsyncAction('_UserStore.fetchAuth');

  @override
  Future<dynamic> fetchAuth() {
    return _$fetchAuthAsyncAction.run(() => super.fetchAuth());
  }

  final _$loginUsersAsyncAction = AsyncAction('_UserStore.loginUsers');

  @override
  Future<void> loginUsers(String email, String pass) {
    return _$loginUsersAsyncAction.run(() => super.loginUsers(email, pass));
  }

  final _$logoutAsyncAction = AsyncAction('_UserStore.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$forgotPasswordAsyncAction = AsyncAction('_UserStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  Future<dynamic> fetchApp() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.fetchApp');
    try {
      return super.fetchApp();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
myFirebaseAuth: ${myFirebaseAuth},
myFirebaseApp: ${myFirebaseApp},
loading: ${loading},
user: ${user},
isUserLogged: ${isUserLogged},
getUser: ${getUser},
getIsUserLogged: ${getIsUserLogged},
getAuth: ${getAuth},
getApp: ${getApp}
    ''';
  }
}
