import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/reset_password/bloc/reset_password_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

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
      AlertUtils.showMessage('Notification', state.message);
    } else if (state is ResetPasswordFailure) {
      AlertUtils.showMessage('Notification', state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const AppBarCenterWidget(center: Text('Reset Password')),
      hideKeyboardWhenTouchOutside: true,
      body: BlocProvider<ResetPasswordBloc>(
        create: (context) => ResetPasswordBloc(),
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
                  controller: passwordController,
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
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RouteKeys.signInScreen);
                    },
                    label: 'Reset Password',
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
