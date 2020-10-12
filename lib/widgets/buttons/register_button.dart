import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class RegisterButton extends StatefulWidget {
  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  /*_showErrorMessage(BuildContext ctx, String message) {
    Future.delayed(Duration(milliseconds: 2000), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: 'Error',
          duration: Duration(seconds: 3),
        )..show(ctx);
      }
    });

    return SizedBox.shrink();
  }*/

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: 'Register',
          textColor: Colors.white,
          buttonColor: _formStore.canRegister ? Colors.green : Colors.red,
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
