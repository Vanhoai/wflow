import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wflow/core/theme/colors.dart';

class TextFieldVerification extends StatelessWidget {
  const TextFieldVerification({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      width: 53,
      child: TextField(
        style: Theme.of(context).textTheme.displayMedium,
        controller: controller,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: AppColors.primary, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.black26, width: 1.0),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        onChanged: (val) {
          if (val.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (val.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
