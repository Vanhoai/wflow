import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
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
                        onChanged: (value) =>
                            context.read<SecurityBloc>().add(ToggleTouchIDEvent(touchIDEnabled: value)),
                      );
                    }),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Text(
                      "Dark Mode",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const Spacer(),
                    BlocBuilder<AppBloc, AppState>(
                      buildWhen: (prev, state) => prev.isDarkMode != state.isDarkMode,
                      builder: ((context, state) {
                        return SwitchAnimation(
                          value: state.isDarkMode,
                          onChanged: (darkMode) {
                            if (darkMode == false) {
                              context.read<AppBloc>().add(AppChangeTheme(isDarkMode: true));
                            } else {
                              context.read<AppBloc>().add(AppChangeTheme(isDarkMode: false));
                            }
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<PersonalBloc, PersonalState>(
                listener: listener,
                buildWhen: (prev, cur) => prev != cur,
                builder: (context, state) {
                  return PrimaryButton(
                    label: "Sign Out",
                    onPressed: () {
                      context.read<PersonalBloc>().add(const SignOutEvent());
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
