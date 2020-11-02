import 'package:firebase_login/stores/query_store.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class SendMagicCodeButton extends StatefulWidget {
  final String text;
  SendMagicCodeButton({this.text = 'Use Magic Code'});
  @override
  _SendMagicCodeButtonState createState() => _SendMagicCodeButtonState();
}

class _SendMagicCodeButtonState extends State<SendMagicCodeButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        QueryStore _queryStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: widget.text,
          textColor: Colors.white,
          buttonColor: _formStore.canInsertMagicCode ? null : Colors.grey,
          onPressed: () async {
            print('Send magic code button pressed');
            if (_formStore.canInsertMagicCode) {
              DeviceUtils.hideKeyboard(context);
              Navigator.of(context).pop();
              await _queryStore.checkMagicCode(_formStore.magicCode);
              if (_queryStore.errorStore.errorMessage.isNotEmpty) {
                print(_queryStore.errorStore.errorMessage);
              }
              _formStore.reset();
            } else {
              print('Please fill in correctly the email');
            }
          },
        );
      },
    );
  }
}
