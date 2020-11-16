import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../stores/error_store.dart';

import '../services/network_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final Future<FirebaseApp> firebaseApp;
  final Future<FirebaseAuth> firebaseAuth;
  _UserStore({this.firebaseApp, this.firebaseAuth}) {
    fetchApp();
    fetchAuth();
    fetchUser();
  }

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------

  @observable
  bool success = false;

  @observable
  ObservableFuture<FirebaseAuth> myFirebaseAuth;

  @observable
  ObservableFuture<FirebaseApp> myFirebaseApp;

  @observable
  bool loading = false;

  @observable
  ObservableFuture<User> user;

  @observable
  ObservableFuture<bool> isUserLogged;

  @computed
  User get getUser => user.value;

  @computed
  bool get getIsUserLogged => isUserLogged.value;

  @computed
  FirebaseAuth get getAuth => myFirebaseAuth.value;

  @computed
  FirebaseApp get getApp => myFirebaseApp.value;

  // actions:-----------------------------------------------------------

  @action
  Future fetchApp() => myFirebaseApp = ObservableFuture(firebaseApp);

  @action
  Future fetchAuth() async {
    myFirebaseAuth = ObservableFuture(
        Future.value(FirebaseAuth.instanceFor(app: await firebaseApp)));
  }

  Future fetchUser() async {
    FirebaseAuth.instanceFor(app: await firebaseApp)
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        isUserLogged = ObservableFuture(Future.value(false));
        print('User is currently signed out!');
      } else {
        isUserLogged = ObservableFuture(Future.value(true));
        print('User is signed in!');
      }
    });
  }

  @action
  Future<void> loginUsers(String email, String pass) async {
    loading = true;
    try {
      final NetworkService networkService = NetworkService(getAuth);
      String response = await networkService.login(email, pass);
      if (response.isNotEmpty) {
        loading = false;
        errorStore.setErrorMessage(response);
      } else {
        loading = false;
        success = true;
      }
    } catch (e) {
      loading = false;
      errorStore.setErrorMessage(e);
    }
  }

  @action
  Future<void> registerUser(String username, String email, String pass) async {
    loading = true;
    try {
      final NetworkService networkService = NetworkService(getAuth);
      String response = await networkService.signUp(username, pass, email);
      if (response.isNotEmpty) {
        loading = false;
        errorStore.setErrorMessage(response);
      } else {
        loading = false;
        success = true;
      }
    } catch (e) {
      loading = false;
      errorStore.setErrorMessage(e);
    }
  }

  @action
  Future<void> sendEmailValidationUser(String email, String password) async {
    loading = true;
    try {
      final NetworkService networkService = NetworkService(getAuth);
      String response =
          await networkService.sendEmailValidation(email, password);
      if (response.isNotEmpty) {
        loading = false;
        errorStore.setErrorMessage(response);
      } else {
        loading = false;
        success = true;
      }
    } catch (e) {
      loading = false;
      errorStore.setErrorMessage(e);
    }
  }

  @action
  Future<void> logout() async {
    loading = true;
    try {
      final NetworkService networkService = NetworkService(getAuth);
      String response = await networkService.logout();
      if (response.isNotEmpty) {
        loading = false;
        errorStore.setErrorMessage(response);
      } else {
        loading = false;
        success = true;
      }
    } catch (e) {
      loading = false;
      errorStore.setErrorMessage(e);
    }
  }

  @action
  Future<void> sendResetPassword(String email) async {
    loading = true;
    try {
      final NetworkService networkService = NetworkService(getAuth);
      String response = await networkService.sendResetPassword(email);
      if (response.isNotEmpty) {
        loading = false;
        errorStore.setErrorMessage(response);
      } else {
        loading = false;
        success = true;
      }
    } catch (e) {
      loading = false;
      errorStore.setErrorMessage(e);
    }
  }

  Future updateProfilePic() async {
    await getAuth.currentUser.updateProfile(
        photoURL:
            'https://www.emanueltesoriellodeveloper.com/wp-content/uploads/2019/05/logo-et-con-scritta-e1580480915528.png');
  }
}
