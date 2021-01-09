import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/pages/main_page.dart';
import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/utilities/device_utils.dart';
import 'package:firebase_login/widgets/dialogs/change_email_dialog.dart';
import 'package:firebase_login/widgets/profile_page/user_profile_details.dart';
import 'package:firebase_login/widgets/profile_page/user_profile_image.dart';
import 'package:firebase_login/widgets/top_bar_web.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

class ProfilePage extends StatefulWidget {
  final Color firstFloatingActionButtonColor;
  final Color editModeFloatingActionButtonColor;
  final Color saveFloatingActionButtonColor;
  final Color cancelFloatingActionButtonColor;
  ProfilePage({
    this.firstFloatingActionButtonColor = CustomColors.primaryColor,
    this.editModeFloatingActionButtonColor = Colors.red,
    this.saveFloatingActionButtonColor = Colors.green,
    this.cancelFloatingActionButtonColor = Colors.blueAccent,
  });

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
    isEditMode = false;
  }

  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createInformation(
        message: message,
        title: 'Attention!',
        duration: Duration(seconds: 3),
      )..show(context);
    });
    return SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createInformation(
        message: message,
        title: 'Great!',
        duration: Duration(seconds: 3),
      )..show(context);
    });
    return SizedBox.shrink();
  }

  Widget _saveChanges() {
    return UnicornButton(
        currentButton: FloatingActionButton(
            onPressed: () async {
              try {
                DeviceUtils.hideKeyboard(context);
                if(_formStore.canUpdateAddress){
                  await _userStore.updateAddress(_formStore.address);
                }
                if(_formStore.canUpdatePostalCode){
                  await _userStore.updatePostalCode(_formStore.postalCode);
                }
                if(_formStore.canUpdateCity){
                  await _userStore.updateCity(_formStore.city);
                }
                if (_formStore.canUpdateUsername) {
                  print(_formStore.userName);
                  await _userStore.updateDisplayName(_formStore.userName);
                }
                if (_formStore.canUpdateEmail) {
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
                  if (_userStore.errorStore.errorMessage.isNotEmpty) {
                    _showErrorMessage(_userStore.errorStore.errorMessage);
                    return;
                  }
                }
                if (_userStore.errorStore.errorMessage.isNotEmpty ||
                    ((_formStore.formErrorStore.userName ?? '').isNotEmpty &&
                        (_formStore.formErrorStore.userName ?? '') !=
                            "Username can't be empty") ||
                    (_formStore.formErrorStore.userEmail.isNotEmpty &&
                        _formStore.formErrorStore.userEmail !=
                            "Email can't be empty")) {
                  print(_userStore.errorStore.errorMessage);
                  _showErrorMessage(_userStore.errorStore.errorMessage +
                      '\n' +
                      (_formStore.formErrorStore.userName ?? '') +
                      '\n' +
                      _formStore.formErrorStore.userEmail);
                  return;
                }
              } catch (e) {
                print(e);
              }
              if (_formStore.userEmail.isNotEmpty ||
                  _formStore.userName.isNotEmpty)
                _showSuccessMessage('Updated successfull!');
              isEditMode = true;
            },
            heroTag: "save",
            backgroundColor: widget.saveFloatingActionButtonColor,
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
            backgroundColor: widget.cancelFloatingActionButtonColor,
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
      backgroundColor: widget.firstFloatingActionButtonColor,
      onPressed: () async {
        setState(() {
          isEditMode = true;
        });
      },
      child: Icon(Icons.edit),
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
                      UserProfileDetails(user:_queryStore.getTheUser,isEditMode: isEditMode),
                      isEditMode ? Container() : SizedBox(height: 50),
                    ],
                  ),
          ),
        );
      });
}
