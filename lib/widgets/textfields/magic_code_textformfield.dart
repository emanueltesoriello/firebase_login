import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import 'textfield_widget.dart';
import 'package:provider/provider.dart';

class MagicCodeTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  MagicCodeTextFormField({this.decoration = const InputDecoration()});

  @override
  _MagicCodeTextFormFieldState createState() => _MagicCodeTextFormFieldState();
}

class _MagicCodeTextFormFieldState extends State<MagicCodeTextFormField> {
  TextEditingController _magicCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: 'Magic Code',
          inputType: TextInputType.text,
          icon: Icons.person,
          iconColor: Colors.white70,
          textController: _magicCodeController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setMagicCode(_magicCodeController.text);
          },
          errorText: _store.formErrorStore.magicCode,
        );
      },
    );
  }
}
