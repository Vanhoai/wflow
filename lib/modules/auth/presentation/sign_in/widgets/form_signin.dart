import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/biometrics.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/event.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/state.dart';

enum ForgotType { email, phone }

class FormSignIn extends StatefulWidget {
  const FormSignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<FormSignIn> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final bool oldRemember;
  bool isRemember = instance.get<SecurityBloc>().state.isRememberMe;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    super.initState();
    oldRemember = isRemember;
    _initRemember();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _initRemember() async {
    if (isRemember) {
      emailController.text = await instance.get<SecureStorage>().read(AppConstants.usernameKey) ?? '';
      passwordController.text = await instance.get<SecureStorage>().read(AppConstants.passwordKey) ?? '';
    }

    if (isRemember && instance.get<SecurityBloc>().state.touchIDEnabled) {
      AlertUtils.showMessage(
        instance.get<AppLocalization>().translate('notification') ?? 'Notification',
        instance.get<AppLocalization>().translate('pleaseEnterTouchId') ?? 'Please enter touch id',
        callback: () {
          authenticate().then(
            (value) {
              if (value) {
                if (validateEmail(emailController.text) == null &&
                    validatePassword(passwordController.text, passwordController.text) == null) {
                  context.read<SignInBloc>().add(
                        SignInSubmittedEvent(
                          email: emailController.text,
                          password: passwordController.text,
                          isRemember: isRemember,
                        ),
                      );

                  instance.get<SecurityBloc>().add(SaveCredentialsEvent(
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                }
              } else {
                print("=================== Can't authenticate");
                passwordController.text = '';
              }
            },
          );
        },
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Email is required');
      return 'Email is required';
    }

    return null;
  }

  String? validatePassword(String? value, String? secondValue) {
    if (value == null || value.isEmpty) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Password is required');
      return 'Password is required';
    }
    if (!StringsUtil.isPassword(value)) {
      AlertUtils.showMessage(
          instance.get<AppLocalization>().translate('notification'), 'Password must be at least 8 characters');
      return 'Password must be at least 8 characters';
    }
    if (!StringsUtil.isComparePassword(value, secondValue!)) {
      AlertUtils.showMessage(
          instance.get<AppLocalization>().translate('notification'), 'Password and confirm password must be the same');
      return 'Password and confirm password must be the same';
    }
    return null;
  }

  Future<bool> authenticate() async => BiometricsUtil.authenticate(context);

  _buildModalForgot(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final ThemeData themeData = Theme.of(context);
        ForgotType forgotType = ForgotType.email;
        return StatefulBuilder(
          builder: (context, setState) => Container(
            height: 400.h,
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(maxHeight: 400.h),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'Don’t worry ! It happens. Please enter the phone number or email address you used to register your account and we will send you an OTP to reset your password.',
                  style: themeData.textTheme.displayMedium,
                  maxLines: 10,
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () {
                    setState(() {
                      forgotType = ForgotType.email;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: forgotType == ForgotType.email
                            ? themeData.colorScheme.primary
                            : themeData.colorScheme.onSurface.withOpacity(0.2),
                      ),
                    ),
                    height: 70,
                    child: Row(
                      children: [
                        12.horizontalSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: SvgPicture.asset(
                              AppConstants.email,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('via Email', style: themeData.textTheme.displayMedium),
                            4.verticalSpace,
                            Text('example@gmail.com', style: themeData.textTheme.displayMedium)
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () {
                    setState(() {
                      forgotType = ForgotType.phone;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: forgotType == ForgotType.phone
                            ? themeData.colorScheme.primary
                            : themeData.colorScheme.onSurface.withOpacity(0.2),
                      ),
                    ),
                    height: 70,
                    child: Row(
                      children: [
                        12.horizontalSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: SvgPicture.asset(
                              AppConstants.email,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('via Phone', style: themeData.textTheme.displayMedium),
                            4.verticalSpace,
                            Text('+84 123 456 789', style: themeData.textTheme.displayMedium)
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PrimaryButton(
                        onPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..pushNamed(RouteKeys.forgotPasswordScreen, arguments: forgotType);
                        },
                        label: 'Send OTP',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> listener(BuildContext context, SignInState state) async {
    if (state is SignInSuccess) {
      Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.bottomScreen, (route) => false);
    } else if (state is SignInFailure) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              instance.get<AppLocalization>().translate('notification') ?? 'Notification',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            content: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Text(state.message),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.blueColor),
                ),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Form(
          key: _key,
          child: Column(
            children: [
              TextFieldFrom(
                label: instance.get<AppLocalization>().translate('emailOrPhone') ?? 'Email or phone',
                controller: emailController,
                onChange: (val) => context.read<SignInBloc>().add(OnChangeEmailEvent(email: val)),
                placeholder:
                    instance.get<AppLocalization>().translate('placeholderEmailOrPhone') ?? 'Enter your email or phone',
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.account_circle,
                  size: 24,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                  child: SvgPicture.asset(AppConstants.checkFill,
                      fit: BoxFit.cover,
                      colorFilter: state.regex
                          ? const ColorFilter.mode(Colors.green, BlendMode.srcIn)
                          : const ColorFilter.mode(Colors.black38, BlendMode.srcIn)),
                ),
              ),
              TextFieldFrom(
                controller: passwordController,
                label: instance.get<AppLocalization>().translate('password') ?? 'Password',
                placeholder: instance.get<AppLocalization>().translate('placeholderPassword') ?? 'Enter your password',
                prefixIcon: const Icon(
                  Icons.lock,
                  size: 24,
                ),
                isPassword: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isRemember = !isRemember;
                      });

                      instance.get<SecurityBloc>().add(RememberMeEvent(rememberMe: isRemember));
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black26),
                            borderRadius: BorderRadius.circular(6.0),
                            color: isRemember ? AppColors.primary : Colors.white,
                          ),
                          child: SvgPicture.asset(AppConstants.checkOutLine, height: 12, width: 12),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        Text(
                          instance.get<AppLocalization>().translate('rememberMe') ?? 'Remember me',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Text(
                        instance.get<AppLocalization>().translate('forgotPassword') ?? 'Forgot password?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    onTap: () => _buildModalForgot(context),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: BlocListener<SignInBloc, SignInState>(
                      listenWhen: (preState, state) => preState != state,
                      listener: listener,
                      child: PrimaryButton(
                        onPressed: () {
                          if (validateEmail(emailController.text) == null &&
                              validatePassword(passwordController.text, passwordController.text) == null) {
                            context.read<SignInBloc>().add(
                                  SignInSubmittedEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    isRemember: isRemember,
                                  ),
                                );
                          }
                        },
                        label: instance.get<AppLocalization>().translate('signIn') ?? 'Sign in',
                      ),
                    ),
                  ),
                  BlocBuilder<SecurityBloc, SecurityState>(
                    buildWhen: (previous, current) => previous != current,
                    bloc: instance.get<SecurityBloc>(),
                    builder: (context, securityState) {
                      if (securityState.touchIDEnabled && oldRemember == true) {
                        return (Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              splashColor: AppColors.blueColor,
                              child: SvgPicture.asset(height: 50, AppConstants.bionic),
                              onTap: () {
                                authenticate().then((value) async {
                                  if (value) {
                                    context.read<SignInBloc>().add(
                                          SignInSubmittedEvent(
                                            email: await instance.get<SecureStorage>().read(AppConstants.usernameKey) ??
                                                '',
                                            password:
                                                await instance.get<SecureStorage>().read(AppConstants.passwordKey) ??
                                                    '',
                                            isRemember: isRemember,
                                          ),
                                        );
                                  } else {
                                    print("=================== Can't authenticate");
                                  }
                                });
                              },
                            )
                          ],
                        ));
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
