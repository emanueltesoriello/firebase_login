import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/utilities/device_utils.dart';
import 'package:firebase_login/widgets/buttons/forgot_password_button.dart';
import 'package:firebase_login/widgets/buttons/register_button.dart';
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
  FormStore _formStore;
  UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _formStore = context.read();
    _userStore = context.read();
  }

  _sendEmailValidation() async {
    print('Send email validation button pressed');
    if (_formStore.canSendEmailValidation) {
      DeviceUtils.hideKeyboard(context);
      await _userStore.sendEmailValidationUser(
          _formStore.userEmail, _formStore.password);
      if (_userStore.errorStore.errorMessage.isNotEmpty) {
        print(_userStore.errorStore.errorMessage);
      }
      _formStore.reset();
    } else {
      print('Please fill in correctly all the fields');
    }
  }

  _showMessage(String message) {
    if (message == 'Email validation sent') {
      Future.delayed(Duration(milliseconds: 0), () {
        FlushbarHelper.createInformation(
          message:
              'Please check the email that we have just sent you to validate your email.',
          title: 'Email sent!',
          duration: Duration(seconds: 4),
        )..show(context);
      });

      return SizedBox.shrink();
    } else if (message == 'Email with new password sent') {
      Future.delayed(Duration(milliseconds: 0), () {
        FlushbarHelper.createInformation(
          message:
              'Please check the email that we have just sent you to reset your password.',
          title: 'Email sent!',
          duration: Duration(seconds: 4),
        )..show(context);
      });

      return SizedBox.shrink();
    } else if (message == 'Email not verified!') {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message != null && message.isNotEmpty) {
          FlushbarHelper.createAction(
              message: message,
              title: 'Error',
              duration: Duration(seconds: 6),
              button: FlatButton(
                  onPressed: () => _sendEmailValidation(),
                  child: Text(
                    "Didn't receive any email?\nSend again",
                    textAlign: TextAlign.right,
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
          if (_userStore.errorStore.errorMessage.isNotEmpty) {
            print(_userStore.errorStore.errorMessage);
            _showMessage(_userStore.errorStore.errorMessage);
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
                    isLogin ? ForgotPasswordButton() : Container(),
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
