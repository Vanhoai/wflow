

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/theme/colors.dart';

import '../style/textfieldstyle.dart';

class TextFieldFrom extends StatefulWidget{

  const TextFieldFrom({
    Key? key,
    this.controller,
    this.onChange,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    required this.placeholder,
    required this.label ,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false}): super(key: key);

  final Function(String val)? onChange;
  final String placeholder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String label;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  @override
  State<StatefulWidget> createState() {
    return _StateTextFieldFrom();
  }

}

class _StateTextFieldFrom extends State<TextFieldFrom> {
  late bool _passwordVisible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 20,bottom: 9),
          child:  Text(
              widget.label,
              style: TextTitle(
                  fontWeight: FontWeight.w400,
              )
          ),
        ),
        TextFormField(
            style: TextTitle(
              size: 16,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            autofocus: false,
            controller: widget.controller,
            onChanged: widget.onChange,
            obscureText: _passwordVisible,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            decoration:  InputDecoration(

              prefixIcon: widget.prefixIcon,
              prefixIconColor: AppColors.purpleColor,

              suffixIcon: _isPassword(),
              hintText: widget.placeholder,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              hintStyle: TextTitle(colors: AppColors.fadeText,size: 14),
              focusedBorder:  const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.primary, width: 1.0),
              ),
              enabledBorder:  const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.black26, width: 1.0),
              ),
            ),
        )
      ],
    );



  }
  //Kiểm tra phải là input password không?
  Widget? _isPassword ()
  {
      if(!widget.isPassword)
      {
        return widget.suffixIcon;
      }else{
        return Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
            child: InkWell(
            child: SvgPicture.asset(_passwordVisible  ? AppConstants.hidePass : AppConstants.showPass,
                fit: BoxFit.cover,colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.srcIn)),
            onTap: () => {
            setState((){
            _passwordVisible = !_passwordVisible;
              })
            },
          )
        );
      }
  }
}
//Để tạm do chưa biết cách overrid color textTheme


