import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/forgot_password/function.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';

class ForgotEmailWidget extends StatefulWidget {
  const ForgotEmailWidget({super.key});

  @override
  State<ForgotEmailWidget> createState() => _ForgotEmailWidgetState();
}

class _ForgotEmailWidgetState extends State<ForgotEmailWidget> {
  final TextEditingController _emailController = TextEditingController();

  _navigationToVerificationScreen() {
    if (_emailController.text.isEmpty) {
      return AlertUtils.showMessage('Notification', 'Please enter your email');
    }

    if (StringsUtil.isEmail(_emailController.text) == false) {
      return AlertUtils.showMessage('Notification', 'Please enter a valid email');
    }

    final String otp = OtpHelper.randOtp();

    Navigator.of(context).pushReplacementNamed(
      RouteKeys.verificationScreen,
      arguments: VerificationArgument(
        password: '',
        type: 'reset_password',
        username: _emailController.text,
        otpCode: otp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldFrom(
          controller: _emailController,
          label: instance.call<AppLocalization>().translate('email') ?? 'Email',
          placeholder: instance.call<AppLocalization>().translate('enterYourEmail') ?? 'Enter your email',
          prefixIcon: const Icon(Icons.email),
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(
              flex: 1,
              child: PrimaryButton(
                onPressed: () => _navigationToVerificationScreen(),
                label: instance.call<AppLocalization>().translate('sendOtp') ?? 'Send OTP',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
