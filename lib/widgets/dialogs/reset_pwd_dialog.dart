import 'package:firebase_login/widgets/dialogs/reset_pwd_status.dart';
import 'package:flutter/material.dart';

class ResetPwdDialog extends StatelessWidget {
  double targetHeight;
  double targetWidth;
  Map<String, dynamic> _formData = {
    'email': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String title;

  ResetPwdDialog({
    @required this.title,
  });

  Widget _appBar() {
    return Container(
      width: targetWidth,
      child: Center(
        child: Text(
          title ?? '_',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: targetHeight / 40,
          ),
        ),
      ),
    );
  }

  void resetPwd(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    String status =
        'Error'; //await userStore.resetPassword(email: _formData['email']);
    print('Tutto: ' + status);
    if (status == 'ok') {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ResetPwdStatusDialog(
            title: "Successful!",
            description:
                "Please, check your email to complete the password reset.",
          );
        },
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return ResetPwdStatusDialog(
            title: "Error!",
            description:
                "We were unable to reset the password for the email you entered.",
          );
        },
      );
    }
  }

  Widget resetPwdButton() {
    return FlatButton(
      color: Colors.green,
      onPressed: () {
        //resetPwd(model, context);
      },
      child: Center(
        child: Text('Reset your password'),
      ),
    );
  }

  InputDecoration textfieldInputDecoration(String labelText) {
    return InputDecoration(
      prefixIcon: Icon(Icons.email, color: Colors.red),
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
      filled: true,
      hasFloatingPlaceholder: false,
      fillColor: Color.fromRGBO(254, 254, 252, 1),
      border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(targetHeight / 40 / 2))),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(targetHeight / 40 / 2 - 10)),
          borderSide: BorderSide(color: Colors.red)),
      errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(targetHeight / 40 / 2 - 10)),
          borderSide: BorderSide(color: Colors.red)),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      width: targetWidth / 1.12,
      height: targetHeight / 14, //targetHeight / 17.8,
      child: TextFormField(
        decoration: textfieldInputDecoration('E-Mail'),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        onSaved: (String value) {
          _formData['email'] = value;
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: targetWidth / 25, right: targetWidth / 25),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.11),
              blurRadius: 10.0,
              spreadRadius: 5,
            )
          ]),
          child: _buildEmailTextField(),
        ),
        resetPwdButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    targetHeight = MediaQuery.of(context).size.height;
    targetWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Form(
        key: _formKey,
        child: Theme(
          data: ThemeData(
            brightness: Brightness.light,
          ),
          child: Container(
            height: targetHeight / 2.6,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(flex: 18, child: _appBar()),
                Expanded(
                  flex: 40,
                  child: _body(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
