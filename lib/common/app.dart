import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/navigation.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/routes/routes.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/error/error.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/introduction/presentation/introduction.dart';

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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => FutureBuilder(
        future: instance.allReady(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) => previous != current,
              bloc: instance.get<AppBloc>(),
              builder: (context, parent) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    MaterialApp(
                      builder: (context, child) {
                        Widget errorWidget = ErrorPage(
                          onPressed: () async {
                            if (await instance.get<NavigationService>().canPop()) {
                              instance.get<NavigationService>().pop();
                            } else {
                              instance.get<NavigationService>().pushNamedAndRemoveUntil(RouteKeys.signInScreen);
                            }
                          },
                        );
                        ErrorWidget.builder = (errorDetails) => errorWidget;
                        return child!;
                      },
                      navigatorKey: instance.get<NavigationService>().navigatorKey,
                      supportedLocales: localization.supportedLocales,
                      localizationsDelegates: localization.localizationsDelegates,
                      debugShowCheckedModeBanner: false,
                      title: EnvironmentConfiguration.appHeading,
                      theme: themeData,
                      darkTheme: themeDataDark,
                      themeMode: parent.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                      onGenerateRoute: AppRoutes.generateRoute,
                      initialRoute:
                          instance.get<AppBloc>().state.isFirstTime ? RouteKeys.introScreen : RouteKeys.signInScreen,
                      home: const IntroScreen(),
                    ),
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
      ),
    );
  }
}
