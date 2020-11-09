import 'package:firebase_login/constants/auth_messages.dart';
import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/services/launch_url.dart';
import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/buttons/forgot_password_button.dart';
import 'package:firebase_login/widgets/buttons/register_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/switches/accept_privacy_switch.dart';
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
  final String registerImageURL;
  final String loginImageURL;
  final bool useAsset;
  final String registerImageAsset;
  final String loginImageAsset;
  final Color backgroundColor;
  final Color buttonColor;
  final Color buttonSplashColor;
  final Color buttonDisabledColor;
  final Color switchToSignupColor;
  final String backgroundImageAsset;
  final Radius buttonsBorderRadius;
  final InputDecoration textFormFieldsDdecoration;
  final String privacyText;
  final String privacyURL;
  final String forgotPasswordText;
  final String popupImageAsset;

  AuthPage({
    this.appName = '[APP_NAME]',
    this.loginDescription = 'Small description for login',
    this.signupDescription = 'Small description for signup',
    this.registerImageURL =
        'https://marketinggenius.nl/wp-content/uploads/2020/09/Marketing_Genius_Raket-Circle_BLAUW_500-1280x1280.png',
    this.loginImageURL =
        'https://marketinggenius.nl/wp-content/uploads/2020/09/Marketing_Genius_Raket-Circle_BLAUW_500-1280x1280.png',
    this.backgroundColor = Colors.white,
    this.buttonColor = CustomColors.primaryColor,
    this.buttonSplashColor = CustomColors.backGroundColor,
    this.buttonDisabledColor = Colors.grey,
    this.switchToSignupColor = CustomColors.primaryColor,
    this.backgroundImageAsset = 'web/images/desktop_background.jpg',
    @required this.useAsset,
    this.registerImageAsset = 'web/images/logo.png',
    this.buttonsBorderRadius = const Radius.circular(90),
    this.loginImageAsset = 'web/images/logo.png',
    this.privacyText =
        "I've read the privacy statement and the terms and I fully agree with them.",
    this.privacyURL =
        "https://rocketroadmap.com/privacy-statement-rocket-roadmap/",
    this.textFormFieldsDdecoration = const InputDecoration(),
    this.popupImageAsset = 'web/images/logo.png',
    this.forgotPasswordText = 'Forgot password?',
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
        borderRadius: widget.buttonsBorderRadius,
        buttonColor: widget.buttonColor,
        splashColor: widget.buttonSplashColor,
        disabledColor: widget.buttonDisabledColor,
        child: LoginButton(),
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      height: targetHeight / 16,
      width: targetWidth / 1.2,
      child: GenericRoundedButtonDecoration(
        borderRadius: widget.buttonsBorderRadius,
        buttonColor: widget.buttonColor,
        splashColor: widget.buttonSplashColor,
        disabledColor: widget.buttonDisabledColor,
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

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.useAsset
                ? Image.asset(
                    !isLogin
                        ? widget.registerImageAsset
                        : widget.loginImageAsset,
                    height: targetHeight / 5,
                  )
                : FadeInImage.memoryNetwork(
                    height: targetHeight / 5,
                    placeholder: kTransparentImage,
                    image: !isLogin
                        ? widget.registerImageURL
                        : widget.loginImageURL),
            SizedBox(height: 20),
            _titleAndSubtitle(),
            !isLogin
                ? UsernameTextFormField(
                    decoration: widget.textFormFieldsDdecoration)
                : Container(),
            SizedBox(height: 5),
            EmailTextFormField(decoration: widget.textFormFieldsDdecoration),
            SizedBox(height: 5),
            PasswordTextFormField(decoration: widget.textFormFieldsDdecoration),
            SizedBox(height: 5),
            !isLogin
                ? ConfirmPasswordTextFormField(
                    decoration: widget.textFormFieldsDdecoration)
                : Container(),
            SizedBox(height: 5),
            isLogin
                ? ForgotPasswordButton(
                    text: widget.forgotPasswordText,
                    popupImageAsset: widget.popupImageAsset,
                    buttonBorderRadius: widget.buttonsBorderRadius,
                    buttonColor: widget.buttonColor,
                    buttonDisabledColor: widget.buttonDisabledColor,
                    buttonSplashColor: widget.buttonSplashColor,
                  )
                : Container(),
            SizedBox(height: 10),
            !isLogin ? _registerButton() : _loginButton(),
            SizedBox(height: 10),
            !isLogin
                ? AcceptPrivacySwitch(
                    text: widget.privacyText,
                    privacyUrl: widget.privacyURL,
                    switchActiveColor: widget.switchToSignupColor,
                  )
                : Container(),
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
                      style: TextStyle(color: widget.switchToSignupColor))
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
                            image: AssetImage(widget.backgroundImageAsset))),
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
