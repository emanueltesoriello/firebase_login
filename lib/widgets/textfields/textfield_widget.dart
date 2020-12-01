import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData icon;
  final String hint;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final ValueChanged onChanged;
  final bool autoFocus;
  final TextInputAction inputAction;
  final InputDecoration decoration;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.inputType,
    this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // InputDecoration
    return TextFormField(
      controller: widget.textController,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      autofocus: widget.autoFocus,
      textInputAction: widget.inputAction,
      obscureText: widget.isObscure,
      maxLength: 50,
      keyboardType: widget.inputType,
      style: Theme.of(context).textTheme.body1,
      decoration: widget.decoration.copyWith(
        hintText: widget.hint,
        /* hintStyle:
                Theme.of(context).textTheme.body1.copyWith(color: hintColor),*/
        errorText: widget.errorText,
        counterText: '',
      ),
    );
  }
}
