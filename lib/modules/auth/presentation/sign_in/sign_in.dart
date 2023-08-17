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

  Future<dynamic> signInWithEmailLink() async {
    const String email = "hardy251223@gmail.com";
    await FirebaseService.signInWithEmailLink(email);
  }

  Future<void> signInWithPhoneNumber() async {
    await FirebaseService.signInWithPhoneNumber();
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
              onPressed: signInWithEmailLink,
              child: Text(
                "Sign In With Email",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            ElevatedButton(
              onPressed: signInWithGoogle,
              child: Text(
                "Sign In With Google",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            ElevatedButton(
              onPressed: () => signInWithPhoneNumber(),
              child: Text(
                "Sign In With Phone",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(createRoute());
                // convert to push name use animation the same
                Navigator.of(context).pushNamed(RouteKeys.createAccountScreen, arguments: "Hi");
              },
              child: Text(
                "Redirect To Create Account",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
