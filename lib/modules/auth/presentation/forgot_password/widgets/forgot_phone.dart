import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/forgot_password/function.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';

class ForgotPhoneWidget extends StatefulWidget {
  const ForgotPhoneWidget({super.key});

  @override
  State<ForgotPhoneWidget> createState() => _ForgotPhoneWidgetState();
}

class _ForgotPhoneWidgetState extends State<ForgotPhoneWidget> {
  final TextEditingController _phoneController = TextEditingController();

  _navigationToVerificationScreen() {
    if (_phoneController.text.isEmpty) {
      return AlertUtils.showMessage('Notification', 'Please enter your phone');
    }

    if (StringsUtil.isPhoneNumber(_phoneController.text) == false) {
      return AlertUtils.showMessage('Notification', 'Please enter a valid phone');
    }

    final String otp = OtpHelper.randOtp();

    Navigator.of(context).pushReplacementNamed(
      RouteKeys.verificationScreen,
      arguments: VerificationArgument(
        password: '',
        type: 'reset_password',
        username: _phoneController.text,
        otpCode: otp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldFrom(
          controller: _phoneController,
          label: 'Phone',
          placeholder: 'Enter your phone',
          prefixIcon: const Icon(Icons.phone),
          keyboardType: TextInputType.number,
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(
              flex: 1,
              child: PrimaryButton(
                onPressed: () => _navigationToVerificationScreen(),
                label: 'Send OTP',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
