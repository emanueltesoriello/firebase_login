import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/widgets/restart_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import '../../stores/user_store.dart';
import '../../widgets/buttons/transparent_button_widget.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatefulWidget {
  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
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
    return TransparentButtonWidget(
      buttonText: 'Logout',
      textColor: Colors.white,
      buttonColor: Colors.orange,
      onPressed: () async {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        print('Logout pressed');
        await _userStore.logout();
        if (_userStore.errorStore.errorMessage.isNotEmpty) {
          print(_userStore.errorStore.errorMessage);
          _showErrorMessage(_userStore.errorStore.errorMessage);
        } else {
          RestartWidget.restartApp(context);
          _formStore.reset();
        }
      },
    );
  }
}
