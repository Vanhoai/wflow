import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';
import 'package:wflow/modules/auth/presentation/forgot_password/function.dart';
import 'package:wflow/modules/auth/presentation/register/bloc/register_bloc.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';

class FormRegisterPhone extends StatefulWidget {
  const FormRegisterPhone({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<FormRegisterPhone> {
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController rePasswordController;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Phone number is required');
      return 'Phone number is required';
    }
    if (!StringsUtil.isPhoneNumber(value)) {
      AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'), 'Phone number is invalid');
      return 'Phone number is invalid';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      bloc: BlocProvider.of<RegisterBloc>(context),
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldFrom(
                label: 'Phone',
                controller: phoneController,
                placeholder: 'Enter your phone',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.phone_android,
                  size: 24,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 16, right: 17, left: 18),
                  child: SvgPicture.asset(AppConstants.checkFill,
                      fit: BoxFit.cover, colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn)),
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
                placeholder: 'Enter your confirm password',
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
                  if (validatePhone(phoneController.text) == null &&
                      validatePassword(passwordController.text, rePasswordController.text) == null) {
                    Navigator.pushNamed(
                      context,
                      RouteKeys.verificationScreen,
                      arguments: VerificationArgument(
                        username: phoneController.text,
                        password: passwordController.text,
                        type: 'phone',
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
      ),
    );
  }
}
