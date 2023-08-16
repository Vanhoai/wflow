import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wflow/common/bloc/app_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/configuration/environment.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/routes/routes.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/sign_in/sign_in.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: instance.allReady(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => instance.get<AppBloc>(),
              ),
              BlocProvider(
                create: (BuildContext context) => instance.get<AppLoadingBloc>(),
              )
            ],
            child: BlocBuilder<AppBloc, AppState>(
              // material app only rebuild when app state change (language, theme)
              buildWhen: (previous, current) => previous != current,
              bloc: instance.get<AppBloc>(),
              builder: (context, parent) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: EnvironmentConfiguration.appHeading,
                      theme: themeData,
                      darkTheme: themeDataDark,
                      themeMode: parent.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                      onGenerateRoute: AppRoutes.generateRoute,
                      initialRoute: RouteKeys.signInScreen,
                      home: SignInScreen(signInBloc: instance.get<SignInBloc>()),
                    ),
                    // add bloc builder here so hide and show loading but not reload material app
                    BlocBuilder(
                      bloc: instance.get<AppLoadingBloc>(),
                      builder: (context, state) {
                        if (state is HideLoadingState)
                          // ignore: curly_braces_in_flow_control_structures
                          return const SizedBox();
                        else if (state is ShowLoadingState)
                          // ignore: curly_braces_in_flow_control_structures
                          return const GlobalLoading();
                        else
                          // ignore: curly_braces_in_flow_control_structures
                          return const SizedBox();
                      },
                    )
                  ],
                );
              },
            ),
          );
        } else {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: GlobalLoading(),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
