import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/state.dart';

import 'components/from_sigin.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (_) => SignInBloc(authUseCase: instance.get<AuthUseCase>()),
      lazy: true,
      child: SafeArea(
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
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
                        semanticsLabel: 'Logo',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 17, bottom: 20),
                      child: Text(
                        'Đăng nhập',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
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
                            child: Text(
                              'Hoặc',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          child: Ink(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 11),
                                    child: SvgPicture.asset(AppConstants.google),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Đăng nhập với Google',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // context.read<SignInBloc>().add(SignInWithGoogleEvent());
                            Navigator.pushNamed(context, RouteKeys.bottomScreen);
                          },
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn chưa có tài khoản? ',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => Navigator.pushNamed(context, RouteKeys.registerScreen),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                'Đăng ký',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .merge(const TextStyle(color: AppColors.primary)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
