import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/pages/home_page.dart';
import 'package:firebase_login/pages/main_page.dart';
import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/utilities/device_utils.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/custom_menu_fab.dart';
import 'package:firebase_login/widgets/dialogs/change_email_dialog.dart';
import 'package:firebase_login/widgets/list_tile.dart';
import 'package:firebase_login/widgets/profile_page/user_profile_details.dart';
import 'package:firebase_login/widgets/profile_page/user_profile_image.dart';
import 'package:firebase_login/widgets/top_bar_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore _userStore;
  QueryStore _queryStore;
  FormStore _formStore;
  double targetHeight;
  double targetWidth;
  bool loading = false;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
    _formStore = context.read();
  }

  Widget _saveChanges() {
    return UnicornButton(
        currentButton: FloatingActionButton(
            onPressed: () async {
              /*if (_formStore.formErrorStore.userName == null &&
                  _formStore.formErrorStore.userEmail == null) {*/
              DeviceUtils.hideKeyboard(context);
              if (_formStore.userName.isNotEmpty) {
                print(_formStore.userName);
                await _userStore.updateDisplayName(_formStore.userName);
              }
              if (_formStore.userEmail.isNotEmpty) {
                print(_formStore.userEmail);
                await showDialog(
                    context: context,
                    child: ChangeEmailDialog(
                      textFormFieldDecoration: InputDecoration(),
                      buttonBorderRadius: Radius.circular(90),
                      imageAsset: 'web/images/logo.png',
                      buttonColor: CustomColors.primaryColor,
                      buttonDisabledColor: Colors.grey,
                      buttonSplashColor: CustomColors.backGroundColor,
                    ));
                // await _userStore.updateEmail(_formStore.userEmail);
                var a = 0;
              }
              if (_userStore.errorStore.errorMessage != null) {
                print(_userStore.errorStore.errorMessage);
              }
              /*  } else {
                String errorUserName = _formStore.formErrorStore.userName;
                String erroruserEmail = _formStore.formErrorStore.userEmail;
                print(errorUserName);
                print(erroruserEmail);
              }*/
            },
            heroTag: "save",
            backgroundColor: Colors.green,
            mini: true,
            child: Icon(Icons.save)));
  }

  Widget _cancelEditMode() {
    return UnicornButton(
        currentButton: FloatingActionButton(
            onPressed: () => setState(() {
                  isEditMode = false;
                  _formStore.reset();
                }),
            heroTag: "cancel",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.undo)));
  }

  Widget _floatingActionButtonEdit() {
    var childButtons = List<UnicornButton>();
    childButtons.add(_saveChanges());
    childButtons.add(_cancelEditMode());

    return MediaQuery.of(context).viewInsets.bottom != 0
        ? _saveChanges()
        : UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: Colors.redAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.menu),
            childButtons: childButtons);
  }

  Widget _floatingActionButtonEnableEdit() {
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          isEditMode = true;
        });
      },
      child: Icon(Icons.edit),
    );
  }

  Widget _appInfos() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {},
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            'Terms of use',
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {},
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {},
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        print(_queryStore.getTheUser.isCompanyAdmin);
        targetHeight = MediaQuery.of(context).size.height;
        targetWidth = MediaQuery.of(context).size.width;
        return MainPage(
          topBarWeb: TopBarWeb(),
          floatingActionButton: isEditMode
              ? _floatingActionButtonEdit()
              : _floatingActionButtonEnableEdit(),
          body: SingleChildScrollView(
            child: _userStore.loading
                ? Center(
                    child: CircularProgressIndicator(
                        backgroundColor: CustomColors.backGroundColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustomColors.primaryColor)))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: UserProfileImage(isEditMode: isEditMode)),
                      UserProfileDetails(isEditMode: isEditMode),
                      isEditMode ? Container() : SizedBox(height: 50),
                      isEditMode ? Container() : Divider(),
                      isEditMode ? Container() : _appInfos()
                      /*SizedBox(height: 50),
                      Text(
                        'PROFILE PAGE!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40),
                      ),
                      SizedBox(height: 10),
                      ObserverText(
                          onData: (_) =>
                              'Email: ${_userStore.getAuth?.currentUser?.email}'),
                      ObserverText(
                          onData: (_) =>
                              'Username: ${_queryStore.getTheUser.userName}'),
                      ObserverText(
                          onData: (_) =>
                              'Company Vat Number: ${_queryStore.getTheUser.companyVatNumber}'),
                      ObserverText(
                          onData: (_) =>
                              'UserId: ${_queryStore.getTheUser.objectId}'),
                      _queryStore.getTheUser.isCompanyAdmin
                          ? _queryStore.getTheUser.magicCode != null
                              ? SelectableText(
                                  'MagicCode: ${_queryStore.getTheUser.magicCode}')
                              : ObserverText(
                                  onData: (_) =>
                                      'MagicCode: ${_queryStore.getTheUser.magicCode}')
                          : Container(),*/
                    ],
                  ),
          ),
        );
      });
}
