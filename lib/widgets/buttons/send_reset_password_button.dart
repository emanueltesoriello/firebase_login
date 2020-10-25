import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class SendResetPasswordButton extends StatefulWidget {
  @override
  _SendResetPasswordButtonState createState() =>
      _SendResetPasswordButtonState();
}

class _SendResetPasswordButtonState extends State<SendResetPasswordButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: 'Send password',
          textColor: Colors.white,
          buttonColor: _formStore.canForgetPassword ? null : Colors.grey,
          onPressed: () async {
            print('Send reset password button pressed');
            if (_formStore.canForgetPassword) {
              DeviceUtils.hideKeyboard(context);
              await _userStore.sendResetPassword(_formStore.userEmail);
              if (_userStore.errorStore.errorMessage.isNotEmpty) {
                print(_userStore.errorStore.errorMessage);
              }
              _formStore.reset();
              Navigator.of(context).pop();
            } else {
              print('Please fill in correctly the email');
            }
          },
        );
      },
    );
  }
}
