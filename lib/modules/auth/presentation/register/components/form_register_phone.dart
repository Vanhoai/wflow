import 'package:flutter/material.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/button/button.dart';
import 'package:wflow/core/widgets/textfield/text_field_from.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
class FormRegisterPhone extends StatefulWidget{

  const FormRegisterPhone({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormState() ;
  }

}

class _FormState extends State<FormRegisterPhone>{
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController rePasswordController;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          key: _key,
          child: Column(
            children: [
              //Email
              TextFieldFrom(
                label: 'Số điện thoại',
                controller: emailController,
                placeholder: 'Nhập số điện thoại',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, top: 16, right: 17, left: 18),
                  child: SvgPicture.asset(
                      AppConstants.email,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black38, BlendMode.srcIn)),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, top: 16, right: 17, left: 18),
                  child: SvgPicture.asset(
                      AppConstants.checkFill,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.green, BlendMode.srcIn)),
                ),
              ),
              //Pass
              TextFieldFrom(
                controller: passwordController,
                label: 'Mật khẩu',
                placeholder: 'Nhập mật khẩu',
                textInputAction: TextInputAction.next,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, top: 16, right: 17, left: 18),
                  child: SvgPicture.asset(
                      AppConstants.lock,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black38, BlendMode.srcIn)),
                ),
                isPassword: true,
              ),
              TextFieldFrom(
                controller: rePasswordController,
                label: 'Nhập lại mật khẩu',
                placeholder: 'Nhập lại mật khẩu',
                textInputAction: TextInputAction.done,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, top: 16, right: 17, left: 18),
                  child: SvgPicture.asset(
                      AppConstants.lock,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.black38, BlendMode.srcIn)),
                ),
                isPassword: true,
              ),
              const SizedBox(height: 30),
              //Btn_Login
              AppButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, RouteKeys.verificationScreen);
                  },
                  text: "Đăng ký"
              ),
            ],
          )
      ),
    );
    }
  }
