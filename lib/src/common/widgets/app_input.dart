import 'package:flutter/material.dart';

class AppInput<T> extends StatelessWidget {
  final String? name;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function(String?)? onSave;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const AppInput({
    super.key,
    required this.name,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.keyboardType,
    this.onSave,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onSaved: onSave,
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: const OutlineInputBorder(),
        labelText: name,
      ),
    );
  }
}
