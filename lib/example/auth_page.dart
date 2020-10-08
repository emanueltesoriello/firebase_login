import 'package:firebase_login/widgets/buttons/register_button.dart';
import 'package:firebase_login/widgets/textfields/confirm_password_textformfield.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:flutter/material.dart';
import '../widgets/buttons/forgot_password_button.dart';
import '../widgets/buttons/signin_button.dart';
import '../widgets/textfields/password_textformfield.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => Scaffold(
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
}
