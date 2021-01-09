import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/models/user.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/phone_number_textformfield.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UserProfileDetails extends StatefulWidget {
  final Color profileBackgroundColor;
  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorCircularColor;
  final bool isEditMode;
  User user;

  UserProfileDetails(
      {this.profileBackgroundColor = CustomColors.backGroundColor,
      this.refreshIndicatorBackgroundColor = CustomColors.primaryColor,
      this.refreshIndicatorCircularColor = CustomColors.backGroundColor,
      this.isEditMode = false,
      @required this.user});

  @override
  _UserProfileDetailsState createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {
  bool loading = false;
  double targetHeight;
  double targetWidth;
  UserStore _userStore;
  QueryStore _queryStore;
  Map<String, dynamic> userDetails = {};

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
  }

  Widget _usernameEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username'),
        UsernameTextFormField(
          decoration: InputDecoration(
              hintText: 'New Username', labelText: widget.user.userName),
        )
      ],
    );
  }

  Widget _emailEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email'),
        EmailTextFormField(
          decoration: InputDecoration(
              hintText: 'New Email',
              labelText: _userStore.getAuth?.currentUser?.email),
        )
      ],
    );
  }

  Widget _phoneNumberEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number'),
        PhoneNumberTextFormField(
          decoration: InputDecoration(
              hintText: 'New Phone Number',
              labelText: widget.user.phoneNumber != null
                  ? widget.user.phoneNumber
                  : ""),
        )
      ],
    );
  }

  Widget _username() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          widget.user.userName,
        ),
      ],
    );
  }

  Widget _email() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
        SelectableText(widget.user.email),
      ],
    );
  }

  Widget _phoneNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.user.phoneNumber != null ? widget.user.phoneNumber : ""),
      ],
    );
  }

  Widget _company() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your company username: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.user.associatedCompany),
      ],
    );
  }

  Widget _magicCode() {
    return widget.user.isCompanyAdmin && widget.user.magicCode != null
        ? FittedBox(
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MagicCode: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(widget.user.magicCode)
            ],
          ))
        : Container();
  }

  Widget _userProfileDetails() {
    return loading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: widget.refreshIndicatorBackgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                  widget.refreshIndicatorCircularColor),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              widget.isEditMode ? _usernameEdit() : _username(),
              SizedBox(height: 10),
              widget.isEditMode ? _emailEdit() : _email(),
              widget.isEditMode ? Container() : SizedBox(height: 10),
              widget.isEditMode ? _phoneNumberEdit() : _phoneNumber(),
              widget.user.email != _queryStore.getTheUser.email
                  ? Container()
                  : widget.isEditMode
                      ? Container()
                      : SizedBox(height: 10),
              widget.user.email != _queryStore.getTheUser.email
                  ? Container()
                  : widget.isEditMode
                      ? Container()
                      : _company(),
              widget.user.email != _queryStore.getTheUser.email
                  ? Container()
                  : widget.isEditMode
                      ? Container()
                      : SizedBox(height: 10),
              widget.user.email != _queryStore.getTheUser.email
                  ? Container()
                  : widget.isEditMode
                      ? Container()
                      : _magicCode(),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    targetHeight = MediaQuery.of(context).size.height;
    targetWidth = MediaQuery.of(context).size.width;
    return Observer(
      builder: (_) {
        return _userProfileDetails();
      },
    );
  }
}
