import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/register_button.dart';
import 'package:firebase_login/widgets/dialogs/reset_pwd_dialog.dart';
import 'package:firebase_login/widgets/textfields/confirm_password_textformfield.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../widgets/buttons/signin_button.dart';
import '../widgets/textfields/password_textformfield.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  _showSendEmailValidationDialog() {
    return showDialog(
      context: context.read(),
      builder: (context) {
        return ResetPwdDialog(
          title: 'Insert your e-mail',
        );
      },
    );
  }

  _showErrorMessage(String message) {
    if (message == 'Email not verified!') {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message != null && message.isNotEmpty) {
          FlushbarHelper.createAction(
              message: message,
              title: 'Error',
              duration: Duration(seconds: 50),
              button: FlatButton(
                  onPressed: null,//_showSendEmailValidationDialog(),
                  child: Text(
                    "Didn't receive any email?",
                    style: TextStyle(color: Colors.white),
                  )))
            ..show(context);
        }
      });
    } else {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message != null && message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: 'Error',
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          UserStore _userStore = context.read();
          if (_userStore.errorStore.errorMessage.isNotEmpty) {
            print(_userStore.errorStore.errorMessage);
            _showErrorMessage(_userStore.errorStore.errorMessage);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(!isLogin ? 'Register' : 'Login'),
            ),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    !isLogin ? UsernameTextFormField() : Container(),
                    SizedBox(height: 10),
                    EmailTextFormField(),
                    SizedBox(height: 10),
                    PasswordTextFormField(),
                    SizedBox(height: 10),
                    !isLogin ? ConfirmPasswordTextFormField() : Container(),
                    SizedBox(height: 10),
                    SizedBox(
                        height:
                            30), //!isLogin ? ForgotPasswordButton() : Container(),
                    SizedBox(height: 10),
                    !isLogin ? RegisterButton() : SigninButton(),
                    SizedBox(height: 10),
                    SwitchListTile(
                      title: Text('Register/Login'),
                      value: isLogin,
                      onChanged: (newValue) {
                        setState(() {
                          isLogin = newValue;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
}
