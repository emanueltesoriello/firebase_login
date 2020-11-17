import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import 'transparent_button_widget.dart';
import 'package:provider/provider.dart';

class SendNewEmailButton extends StatefulWidget {
  final String text;
  SendNewEmailButton({this.text = 'Change email'});
  @override
  _SendNewEmailButtonState createState() => _SendNewEmailButtonState();
}

class _SendNewEmailButtonState extends State<SendNewEmailButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        UserStore _userStore = context.read();
        FormStore _formStore = context.read();
        return TransparentButtonWidget(
          buttonText: widget.text,
          textColor: Colors.white,
          buttonColor: _formStore.canSendNewEmail ? null : Colors.grey,
          onPressed: () async {
            print('Change  email button pressed');
            if (_formStore.canSendNewEmail) {
              DeviceUtils.hideKeyboard(context);
              await _userStore.updateEmail(_userStore.getAuth.currentUser.email,
                  _formStore.password, _formStore.userEmail);
              if (_userStore.errorStore.errorMessage.isNotEmpty) {
                print(_userStore.errorStore.errorMessage);
              }
              _formStore.reset();
              Navigator.of(context).pop();
            } else {
              print('Please fill in correctly the email');
            }
          },
        );
      },
    );
  }
}
