import 'package:flutter/material.dart';

class TextFieldCreateContractWidget extends StatefulWidget {
  const TextFieldCreateContractWidget({
    super.key,
    required this.controller,
    this.maxLines = 5,
    this.hintText = '',
    this.minLines = 1,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final String hintText;
  final Icon? suffixIcon;
  @override
  State<TextFieldCreateContractWidget> createState() => _TextFieldCreateContractWidgetState();
}

class _TextFieldCreateContractWidgetState extends State<TextFieldCreateContractWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return TextField(
      controller: widget.controller,
      scrollPhysics: const BouncingScrollPhysics(),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      style: themeData.textTheme.displayMedium!.merge(TextStyle(
        color: Colors.black.withOpacity(0.5),
      )),
      minLines: widget.maxLines,
      maxLines: widget.maxLines,
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
        hintText: widget.hintText,
        hintStyle: themeData.textTheme.displayMedium!.merge(TextStyle(
          color: Colors.black.withOpacity(0.5),
        )),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
