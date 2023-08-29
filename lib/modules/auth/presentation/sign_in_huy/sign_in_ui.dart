import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/text/gradient.text.dart';

import '../../../../core/widgets/button/gradient_button.dart';
import '../../../../core/widgets/style/textfieldstyle.dart';
import '../../../../core/widgets/textfield/text_field_from.dart';
import '../sign_in_huy/bloc/bloc.dart';
import '../sign_in_huy/bloc/state.dart';
import 'bloc/event.dart';

class SignInScreenHuy extends StatefulWidget {
  const SignInScreenHuy({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreenHuy>  {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  // Fix scroll and day xuong bloc state
  @override
  Widget build(BuildContext context) {
    //Set color status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    // TODO: implement build
    return BlocProvider<SignInBloc>(
      create: (_) =>  SignInBloc(),
      lazy: true,
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
              body: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child:  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: SvgPicture.asset(
                          AppConstants.app,
                          semanticsLabel: "Logo",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 17, bottom: 20),
                        child:  Text(
                          'Đăng nhập',
                          style: TextTitle(fontWeight: FontWeight.w400,size: 24),
                        ),
                      ),
                      const MyForm(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 66),
                              height: 1,
                              width: double.infinity,
                              color: Colors.black26,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.white,
                              child: Text(
                                  "Hoặc",
                                  style: TextTitle(size: 16, fontWeight: FontWeight.w400)
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 7,
                      ),
                      InkWell(
                        child:Ink(
                          height: 50,
                          decoration:  BoxDecoration(
                            border: Border.all(color:  Colors.black26, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: Stack(
                            // min sizes for Material buttons
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 11),
                                    child: SvgPicture.asset(AppConstants.google),
                                  )
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('Đăng nhập với Google',style: TextTitle(size: 16, fontWeight: FontWeight.w400),),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                        },
                      ),
                      Flexible(
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Bạn chưa có tài khoản? " ,
                                      style: TextTitle(size: 16,fontWeight: FontWeight.w400)
                                  ),
                                  InkWell(
                                      onTap: ()=>{
                                        Navigator.pushNamed(context, RouteKeys.registerScreen)
                                      },

                                      child:GradientText(
                                        "Đăng ký",
                                        gradient: const LinearGradient(colors: [
                                          AppColors.blueColor,
                                          AppColors.purpleColor
                                        ]
                                        ),
                                        style: TextTitle(size: 16,fontWeight: FontWeight.w500),
                                      )
                                  ),

                                ],
                              )
                          )
                      )
                    ],
                  )
                    ),
                  )



              ),
    );
  }
}


class MyForm extends StatefulWidget{


  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormState() ;
  }

}

class _FormState extends State<MyForm>{
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
                          child:  Text(
                              'Quên mật khẩu',
                              style: TextTitle(fontWeight: FontWeight.w500,size: 14)),
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
                            child: GradientButton(
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
