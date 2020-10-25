import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/models/user.dart' as mv;
import 'package:firebase_login/stores/error_store.dart';
import 'package:mobx/mobx.dart';

part 'query_store.g.dart';

class QueryStore = _QueryStore with _$QueryStore;

abstract class _QueryStore with Store {
  _QueryStore();

  final ErrorStore errorStore = ErrorStore();

  @observable
  ObservableFuture<String> _testFuture;

  @observable
  ObservableFuture<mv.User> _user;

  // ***********************************************
  // ***************** FETCH DATA ******************
  @action
  Future fetchTests() async {
    await FirebaseFirestore.instance
        .collection("test")
        .doc('YvI9HWAzoH72jF3LiH2X')
        .snapshots()
        .forEach((element) {
      print(element.data()['test']);
      _testFuture = ObservableFuture(Future.value(element.data()['test']));
    }).catchError((e) {
      print(e);
    });
    return _testFuture;
  }

  @action
  Future fetchTheUser() async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .forEach((element) {
      print(element.data());
      if (element.exists) {
        _user =
            ObservableFuture(Future.value(mv.User.fromJSON(element.data())));
      } else
        _user = ObservableFuture(Future.value(null));
    }).catchError((e) {
      print(e);
    });
    return _testFuture;
  }

  @action
  Future addNewCompany(String chamberOfCommerceNo, String companyName) async {
    //print('Chamber of commerce: ' + chamberOfCommerceNo);
    //print('Company name: ' + companyName);
    String userId = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection("companies")
        .doc(chamberOfCommerceNo.toLowerCase())
        .get()
      ..exists;
    bool companyExist = ds.exists;
    if (companyExist) {
      print('Company exists');
      errorStore.setErrorMessage(
          'Attention, this company already exist! Please use a Magic Code if you want to use this company, or change the Chamber of commerce.');
    } else {
      print("Company doen't exists!");
      // add document into companies
      await FirebaseFirestore.instance
          .collection("companies")
          .doc(chamberOfCommerceNo)
          .set({'companyName': companyName});
      // add document into users
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        'companyVatNumber': chamberOfCommerceNo,
        'companyName': companyName
      });
      //saveCompanyQuery;
    }
    /*String userId = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)r
        .snapshots()
        .forEach((element) {
      print(element.data());
      if (element.exists) {
        _user =
            ObservableFuture(Future.value(mv.User.fromJSON(element.data())));
      } else
        _user = ObservableFuture(Future.value(null));
    }).catchError((e) {
      print(e);
    });
    return _testFuture;*/
  }

  // ***********************************************
  // ***************** GET DATA ******************

  String get getTheTest =>
      _testFuture != null ? (_testFuture.result ?? '') : '';

  mv.User get getTheUser =>
      _user != null ? _user.result ?? mv.User() : mv.User();
}
