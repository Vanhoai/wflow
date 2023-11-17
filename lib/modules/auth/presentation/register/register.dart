import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/auth/presentation/register/bloc/register_bloc.dart';
import 'package:wflow/modules/auth/presentation/register/widgets/widgets.dart';

class VerificationArgument {
  final String username;
  final String password;
  final String type;
  final String otpCode;

  VerificationArgument({
    required this.username,
    required this.password,
    required this.type,
    required this.otpCode,
  });

  @override
  String toString() {
    return 'FormRegisterArgument(username: $username, password: $password, type: $type, otpCode: $otpCode)';
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(authUseCase: instance.call<AuthUseCase>()),
      lazy: true,
      child: SafeArea(
        child: Listener(
          onPointerDown: (PointerDownEvent event) => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Sign up an account',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: Theme.of(context).primaryColor,
                              controller: _tabController,
                              tabs: [
                                _tabSelect(icon: AppConstants.email, title: 'Email'),
                                _tabSelect(
                                  icon: AppConstants.phone,
                                  title: (MediaQuery.of(context).size.width <= 400 ? 'Phone' : 'Phone number'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height <= 800
                                ? 400
                                : MediaQuery.of(context).size.height * 0.45),
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                FormRegisterEmail(),
                                FormRegisterPhone(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.black26,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.white,
                            child: Text(
                              'or',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () => context.read<RegisterBloc>().add(RegisterWithGoogleEvent()),
                              child: Ink(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26, width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
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
                                        'Sign up with Google',
                                        style: Theme.of(context).textTheme.displayMedium,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ?',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => {Navigator.pop(context)},
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                'Sign In',
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

Widget _tabSelect({String? icon, String? title}) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon!,
          semanticsLabel: 'Logo',
          colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        ),
        const SizedBox(width: 17),
        Text(
          title ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
        )
      ],
    ),
  );
}
