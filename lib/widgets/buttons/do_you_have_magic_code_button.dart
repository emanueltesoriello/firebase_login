import 'package:firebase_login/widgets/dialogs/magic_code_dialog.dart';
import 'package:flutter/material.dart';

class DoYouHaveMagicCodeButton extends StatefulWidget {
  @override
  _DoYouHaveMagicCodeButtonState createState() => _DoYouHaveMagicCodeButtonState();
}

class _DoYouHaveMagicCodeButtonState extends State<DoYouHaveMagicCodeButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(
          'Do you have a Magic Code?',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(decoration: TextDecoration.underline),
        ),
        onPressed: () async {
          showDialog(context: context, child: MagicCodeDialog());
        },
      ),
    );
  }
}
