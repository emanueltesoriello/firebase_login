import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import 'textfield_widget.dart';
import 'package:provider/provider.dart';

class CompanyNameTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  CompanyNameTextFormField({this.decoration = const InputDecoration()});

  @override
  _CompanyNameTextFormFieldState createState() =>
      _CompanyNameTextFormFieldState();
}

class _CompanyNameTextFormFieldState extends State<CompanyNameTextFormField> {
  TextEditingController _companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: widget.decoration.labelText != null ? null : 'Company name',
          inputType: TextInputType.text,
          icon: Icons.person,
          iconColor: Colors.white70,
          textController: _companyNameController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setCompanyName(_companyNameController.text);
          },
          errorText: _store.formErrorStore.companyName,
        );
      },
    );
  }
}
