import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/domain/auth.usecase.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (_) => SignInBloc(authUseCase: instance.get<AuthUseCase>()),
      lazy: true,
      child: CommonScaffold(
        isSafe: true,
        hideKeyboardWhenTouchOutside: true,
        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    print("Sign In Success");
                  } else if (state is SignInFailure) {
                    print("Sign In Failed");
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    marginHorizontal: 20,
                    marginVertical: 20,
                    label: AppLocale.title.getString(context),
                    onPressed: () {
                      context.read<SignInBloc>().add(SignInSubmitted(email: "", password: ""));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
