import 'package:flutter/material.dart';
import 'package:wfow/common/injection.dart';
import 'package:wfow/core/routes/keys.dart';
import 'package:wfow/modules/auth/presentation/sign_in/bloc/bloc.dart';
import 'package:wfow/modules/auth/presentation/sign_in/sign_in.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteKeys.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen(signInBloc: instance.get<SignInBloc>()));
      case RouteKeys.createAccountScreen:
        return MaterialPageRoute(builder: (_) => Container());
      case RouteKeys.bottomScreen:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
