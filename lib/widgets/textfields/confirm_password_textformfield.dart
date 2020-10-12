import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import 'textfield_widget.dart';
import 'package:provider/provider.dart';

class ConfirmPasswordTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  ConfirmPasswordTextFormField({this.decoration = const InputDecoration()});

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<ConfirmPasswordTextFormField> {
  FocusNode _passwordFocusNode;
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          //decoration: widget.decoration,
          hint: 'Confirm your Password',
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: Colors.white70,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.confirmPassword,
          onChanged: (value) {
            _store.setConfirmPassword(_passwordController.text);
          },
        );
      },
    );
  }
}
