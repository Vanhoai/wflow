import 'package:flutter/material.dart';

import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';

import 'package:wflow/modules/auth/presentation/sign_in/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/sign_in/sign_in.dart';
import 'package:wflow/modules/main/presentation/bottom.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteKeys.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen(signInBloc: instance.get<SignInBloc>()));
      case RouteKeys.createAccountScreen:
        return MaterialPageRoute(builder: (_) => Container());
      case RouteKeys.bottomScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
