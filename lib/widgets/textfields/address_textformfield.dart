import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../widgets/textfields/textfield_widget.dart';
import 'package:provider/provider.dart';

class AddressTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  AddressTextFormField({this.decoration = const InputDecoration()});

  @override
  _AddressTextFormFieldState createState() => _AddressTextFormFieldState();
}

class _AddressTextFormFieldState extends State<AddressTextFormField> {
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: widget.decoration.labelText != null ? null : 'Address',
          inputType: TextInputType.text,
          icon: Icons.location_city,
          iconColor: Colors.white70,
          textController: _addressController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setAddress(_addressController.text);
          },
          errorText: _store.formErrorStore.address,
        );
      },
    );
  }
}
