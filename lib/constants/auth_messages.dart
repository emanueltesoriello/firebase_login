import 'package:firebase_login/stores/form_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/utilities/device_utils.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class ShowMessage {
  final String message;
  final BuildContext context;
  final FormStore formStore;
  final UserStore userStore;
  ShowMessage(this.message, this.context, this.formStore, this.userStore);

  _sendEmailValidation() async {
    print('Send email validation button pressed');
    if (formStore.canSendEmailValidation) {
      DeviceUtils.hideKeyboard(context);
      await userStore.sendEmailValidationUser(
          formStore.userEmail, formStore.password);
      if (userStore.errorStore.errorMessage.isNotEmpty) {
        print(userStore.errorStore.errorMessage);
      }
      formStore.reset();
    } else {
      print('Please fill in correctly all the fields');
    }
  }

  showMessage() {
    if (message == 'Registration successfull') {
      Future.delayed(Duration(milliseconds: 0), () {
        FlushbarHelper.createInformation(
          message:
              'Please check the email that we have just sent you to validate your email.',
          title: 'Registration successfull!',
          duration: Duration(seconds: 4),
        )..show(context);
      });
    } else if (message == 'Email validation sent') {
      Future.delayed(Duration(milliseconds: 0), () {
        FlushbarHelper.createInformation(
          message:
              'Please check the email that we have just sent you to validate your email.',
          title: 'Email sent!',
          duration: Duration(seconds: 4),
        )..show(context);
      });
    } else if (message == 'Email with new password sent') {
      Future.delayed(Duration(milliseconds: 0), () {
        FlushbarHelper.createInformation(
          message:
              'Please check the email that we have just sent you to reset your password.',
          title: 'Email sent!',
          duration: Duration(seconds: 4),
        )..show(context);
      });
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
}
