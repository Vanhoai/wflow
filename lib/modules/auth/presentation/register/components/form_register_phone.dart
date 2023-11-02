import 'package:flutter/material.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/textfield/text_field_from.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

class FormRegisterPhone extends StatefulWidget {
  const FormRegisterPhone({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<FormRegisterPhone> {
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
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _key,
        child: Column(
          children: [
            TextFieldFrom(
              label: 'Phone',
              controller: emailController,
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
              onPressed: () => Navigator.pushReplacementNamed(context, RouteKeys.verificationScreen),
              label: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
