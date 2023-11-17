import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';
import 'package:wflow/modules/auth/presentation/forgot_password/function.dart';
import 'package:wflow/modules/auth/presentation/register/bloc/register_bloc.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';

class FormRegisterEmail extends StatefulWidget {
  const FormRegisterEmail({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<FormRegisterEmail> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController rePasswordController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();

    emailController.text = '${math.Random().nextInt(100000)}@gmail.com';
    passwordController.text = 'Aa12345678@';
    rePasswordController.text = 'Aa12345678@';
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      AlertUtils.showMessage('Notification', 'Email is required');
      return 'Email is required';
    }
    if (!StringsUtil.isEmail(value)) {
      AlertUtils.showMessage('Notification', 'Email is invalid');
      return 'Email is invalid';
    }
    return null;
  }

  String? validatePassword(String? value, String? secondValue) {
    if (value == null || value.isEmpty) {
      AlertUtils.showMessage('Notification', 'Password is required');
      return 'Password is required';
    }
    if (!StringsUtil.isPassword(value)) {
      AlertUtils.showMessage('Notification', 'Password must be at least 8 characters');
      return 'Password must be at least 8 characters';
    }
    if (!StringsUtil.isComparePassword(value, secondValue!)) {
      AlertUtils.showMessage('Notification', 'Password and confirm password must be the same');
      return 'Password and confirm password must be the same';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: BlocProvider.of<RegisterBloc>(context),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldFrom(
                  label: 'Email',
                  controller: emailController,
                  placeholder: 'Enter your email',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email, size: 24),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                    child: SvgPicture.asset(
                      AppConstants.checkFill,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                    ),
                  ),
                ),
                TextFieldFrom(
                  controller: passwordController,
                  label: 'Password',
                  placeholder: 'Enter your password',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                TextFieldFrom(
                  controller: rePasswordController,
                  label: 'Confirm password',
                  placeholder: 'Enter confirm password',
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  onPressed: () {
                    if (validateEmail(emailController.text) == null &&
                        validatePassword(passwordController.text, rePasswordController.text) == null) {
                      Navigator.pushNamed(
                        context,
                        RouteKeys.verificationScreen,
                        arguments: VerificationArgument(
                          username: emailController.text,
                          password: passwordController.text,
                          type: 'email',
                          otpCode: OtpHelper.randOtp(),
                        ),
                      );
                    }
                  },
                  label: 'Sign Up',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
