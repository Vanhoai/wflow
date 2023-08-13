import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wflow/common/bloc/app_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.signInBloc});

  final SignInBloc signInBloc;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isDarkMode = false;

  void submit() {
    widget.signInBloc.add(SignInSubmitEvent(email: "tvhoai241223@gmail.com", password: "admin"));
    widget.signInBloc.add(RedirectEvent());
  }

  void redirect() {
    Navigator.of(context).pushNamed(RouteKeys.bottomScreen);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isSafe: true,
      hideKeyboardWhenTouchOutside: true,
      body: SizedBox(
        child: Column(
          children: [
            SwitchAnimation(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = !value;
                  });
                }),
            BlocBuilder<AppBloc, AppState>(
              bloc: instance.get<AppBloc>(),
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: submit,
                  child: const Text("Sign In"),
                );
              },
            ),
            Text("Sign In Screen", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
