import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../widgets/textfields/textfield_widget.dart';
import 'package:provider/provider.dart';

class UsernameTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  UsernameTextFormField({this.decoration = const InputDecoration()});

  @override
  _UsernameTextFormFieldState createState() => _UsernameTextFormFieldState();
}

class _UsernameTextFormFieldState extends State<UsernameTextFormField> {
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: 'Type your Username',
          inputType: TextInputType.text,
          icon: Icons.person,
          iconColor: Colors.white70,
          textController: _usernameController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setUserName(_usernameController.text);
          },
          errorText: _store.formErrorStore.userName,
        );
      },
    );
  }
}
