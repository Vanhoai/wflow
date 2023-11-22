import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/forgot_password/widgets/forgot_email.dart';
import 'package:wflow/modules/auth/presentation/forgot_password/widgets/forgot_phone.dart';
import 'package:wflow/modules/auth/presentation/sign_in/widgets/form_signin.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final ForgotType forgotType;

  const ForgotPasswordScreen({super.key, required this.forgotType});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const AppBarCenterWidget(
        center: Text('Forgot password'),
      ),
      hideKeyboardWhenTouchOutside: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Builder(builder: (context) {
              switch (widget.forgotType) {
                case ForgotType.email:
                  return const ForgotEmailWidget();
                case ForgotType.phone:
                  return const ForgotPhoneWidget();
                default:
                  return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
