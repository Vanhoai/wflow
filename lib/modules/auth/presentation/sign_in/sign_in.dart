import 'package:flutter/material.dart';
import 'package:wflow/common/libs/firebase.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.signInBloc});

  final SignInBloc signInBloc;

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

    widget.signInBloc.stream.listen((event) {
      if (event is SignInSuccess) {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.bottomScreen, (route) => false);
      }
    });
  }

  Future<dynamic> signInWithGoogle() async {
    final response = await FirebaseService.signInWithGoogle();
    print("Google ${response.toString()}");
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    widget.signInBloc.close();
    super.dispose();
  }

  void signInSubmitted() {
    widget.signInBloc.add(SignInSubmitted(email: emailController.text, password: passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
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
            ElevatedButton(
              onPressed: signInWithGoogle,
              child: Text(
                "Sign In",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
