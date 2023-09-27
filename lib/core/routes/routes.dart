import 'package:flutter/material.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/modules/auth/presentation/create_account/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/create_account/create_account.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';
import 'package:wflow/modules/auth/presentation/sign_in/sign_in_ui.dart';
import 'package:wflow/modules/auth/presentation/verification/verification.dart';
import 'package:wflow/modules/introduction/presentation/introduction.dart';
import 'package:wflow/modules/main/presentation/bottom.dart';
import 'package:wflow/modules/main/presentation/message/message/message.dart';
import 'package:wflow/modules/main/presentation/personal/file/file.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteKeys.signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case RouteKeys.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteKeys.introScreen:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case RouteKeys.verificationScreen:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      case RouteKeys.messageScreen:
        return MaterialPageRoute(builder: (_) => const MessageScreen());
      case RouteKeys.createAccountScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CreateAccountScreen(createAccountBloc: instance.get<CreateAccountBloc>(), str: args),
        );
      case RouteKeys.bottomScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case RouteKeys.fileScreen:
        return MaterialPageRoute(builder: (_) => const FileScreen());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
