import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/widgets/buttons/save_new_company_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/textfields/chamber_of_commerce_textformfield.dart';
import 'package:firebase_login/widgets/textfields/company_name_textformfield.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NoCompany extends StatefulWidget {
  @override
  _NoCompanyState createState() => _NoCompanyState();
}

class _NoCompanyState extends State<NoCompany> {
  double targetWidth;
  double targetHeight;
  QueryStore _queryStore;

  @override
  void initState() {
    super.initState();
    _queryStore = context.read();
  }

  Icon switchIcon(String labelText) {
    Icon icon;
    switch (labelText) {
      case 'Chamber of Commerce no.':
        icon = Icon(Icons.account_balance, color: Colors.orange);
        break;
      case 'Company name':
        icon = Icon(Icons.title, color: Colors.orange);
        break;
      default:
    }
    return icon;
  }

  InputDecoration textfieldInputDecoration(String labelText) {
    return InputDecoration(
      prefixIcon: switchIcon(labelText),
      labelText: labelText,
      //labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
      filled: true,
      hasFloatingPlaceholder: false,
      fillColor: Color.fromRGBO(254, 254, 252, 1),
      border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(targetHeight / 40 / 2))),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(targetHeight / 40 / 2 - 10)),
          borderSide: BorderSide(color: Colors.red)),
      errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(targetHeight / 40 / 2 - 10)),
          borderSide: BorderSide(color: Colors.red)),
    );
  }

  Widget _buildCompanyVatTextField() {
    return Container(
      width: targetWidth / 1.12,
      height: targetHeight / 14,
      child: ChamberOfCommerceTextFormField(
        decoration: textfieldInputDecoration('Chamber of Commerce no.'),
      ),
    );
  }

  Widget _buildCompanyNameTextField() {
    return Container(
      width: targetWidth / 1.12,
      height: targetHeight / 14,
      child: CompanyNameTextFormField(
        decoration: textfieldInputDecoration('Company name'),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Welcome!', style: TextStyle(fontSize: 40)),
        SizedBox(height: targetHeight / 50),
        Text(
            "To understand your business and help you set up the ultimate marketing plan we need to have some more info.",
            style: TextStyle(height: 1.5)),
      ],
    );
  }

  Widget _saveButton() {
    return Container(
      height: targetHeight / 16,
      width: targetWidth / 1.2,
      child: GenericRoundedButtonDecoration(
        buttonColor: Colors.blue,
        splashColor: Colors.blue[100],
        disabledColor: Colors.grey,
        child: SaveButton(),
      ),
    );
  }

  showMessage() {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createInformation(
        message: _queryStore.errorStore.errorMessage,
        title: 'Attention!',
        duration: Duration(seconds: 60),
      )..show(context);
    });

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    targetWidth = deviceWidth;
    targetHeight = deviceHeight;
    return Observer(
      builder: (_) {
        if (_queryStore.errorStore.errorMessage.isNotEmpty) {
          print('ERROR: ' + _queryStore.errorStore.errorMessage);
          showMessage();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
          body: Container(
            padding: EdgeInsets.only(
                left: targetHeight / 30,
                right: targetHeight / 30,
                top: targetHeight / 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(children: <Widget>[
                  _buildDescription(),
                  SizedBox(height: targetHeight / 20),
                  _buildCompanyVatTextField(),
                  Container(height: targetHeight / 50, width: targetWidth),
                  _buildCompanyNameTextField(),
                ]),
                Container(
                    width: targetWidth / 2.2,
                    height: targetHeight / 20,
                    margin: EdgeInsets.only(bottom: targetHeight / 30),
                    child: _saveButton()),
              ],
            ),
          ),
        );
      },
    );
  }
}
