import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/textfields/company_name_textformfield.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/textfield_widget.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:firebase_login/widgets/texts/text_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class UserProfileDetails extends StatefulWidget {
  final Color profileBackgroundColor;
  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorCircularColor;
  final bool isEditMode;

  UserProfileDetails({
    this.profileBackgroundColor = CustomColors.backGroundColor,
    this.refreshIndicatorBackgroundColor = CustomColors.primaryColor,
    this.refreshIndicatorCircularColor = CustomColors.backGroundColor,
    this.isEditMode = false,
  });
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
              hintText: 'New Username',
              labelText: _queryStore.getTheUser.userName),
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

  Widget _username() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username: '),
        Text(
          _queryStore.getTheUser.userName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _email() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email: '),
        Text(
          _userStore.getAuth?.currentUser?.email,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _company() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your company username: '),
        Text(
          _queryStore.getTheUser.companyVatNumber,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _magicCode() {
    return _queryStore.getTheUser.isCompanyAdmin &&
            _queryStore.getTheUser.magicCode != null
        ? FittedBox(
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MagicCode: ',
                style: TextStyle(fontSize: 15),
              ),
              SelectableText(
                _queryStore.getTheUser.magicCode,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
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
              SizedBox(height: 10),
              _company(),
              SizedBox(height: 10),
              _magicCode(),
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
