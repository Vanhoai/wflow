import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/auth/presentation/sign_in_huy/bloc/bloc.dart';

import 'components/from_sigin.dart';

class SignInScreenHuy extends StatefulWidget {
  const SignInScreenHuy({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreenHuy> {
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

    // TODO: implement build
    return BlocProvider<SignInBloc>(
      create: (_) => SignInBloc(),
      lazy: true,
      child: SafeArea(
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      child: Text(
                        'Đăng nhập',
                        style: TextTitle(fontWeight: FontWeight.w400, size: 24),
                      ),
                    ),
                    //Form
                    const FormSignIn(),
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
                            child: Text("Hoặc",
                                style: TextTitle(
                                    size: 16, fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    //Login With Google
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      child: Ink(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: Stack(
                          // min sizes for Material buttons
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 11),
                                  child: SvgPicture.asset(AppConstants.google),
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Đăng nhập với Google',
                                style: TextTitle(
                                    size: 16, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    //SignUp
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Bạn chưa có tài khoản? ",
                                style: TextTitle(
                                    size: 16, fontWeight: FontWeight.w400)),
                            InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () => {
                                      Navigator.pushNamed(
                                          context, RouteKeys.registerScreen)
                                    },
                                child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      "Đăng ký",
                                      style: TextTitle(
                                          colors: AppColors.primary,
                                          size: 16,
                                          fontWeight: FontWeight.w500),
                                    ))),
                          ],
                        ))
                  ],
                )),
          ),
      ),
        )),
    );
  }
}
