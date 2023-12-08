import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/domain/auth_usecase.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';
import 'package:wflow/modules/auth/presentation/reset_password/bloc/reset_password_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.argument});

  final VerificationArgument argument;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  _listenerResetPasswordBloc(BuildContext context, ResetPasswordState state) {
    if (state is ResetPasswordSuccess) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification') ?? 'Notification',
          instance.get<AppLocalization>().translate('resetPasswordSuccess') ?? 'Success reset password', callback: () {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.signInScreen, (route) => false);
      });
    } else if (state is ResetPasswordFailure) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification') ?? 'Notification',
          instance.get<AppLocalization>().translate('resetPasswordFailed') ?? 'Error reset password');
    }
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

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const AppBarCenterWidget(center: Text('Reset Password')),
      hideKeyboardWhenTouchOutside: true,
      body: BlocProvider<ResetPasswordBloc>(
        create: (context) => ResetPasswordBloc(authUseCase: instance.get<AuthUseCase>()),
        lazy: true,
        child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: _listenerResetPasswordBloc,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                TextFieldFrom(
                  controller: passwordController,
                  label: 'Password',
                  placeholder: 'Enter your password',
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                TextFieldFrom(
                  controller: confirmPasswordController,
                  label: 'Confirm password',
                  placeholder: 'Enter your confirm password',
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  isPassword: true,
                ),
                20.verticalSpace,
                Expanded(
                  flex: 1,
                  child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) => PrimaryButton(
                      onPressed: () async {
                        final String? validate =
                            validatePassword(passwordController.text, confirmPasswordController.text);
                        if (validate == null) {
                          context.read<ResetPasswordBloc>().add(ResetPasswordSubmitEvent(
                                username: widget.argument.username,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                type: widget.argument.type,
                              ));
                        }
                      },
                      label: 'Reset Password',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
