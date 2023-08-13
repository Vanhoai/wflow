import 'package:flutter/material.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';

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

  void changeEmail(String email) {
    widget.signInBloc.add(ChangeEmailEvent(email: email));
  }

  void changePassword(String password) {
    widget.signInBloc.add(ChangePasswordEvent(password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            TextField(
              onChanged: changeEmail,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              onChanged: changeEmail,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
