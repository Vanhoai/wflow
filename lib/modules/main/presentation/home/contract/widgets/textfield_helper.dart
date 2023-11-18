import 'package:flutter/material.dart';

class TextFieldHelper extends StatelessWidget {
  const TextFieldHelper({
    super.key,
    this.enabled = true,
    required this.controller,
    this.maxLines = 5,
    this.hintText = '',
    this.minLines = 1,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChange
  });

  final bool enabled;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final String hintText;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;
  final String Function(String?)? validator;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return TextFormField(
      enabled: enabled,
      validator: validator,
      controller: controller,
      onChanged: onChange,
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      style: themeData.textTheme.displayMedium!.merge(TextStyle(
        color: Colors.black.withOpacity(0.5),
      )),
      minLines: maxLines,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      keyboardAppearance: Brightness.light,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey[100],
        filled: true,
        isDense: true,
        hintText: hintText,
        hintStyle: themeData.textTheme.displayMedium!.merge(TextStyle(
          color: Colors.black.withOpacity(0.5),
        )),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
