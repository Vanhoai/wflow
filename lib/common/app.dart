import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/bloc/app_bloc.dart';

import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/environment.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/routes/routes.dart';
import 'package:wflow/core/theme/them.dart';
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
              ],
              child: BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) => previous != current,
                bloc: instance.get<AppBloc>(),
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: EnvironmentConfiguration.appHeading,
                    theme: themeData,
                    darkTheme: themeDataDark,
                    themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                    onGenerateRoute: AppRoutes.generateRoute,
                    initialRoute: RouteKeys.signInScreen,
                    home: SignInScreen(signInBloc: instance.get<SignInBloc>()),
                  );
                },
              ));
        } else {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
