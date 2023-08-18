import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/personal/personal/bloc/bloc.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  void initState() {
    super.initState();
  }

  void toggleTouchID(bool touchID) {
    if (touchID == false) {
      instance.get<SecurityBloc>().add(const ToggleTouchIDEvent(touchIDEnabled: true));
    } else {
      instance.get<SecurityBloc>().add(const ToggleTouchIDEvent(touchIDEnabled: false));
    }
  }

  Future<void> listener(BuildContext context, PersonalState state) async {
    if (state is SignOutSuccess) {
      await Navigator.of(context).pushNamedAndRemoveUntil(RouteKeys.signInScreen, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalBloc>(
      create: (_) => PersonalBloc(),
      lazy: true,
      child: CommonScaffold(
        isSafe: true,
        body: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Touch ID",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Spacer(),
                  BlocBuilder<SecurityBloc, SecurityState>(
                    buildWhen: (prev, state) => prev.touchIDEnabled != state.touchIDEnabled,
                    builder: ((context, state) {
                      return SwitchAnimation(
                        value: state.touchIDEnabled,
                        onChanged: toggleTouchID,
                      );
                    }),
                  )
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: "Sign Out",
                onPressed: () {
                  final bloc = context.read<PersonalBloc>();
                  print("bloc: $bloc");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
