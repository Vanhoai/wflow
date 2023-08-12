import 'package:flutter/material.dart';
import 'package:wfow/modules/auth/presentation/sign_in/bloc/bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.signInBloc});

  final SignInBloc signInBloc;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  void submit() {
    widget.signInBloc.add(SignInSubmitEvent(email: "tvhoai241223@gmail.com", password: "admin"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(child: ElevatedButton(onPressed: submit, child: const Text("Sign In"))),
      ),
    );
  }
}
