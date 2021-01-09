import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../widgets/textfields/textfield_widget.dart';
import 'package:provider/provider.dart';

class PhoneNumberTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  PhoneNumberTextFormField({this.decoration = const InputDecoration()});

  @override
  _PhoneNumberTextFormFieldState createState() => _PhoneNumberTextFormFieldState();
}

class _PhoneNumberTextFormFieldState extends State<PhoneNumberTextFormField> {
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: widget.decoration.labelText != null ? null : 'Phone Number',
          inputType: TextInputType.text,
          icon: Icons.location_city,
          iconColor: Colors.white70,
          textController: _phoneNumberController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setPhoneNumber(_phoneNumberController.text);
          },
          errorText: _store.formErrorStore.phoneNumber,
        );
      },
    );
  }
}
