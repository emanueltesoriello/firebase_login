import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class RegisterButton extends StatefulWidget {
  final String text;
  RegisterButton({this.text = 'Register'});
  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: widget.text,
          textColor: Colors.white,
          buttonColor: _formStore.canRegister ? null : Colors.grey,
          onPressed: () async {
            print('Register pressed');
            if (_formStore.canRegister) {
              DeviceUtils.hideKeyboard(context);
              await _userStore.registerUser(_formStore.userName,
                  _formStore.userEmail, _formStore.password);
              if (_userStore.errorStore.errorMessage.isNotEmpty) {
                print(_userStore.errorStore.errorMessage);
                //_showErrorMessage(context, _userStore.errorStore.errorMessage);
              }
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
