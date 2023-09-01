import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/button/button.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/core/widgets/textfield/text_field_from.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/auth/presentation/sign_in_huy/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/sign_in_huy/bloc/event.dart';
import 'package:wflow/modules/auth/presentation/sign_in_huy/bloc/state.dart';
class FormSignIn extends StatefulWidget{


  const FormSignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormState() ;
  }

}

class _FormState extends State<FormSignIn>{
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
    return BlocBuilder<SignInBloc,SignInState>(
        builder: (context,state) {
          return  Form(
                key: _key,
                child: Column(
                  children: [
                    //Email
                    TextFieldFrom(
                      label: 'Tài khoản',
                      controller: emailController,
                      onChange: (val) => context.read<SignInBloc>().add(OnChangeEmailEvent(email: val)),
                      placeholder: 'Nhập Email/Số điện thoại',
                      textInputAction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                        child: SvgPicture.asset(
                            AppConstants.email,
                            fit: BoxFit.cover,
                            colorFilter:  const ColorFilter.mode( Colors.black38, BlendMode.srcIn)),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                        child: SvgPicture.asset(
                            AppConstants.checkFill,
                            fit: BoxFit.cover,
                            colorFilter: state.regex ? const ColorFilter.mode(Colors.green, BlendMode.srcIn) : const ColorFilter.mode(Colors.black38, BlendMode.srcIn)),
                      ),
                    ),
                    //Pass
                    TextFieldFrom(
                      controller: passwordController,
                      label: 'Mật khẩu',
                      placeholder: 'Nhập mật khẩu',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                        child: SvgPicture.asset(
                            AppConstants.lock,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.srcIn)),
                      ),
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    Row  (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            InkWell(
                              child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Colors.black26),
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: state.isRemember ? Colors.blue : Colors.white,
                                  ),
                                  child: SvgPicture.asset(AppConstants.checkOutLine)
                              ),
                              onTap: () {
                                context.read<SignInBloc>().add(RememberPassEvent(isRemember: !state.isRemember));
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(left: 9)),
                            Text(
                              "Lưu đăng nhập?",
                              style: TextTitle(size: 15, colors: Colors.black87,fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        //Quên mật khẩu
                        InkWell(
                          borderRadius: BorderRadius.circular(4),
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: Text(
                                'Quên mật khẩu',
                                style: TextTitle(fontWeight: FontWeight.w500,size: 14)),
                          ),
                          onTap: () {

                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    //Btn_Login
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child:BlocListener<SignInBloc,SignInState>(
                            listenWhen: (preState, state) => preState != state,
                            listener: listener,
                            child: AppButton(
                                onTap: () {
                                  context.read<SignInBloc>().add(SignInSubmittedEvent
                                    (
                                      email: emailController.text,
                                      password:  passwordController.text
                                  )
                                  );
                                },
                                text: "Đăng nhập"
                            ),
                          ),

                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => print("hello"),
                          borderRadius: BorderRadius.circular(8),
                          splashColor: AppColors.blueColor,
                          child: SvgPicture.asset(
                              height: 50,
                              AppConstants.bionic
                          ),
                        )
                      ],
                    ),
                  ],
                )
          );
        }
    );
  }

  Future<void> listener (BuildContext context, SignInState state) async  {
    if (state is SignInSuccess) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sign In Failure", style: Theme.of(context).textTheme.titleMedium),
            content: const Text("Dang nhap thanh cong"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text("OK"),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
