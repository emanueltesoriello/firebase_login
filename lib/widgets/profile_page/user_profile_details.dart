import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/circle_avatar_image.dart';
import 'package:firebase_login/widgets/textfields/company_name_textformfield.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/textfield_widget.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UserProfileDetails extends StatefulWidget {
  final Color profileBackgroundColor;
  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorCircularColor;

  UserProfileDetails({
    this.profileBackgroundColor = CustomColors.backGroundColor,
    this.refreshIndicatorBackgroundColor = CustomColors.primaryColor,
    this.refreshIndicatorCircularColor = CustomColors.backGroundColor,
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

  Widget _username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username'),
        UsernameTextFormField(
          decoration: InputDecoration(
              hintText: 'New Username',
              labelText:_queryStore.getTheUser.userName),
        )
      ],
    );
  }

  Widget _email() {
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

  Widget _company() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Company username'),
        CompanyNameTextFormField(
          decoration: InputDecoration(
              hintText: 'New Company username',
              labelText: _queryStore.getTheUser.companyVatNumber),
        )
      ],
    );
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
              SizedBox(height: 5),
              _username(),
              SizedBox(height: 5),
              _email(),
              SizedBox(height: 5),
              _company(),
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
