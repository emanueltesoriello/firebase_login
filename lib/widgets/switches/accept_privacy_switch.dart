import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/services/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../stores/user_store.dart';
import '../../utilities/device_utils.dart';
import 'package:provider/provider.dart';

class AcceptPrivacySwitch extends StatefulWidget {
  final String text;
  final String privacyUrl;
  final Color switchActiveColor;

  AcceptPrivacySwitch(
      {@required this.text,
      @required this.privacyUrl,
      @required this.switchActiveColor});
  @override
  _AcceptPrivacySwitchState createState() => _AcceptPrivacySwitchState();
}

class _AcceptPrivacySwitchState extends State<AcceptPrivacySwitch> {
  FormStore _formStore;

  @override
  void initState() {
    super.initState();
    _formStore = context.read();
  }

  Widget _buildAcceptSwitch() {
    var style = Theme.of(context).textTheme.caption.copyWith(
        decoration: TextDecoration.none,
        fontSize: MediaQuery.of(context).size.height / 55);
    return Container(
      width: MediaQuery.of(context).size.width / 1.12,
      child: SwitchListTile(
        activeColor: widget.switchActiveColor,
        value: _formStore.acceptPrivacySwitch,
        onChanged: (bool value) {
          print(value);
          _formStore.setAcceptPrivacySwitch(value);
        },
        title: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => launchURL(widget.privacyUrl),
          child: Text(
            widget.text,
            style: style,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return _buildAcceptSwitch();

        /* TransparentButtonWidget(
          buttonText: widget.text,
          textColor: Colors.white,
          buttonColor: _formStore.canRegister ? null : Colors.grey,
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
        );*/
      },
    );
  }
}
