import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import '../../widgets/buttons/transparent_button_widget.dart';
import 'package:provider/provider.dart';

class SigninButton extends StatefulWidget {
  @override
  _SigninButtonState createState() => _SigninButtonState();
}

class _SigninButtonState extends State<SigninButton> {
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: 'Error',
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: 'Sign in',
          textColor: Colors.white,
          buttonColor: _formStore.canLogin ? Colors.green : Colors.red,
          onPressed: () async {
            print('Sign in pressed');
            if (_formStore.canLogin) {
              DeviceUtils.hideKeyboard(context);
              await _userStore.loginUsers(
                  _formStore.userEmail, _formStore.password);
              if (_userStore.errorStore.errorMessage.isNotEmpty) {
                print(_userStore.errorStore.errorMessage);
                _showErrorMessage(_userStore.errorStore.errorMessage);
              }
              _formStore.reset();
            } else {
              _showErrorMessage('Please fill in all fields');
            }
          },
        );
      },
    );
  }
}
