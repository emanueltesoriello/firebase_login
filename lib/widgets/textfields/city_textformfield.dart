import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../stores/form_store.dart';
import '../../widgets/textfields/textfield_widget.dart';
import 'package:provider/provider.dart';

class CityTextFormField extends StatefulWidget {
  final InputDecoration decoration;
  CityTextFormField({this.decoration = const InputDecoration()});

  @override
  _CityTextFormFieldState createState() => _CityTextFormFieldState();
}

class _CityTextFormFieldState extends State<CityTextFormField> {
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        FormStore _store = context.read();
        return TextFieldWidget(
          decoration: widget.decoration,
          hint: widget.decoration.labelText != null ? null : 'City',
          inputType: TextInputType.text,
          icon: Icons.location_city,
          iconColor: Colors.white70,
          textController: _cityController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setCity(_cityController.text);
          },
          errorText: _store.formErrorStore.city,
        );
      },
    );
  }
}
