import 'package:firebase_login/stores/query_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatefulWidget {
  final String text;
  SaveButton({this.text = 'Create new company'});
  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        QueryStore _queryStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: widget.text,
          textColor: Colors.white,
          buttonColor: _formStore.canAddCompany ? null : Colors.grey,
          onPressed: () async {
            print('Save new Company pressed');
            if (_formStore.canAddCompany) {
              DeviceUtils.hideKeyboard(context);
              await _queryStore.addNewCompany(
                  _formStore.chamberOfCommerce, _formStore.companyName);
              if (_queryStore.errorStore.errorMessage.isNotEmpty) {
                print(_queryStore.errorStore.errorMessage);
                // _showErrorMessage(_userStore.errorStore.errorMessage);
              }
            } else {
              print('Please fill in correctly all the fields');
            }
            _formStore.reset();
          },
        );
      },
    );
  }
}
