import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../widgets/textfields/textfield_widget.dart';
import 'package:provider/provider.dart';

class PostalCodeTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  PostalCodeTextFormField({this.decoration = const InputDecoration()});

  @override
  _PostalCodeTextFormFieldState createState() => _PostalCodeTextFormFieldState();
}

class _PostalCodeTextFormFieldState extends State<PostalCodeTextFormField> {
  TextEditingController _postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: widget.decoration.labelText != null ? null : 'Postal Code',
          inputType: TextInputType.text,
          icon: Icons.location_city,
          iconColor: Colors.white70,
          textController: _postalCodeController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setPostalCode(_postalCodeController.text);
          },
          errorText: _store.formErrorStore.postalCode,
        );
      },
    );
  }
}
