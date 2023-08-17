import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/create_account/bloc/bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key, required this.createAccountBloc, required this.str});

  final CreateAccountBloc createAccountBloc;
  final String str;

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isSafe: true,
      hideKeyboardWhenTouchOutside: true,
      body: Container(
        color: Colors.blue,
        child: Center(
          child: ElevatedButton(
            child: const Text("Pop"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
