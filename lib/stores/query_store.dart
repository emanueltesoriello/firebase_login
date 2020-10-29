import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/models/user.dart' as mv;
import 'package:firebase_login/stores/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'query_store.g.dart';

class QueryStore = _QueryStore with _$QueryStore;

abstract class _QueryStore with Store {
  _QueryStore();

  final ErrorStore errorStore = ErrorStore();

  @observable
  ObservableFuture<mv.User> _user;

  @observable
  bool loading = false;

  // ***********************************************
  // ***************** FETCH DATA ******************

  @action
  Future fetchTheUser() async {
    loading = true;
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .snapshots()
          .forEach((element) async {
        print(element.data());
        if (element.exists) {
          await FirebaseFirestore.instance
              .collection("companies")
              .doc(element.data()['companyVatNumber'].toString().toLowerCase())
              .snapshots()
              .forEach((companyData) async {
            if (companyData.exists) {
              List<dynamic> companyAdmins = companyData.data()['companyAdmins'];
              String magicCode = companyData.data()['magicCode'];
              var userData = element.data();
              userData.addAll(
                  {'companyAdmins': companyAdmins, 'magicCode': magicCode});
              _user =
                  ObservableFuture(Future.value(mv.User.fromJSON(userData)));
              loading = false;
            } else {
              _user = ObservableFuture(Future.value(null));
              loading = false;
            }
          });
        } else {
          _user = ObservableFuture(Future.value(null));
          loading = false;
        }
      }).catchError((e) {
        print(e);
        loading = false;
      });
    } catch (e) {
      print(e);
      loading = false;
    }
    loading = false;
  }

  @action
  Future addNewCompany(String chamberOfCommerceNo, String companyName) async {
    loading = true;
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String userName = FirebaseAuth.instance.currentUser.displayName;
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("companies")
          .doc(chamberOfCommerceNo.toLowerCase())
          .get()
        ..exists;
      bool companyExist = ds.exists;
      if (companyExist) {
        print('Company exists');
        errorStore.setErrorMessage(
            'Attention, this company already exist!\nPlease use a Magic Code if you want to use this company, or change the Chamber of commerce.');
        loading = false;
      } else {
        print("Company doen't exists!");
        var mgCode = Uuid().v1();
        // add document into companies
        await FirebaseFirestore.instance
            .collection("companies")
            .doc(chamberOfCommerceNo.toLowerCase())
            .set({
          'companyName': companyName,
          'companyAdmins': [userId],
          'magicCode': mgCode
        });
        // add document into users
        await FirebaseFirestore.instance.collection("users").doc(userId).set({
          'companyVatNumber': chamberOfCommerceNo,
          'objectId': userId,
          'userName': userName,
        });
        await FirebaseFirestore.instance
            .collection("magic-codes")
            .doc(mgCode)
            .set({
          'companyVatNumber': chamberOfCommerceNo,
        });
        loading = false;
      }
    } catch (e) {
      print(e);
      loading = false;
    }
    loading = false;
  }

  @action
  Future checkMagicCode(String magicCode) async {
    loading = true;
    try {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("magic-codes")
          .doc(magicCode)
          .get();
      if (ds.exists) {
        String userId = FirebaseAuth.instance.currentUser.uid;
        String userName = FirebaseAuth.instance.currentUser.displayName;
        print('Correct magic code');
        // add document into users
        await FirebaseFirestore.instance.collection("users").doc(userId).set({
          'companyVatNumber': ds.data()['companyVatNumber'],
          'objectId': userId,
          'userName': userName,
        });
        loading = false;
      } else {
        print('Wrong magic code');
        errorStore.setErrorMessage(
            'Attention, you have inserted a wrong magic code!');
        loading = false;
      }
    } catch (e) {
      print(e);
      loading = false;
    }
    loading = false;
  }

  // ***********************************************
  // ***************** GET DATA ******************

  /*String get getTheTest =>
      _testFuture != null ? (_testFuture.result ?? '') : '';*/

  mv.User get getTheUser =>
      _user != null ? _user.result ?? mv.User() : mv.User();
}
