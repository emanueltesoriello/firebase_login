import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatefulWidget {
  final String text;
  LoginButton({this.text = 'Login'});
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: widget.text,
          textColor: Colors.white,
          buttonColor: _formStore.canLogin ? null : Colors.grey,
          onPressed: () async {
            print('Sign in pressed');
            if (_formStore.canLogin) {
              DeviceUtils.hideKeyboard(context);
              await _userStore.loginUsers(
                  _formStore.userEmail, _formStore.password);
              if (_userStore.errorStore.errorMessage.isNotEmpty) {
                print(_userStore.errorStore.errorMessage);
                // _showErrorMessage(_userStore.errorStore.errorMessage);
              }
              if (_userStore.errorStore.errorMessage != 'Email not verified!')
                _formStore.reset();
            } else {
              print('Please fill in correctly all the fields');
            }
          },
        );
      },
    );
  }
}
