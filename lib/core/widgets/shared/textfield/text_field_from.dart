import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';

class TextFieldFrom extends StatefulWidget {
  const TextFieldFrom({
    super.key,
    this.controller,
    this.onChange,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    required this.placeholder,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 16),
  });

  final Function(String val)? onChange;
  final String placeholder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String label;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<StatefulWidget> createState() {
    return _StateTextFieldFrom();
  }
}

class _StateTextFieldFrom extends State<TextFieldFrom> {
  late bool _passwordVisible;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _passwordVisible = widget.isPassword;
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 20, bottom: 9),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        TextFormField(
          style: Theme.of(context).textTheme.displayMedium,
          maxLines: 1,
          autofocus: false,
          focusNode: focusNode,
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: _passwordVisible,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            prefixIconColor: _focusIconColor(),
            suffixIcon: _isPassword(),
            suffixIconColor: _focusIconColor(),
            hintText: widget.placeholder,
            contentPadding: widget.contentPadding,
            hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.fadeText),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.primary, width: 1.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
          ),
        )
      ],
    );
  }

  Color _focusIconColor() {
    return MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.focused) ? AppColors.primary : AppColors.fadeText);
  }

  Widget? _isPassword() {
    if (!widget.isPassword) {
      return widget.suffixIcon;
    } else {
      return InkWell(
        splashColor: Colors.transparent,
        child: _passwordVisible ? const Icon(Icons.visibility_off, size: 24) : const Icon(Icons.visibility, size: 24),
        onTap: () {
          focusNode.requestFocus();
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      );
    }
  }
}
