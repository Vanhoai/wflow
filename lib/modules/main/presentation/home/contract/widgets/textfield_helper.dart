import 'package:flutter/material.dart';

class TextFieldHelper extends StatelessWidget {
  const TextFieldHelper({
    super.key,
    required this.controller,
    this.maxLines = 5,
    this.hintText = '',
    this.minLines = 1,
    this.suffixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final String hintText;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return TextFormField(
      controller: controller,
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
          borderRadius: BorderRadius.circular(10),
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
