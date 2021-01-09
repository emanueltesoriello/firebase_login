import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/models/user.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/textfields/address_textformfield.dart';
import 'package:firebase_login/widgets/textfields/city_textformfield.dart';
import 'package:firebase_login/widgets/textfields/postal_code_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UserProfileDetailsAddress extends StatefulWidget {
  final Color profileBackgroundColor;
  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorCircularColor;
  final bool isEditMode;
  User user;

  UserProfileDetailsAddress({
    this.profileBackgroundColor = CustomColors.backGroundColor,
    this.refreshIndicatorBackgroundColor = CustomColors.primaryColor,
    this.refreshIndicatorCircularColor = CustomColors.backGroundColor,
    this.isEditMode = false,
    @required this.user
  });

  @override
  _UserProfileDetailsAddressState createState() =>
      _UserProfileDetailsAddressState();
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
              labelText: widget.user.address != null
                  ? widget.user.address
                  : ""),
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
              labelText: widget.user.postalCode != null
                  ? widget.user.postalCode
                  : ""),
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
              labelText: widget.user.city != null
                  ? widget.user.city
                  : ""),
        )
      ],
    );
  }

  Widget _address() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.user.address != null
            ? widget.user.address
            : ""),
      ],
    );
  }

  Widget _postalCode() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Postal Code: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.user.postalCode != null
            ? widget.user.postalCode
            : ""),
      ],
    );
  }

  Widget _city() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('City: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.user.city != null
            ? widget.user.city
            : ""),
      ],
    );
  }

  Widget _userProfileAddressDetails() {
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
    return Observer(
      builder: (_) {
        return _userProfileAddressDetails();
      },
    );
  }
}
