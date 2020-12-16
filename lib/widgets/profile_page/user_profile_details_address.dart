import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/circle_avatar/circle_avatar_image.dart';
import 'package:firebase_login/widgets/textfields/address_textformfield.dart';
import 'package:firebase_login/widgets/textfields/city_textformfield.dart';
import 'package:firebase_login/widgets/textfields/company_name_textformfield.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/postal_code_textformfield.dart';
import 'package:firebase_login/widgets/textfields/textfield_widget.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:firebase_login/widgets/texts/text_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:provider/provider.dart';

class UserProfileDetailsAddress extends StatefulWidget {
  final Color profileBackgroundColor;
  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorCircularColor;
  final bool isEditMode;

  UserProfileDetailsAddress({
    this.profileBackgroundColor = CustomColors.backGroundColor,
    this.refreshIndicatorBackgroundColor = CustomColors.primaryColor,
    this.refreshIndicatorCircularColor = CustomColors.backGroundColor,
    this.isEditMode = false,
  });
  @override
  _UserProfileDetailsAddressState createState() => _UserProfileDetailsAddressState();
}

class _UserProfileDetailsAddressState extends State<UserProfileDetailsAddress> {
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

  Widget _addressEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address'),
        AddressTextFormField(
          decoration: InputDecoration(
              hintText: 'New Address',
              labelText: _queryStore.getTheUser.address!=null? _queryStore.getTheUser.address: ""),
        )
      ],
    );
  }

  Widget _postalCodeEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PostalCode'),
        PostalCodeTextFormField(
          decoration: InputDecoration(
              hintText: 'New Postal Code',
              labelText: _queryStore.getTheUser.postalCode!=null? _queryStore.getTheUser.postalCode: ""),
        )
      ],
    );
  }

  Widget _cityEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('City'),
        CityTextFormField(
          decoration: InputDecoration(
              hintText: 'New City',
              labelText: _queryStore.getTheUser.city!=null? _queryStore.getTheUser.city: ""),
        )
      ],
    );
  }

  Widget _address() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address: '),
        Text(
          _queryStore.getTheUser.address!=null? _queryStore.getTheUser.address: "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _postalCode() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Postal Code: '),
        Text(
          _queryStore.getTheUser.postalCode!=null? _queryStore.getTheUser.postalCode: "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _city() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('City: '),
        Text(
          _queryStore.getTheUser.city!=null? _queryStore.getTheUser.city: "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
              SizedBox(height: 10),
              widget.isEditMode ? _addressEdit() : _address(),
              SizedBox(height: 10),
              widget.isEditMode ? _postalCodeEdit() : _postalCode(),
              SizedBox(height: 10),
              widget.isEditMode ? _cityEdit() : _city()
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
