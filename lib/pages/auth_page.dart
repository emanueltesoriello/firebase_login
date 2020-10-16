import 'package:firebase_login/constants/auth_messages.dart';
import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/forgot_password_button.dart';
import 'package:firebase_login/widgets/buttons/register_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/textfields/confirm_password_textformfield.dart';
import 'package:firebase_login/widgets/textfields/email_textformfield.dart';
import 'package:firebase_login/widgets/textfields/username_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../widgets/buttons/login_button.dart';
import '../widgets/textfields/password_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class AuthPage extends StatefulWidget {
  final String appName;
  final String loginDescription;
  final String signupDescription;

  AuthPage({
    this.appName = '[APP_NAME]',
    this.loginDescription = 'Small description for login',
    this.signupDescription = 'Small description for signup',
  });
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  double targetHeight;
  double targetWidth;
  FormStore _formStore;
  UserStore _userStore;

  @override
  void initState() {
    super.initState();
    _formStore = context.read();
    _userStore = context.read();
  }

  Widget _loginButton() {
    return Container(
      height: targetHeight / 16,
      width: targetWidth / 1.2,
      child: GenericRoundedButtonDecoration(
        buttonColor: Colors.blue,
        splashColor: Colors.blue[100],
        disabledColor: Colors.grey,
        child: LoginButton(),
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      height: targetHeight / 16,
      width: targetWidth / 1.2,
      child: GenericRoundedButtonDecoration(
        buttonColor: Colors.blue,
        splashColor: Colors.blue[100],
        disabledColor: Colors.grey,
        child: RegisterButton(),
      ),
    );
  }

  Widget _titleAndSubtitle() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
          isLogin
              ? "Welcome back to ${widget.appName}"
              : "Welcome to ${widget.appName}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: targetHeight / 40)),
      SizedBox(height: 5),
      Text(
        isLogin ? widget.loginDescription : widget.signupDescription,
      )
    ]);
  }

  Widget _buildAcceptSwitch() {
    return Container(
      width: targetWidth / 1.12,
      child: SwitchListTile(
        value: true,
        onChanged: (bool value) {
          print(value);
        },
        title: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => {},
          child: Text(
            "I've read the privacy statement and the terms and I fully agree with them.",
            style: Theme.of(context).textTheme.caption.copyWith(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: targetHeight / 60),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInImage.memoryNetwork(
              height: targetHeight / 5,
              placeholder: kTransparentImage,
              image:
                  'https://marketinggenius.nl/wp-content/uploads/2020/09/Marketing_Genius_Raket-Circle_BLAUW_500-1280x1280.png',
            ),
            SizedBox(height: 20),
            _titleAndSubtitle(),
            !isLogin ? UsernameTextFormField() : Container(),
            SizedBox(height: 5),
            EmailTextFormField(),
            SizedBox(height: 5),
            PasswordTextFormField(),
            SizedBox(height: 5),
            !isLogin ? ConfirmPasswordTextFormField() : Container(),
            SizedBox(height: 5),
            isLogin ? ForgotPasswordButton() : Container(),
            SizedBox(height: 10),
            !isLogin ? _registerButton() : _loginButton(),
            SizedBox(height: 10),
            !isLogin ? _buildAcceptSwitch() : Container(),
            !isLogin ? SizedBox(height: 5) : Container(),
            FlatButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(isLogin
                      ? "Don't have an account? "
                      : "Already have an account? "),
                  Text(isLogin ? "Sign up" : "Sign in",
                      style: TextStyle(color: Colors.blue))
                ])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          targetHeight = MediaQuery.of(context).size.height;
          targetWidth = MediaQuery.of(context).size.width;
          if (_userStore.errorStore.errorMessage.isNotEmpty) {
            print(_userStore.errorStore.errorMessage);
            var message = ShowMessage(_userStore.errorStore.errorMessage,
                context, _formStore, _userStore);
            message.showMessage();
          }
          return Scaffold(
            body: targetWidth > 830.0
                ? Container(
                    width: targetWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'web/images/desktop_background.jpg'))),
                    child: Center(
                      child: Container(
                          color: Colors.white,
                          width: targetWidth > 1920.0
                              ? targetWidth / 5
                              : targetWidth / 3,
                          height: targetHeight / 1.3,
                          alignment: Alignment.center,
                          child: _buildBody()),
                    ),
                  )
                : Center(
                    child: _buildBody(),
                  ),
          );
        },
      );
}
