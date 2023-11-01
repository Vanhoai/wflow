import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
            statusBarColor: instance.get<AppBloc>().state.isDarkMode ? Colors.black : Colors.white,
            statusBarIconBrightness: instance.get<AppBloc>().state.isDarkMode ? Brightness.light : Brightness.dark,
            statusBarBrightness: instance.get<AppBloc>().state.isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarDividerColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          );

          if (snapshot.hasData) {
            SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
            return BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) => previous != current,
              bloc: instance.get<AppBloc>(),
              builder: (context, parent) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    MaterialApp(
                      builder: (context, child) {
                        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                          bool isDebug = false;
                          assert(() {
                            isDebug = true;
                            return true;
                          }());
                          if (isDebug) {
                            return ErrorWidget(errorDetails.exception);
                          }
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Something went wrong :( \n\nPlease try again later. \n${errorDetails.exception}',
                                style: const TextStyle(color: Colors.red),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          );
                        };
                        return child!;
                        // Widget error = const Text('...rendering error...');
                        // if (widget is Scaffold || widget is Navigator) {
                        //   error = Scaffold(body: Center(child: error));
                        // }
                        // ErrorWidget.builder = (errorDetails) => error;
                        // return child!;
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
