import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../widgets/textfields/textfield_widget.dart';
import 'package:provider/provider.dart';

class EmailTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  EmailTextFormField({this.decoration = const InputDecoration()});

  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  TextEditingController _userEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          //decoration: widget.decoration,
          hint: 'Email',
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: Colors.white70,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }
}
