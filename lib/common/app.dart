import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/routes/routes.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/introduction/presentation/introduction.dart';
import 'package:wflow/modules/main/presentation/message/message/message.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('vn', AppLocale.VN),
      ],
      initLanguageCode: 'en',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: instance.allReady(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => AppBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => AppLoadingBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => SecurityBloc(),
              )
            ],
            child: BlocBuilder<AppBloc, AppState>(
              // material app only rebuild when app state change (language, theme)
              buildWhen: (previous, current) => previous != current,
              builder: (context, parent) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    MaterialApp(
                      builder: (context, child) {
                        Widget error = const Text('...rendering error...');
                        if (widget is Scaffold || widget is Navigator) {
                          error = Scaffold(body: Center(child: error));
                        }
                        ErrorWidget.builder = (errorDetails) => error;
                        return child!;
                      },
                      supportedLocales: localization.supportedLocales,
                      localizationsDelegates: localization.localizationsDelegates,
                      debugShowCheckedModeBanner: false,
                      title: EnvironmentConfiguration.appHeading,
                      theme: themeData,
                      darkTheme: themeDataDark,
                      themeMode: parent.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                      onGenerateRoute: AppRoutes.generateRoute,
                      initialRoute: RouteKeys.introScreen,
                      home: const IntroScreen(),
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
