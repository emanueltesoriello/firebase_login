import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import 'textfield_widget.dart';
import 'package:provider/provider.dart';

class ChamberOfCommerceTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  ChamberOfCommerceTextFormField({this.decoration = const InputDecoration()});

  @override
  _ChamberOfCommerceTextFormFieldState createState() =>
      _ChamberOfCommerceTextFormFieldState();
}

class _ChamberOfCommerceTextFormFieldState
    extends State<ChamberOfCommerceTextFormField> {
  TextEditingController _chamberOfCommerceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: widget.decoration.labelText != null
              ? null
              : 'Chamber of Commerce no.',
          inputType: TextInputType.text,
          icon: Icons.person,
          iconColor: Colors.white70,
          textController: _chamberOfCommerceController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setChamberOfCommerce(_chamberOfCommerceController.text);
          },
          errorText: _store.formErrorStore.chamberOfCommerce,
        );
      },
    );
  }
}
