import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';

class GradientButton extends StatelessWidget{
  final VoidCallback onTap;
  final String text;
  const GradientButton({ required this.onTap, required this.text ,Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap:onTap,
      child:Ink(
        height: 50,
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.blueColor,
                AppColors.purpleColor,
              ]),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Container(
          // min sizes for Material buttons
          alignment: Alignment.center,
          child:  Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),

    );
  }

}
