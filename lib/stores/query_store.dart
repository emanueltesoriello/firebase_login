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
  ObservableFuture<mv.User> user;

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
              .doc(element.data()['associatedCompany'].toString().toLowerCase())
              .snapshots()
              .forEach((companyData) async {
            if (companyData.exists) {
              String magicCode = companyData.data()['magicCode'];
              var userData = element.data();
              await FirebaseFirestore.instance
                  .collection("roles")
                  .doc(userData["associatedTechnicalRole"].toString())
                  .snapshots()
                  .forEach((element) {
                if (element.exists) {
                  bool isCompanyAdmin = false;
                  if (element.data()["roleName"] == "Admin") {
                    isCompanyAdmin = true;
                  }
                  userData.addAll({
                    'magicCode': magicCode,
                    'isCompanyAdmin': isCompanyAdmin
                  });
                  print(userData);
                  user = ObservableFuture(
                      Future.value(mv.User.fromJSON(userData)));
                  loading = false;
                } else {
                  user = ObservableFuture(Future.value(null));
                  loading = false;
                }
              });
            } else {
              user = ObservableFuture(Future.value(null));
              loading = false;
            }
          });
        } else {
          user = ObservableFuture(Future.value(null));
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
            .set({'companyName': companyName, 'magicCode': mgCode});
        // add standard roles for the company
        await FirebaseFirestore.instance.collection("roles").add({
          "roleName": "Admin",
          "associatedCompany": chamberOfCommerceNo.toLowerCase(),
        });
        await FirebaseFirestore.instance.collection("roles").add({
          "roleName": "User",
          "associatedCompany": chamberOfCommerceNo.toLowerCase(),
        });
        await FirebaseFirestore.instance
            .collection("roles")
            .where("roleName", isEqualTo: "Admin")
            .where("associatedCompany",
                isEqualTo: chamberOfCommerceNo.toLowerCase())
            .get()
            .then((response) async {
          //add techincalRole to user
          await FirebaseFirestore.instance.collection("users").doc(userId).set({
            'associatedCompany': chamberOfCommerceNo.toLowerCase(),
            'associatedTechnicalRole': response.docs[0].id,
            'objectId': userId,
            'userName': userName,
          });
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

  mv.User get getTheUser => this.user?.result ?? mv.User();
}
