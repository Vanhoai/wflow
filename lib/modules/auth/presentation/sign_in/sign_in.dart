import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/routes/keys.dart';
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
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<dynamic> signInWithGoogle() async {
    final response = await FirebaseService.signInWithGoogle();
    print("Google ${response.toString()}");
  }

  Future<dynamic> signInWithEmailLink() async {
    const String email = "hardy251223@gmail.com";
    await FirebaseService.signInWithEmailLink(email);
  }

  Future<void> signInWithPhoneNumber() async {
    await FirebaseService.signInWithPhoneNumber();
  }

  Future<void> listener(BuildContext context, SignInState state) async {
    if (state is SignInSuccess) {
      await Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.bottomScreen, (route) => false);
    } else if (state is SignInFailure) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sign In Failure", style: Theme.of(context).textTheme.titleMedium),
            content: Text(state.failure.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text("OK"),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

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
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
              ),
              BlocConsumer<SignInBloc, SignInState>(
                listener: listener,
                buildWhen: (prev, cur) => prev != cur,
                builder: (context, state) {
                  return PrimaryButton(
                    marginHorizontal: 20,
                    marginVertical: 20,
                    label: "Sign In With Email",
                    onPressed: () {
                      context
                          .read<SignInBloc>()
                          .add(SignInSubmitted(email: emailController.text, password: passwordController.text));
                    },
                  );
                },
              ),
              PrimaryButton(
                marginHorizontal: 20,
                label: "Sign In With Google",
                onPressed: signInWithGoogle,
              ),
              PrimaryButton(
                marginHorizontal: 20,
                marginVertical: 20,
                label: "Sign In With Phone",
                onPressed: signInWithPhoneNumber,
              ),
              PrimaryButton(
                marginHorizontal: 20,
                label: "Sign In With Email Link",
                onPressed: signInWithEmailLink,
              ),
              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return PrimaryButton(
                    marginHorizontal: 20,
                    marginVertical: 20,
                    label: "Sign In With Touch ID",
                    onPressed: () {
                      context.read<SignInBloc>().add(SignInWithBiometrics());
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
