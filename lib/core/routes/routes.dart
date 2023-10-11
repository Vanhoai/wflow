import 'package:flutter/material.dart';
import 'package:stringee_flutter_plugin/stringee_flutter_plugin.dart';
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
import 'package:wflow/modules/main/presentation/message/rooms/rooms.dart';
import 'package:wflow/modules/main/presentation/personal/authenticate/austepone/austepone.dart';
import 'package:wflow/modules/main/presentation/personal/authenticate/austepthree/austepthree.dart';
import 'package:wflow/modules/main/presentation/personal/authenticate/austeptwo/austeptwo.dart';
import 'package:wflow/modules/main/presentation/personal/profile/profile.dart';
import 'package:wflow/modules/main/presentation/personal/setting/setting.dart';
import 'package:wflow/modules/main/presentation/photo/photo.dart';

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
      case RouteKeys.roomsScreen:
        return MaterialPageRoute(builder: (_) => const RoomsScreen());
      case RouteKeys.messageScreen:
        return MaterialPageRoute(builder: (_) => const MessageScreen());
      case RouteKeys.photoScreen:
        return MaterialPageRoute(builder: (_) => const PhotoScreen());
      case RouteKeys.createAccountScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CreateAccountScreen(createAccountBloc: instance.get<CreateAccountBloc>(), str: args),
        );
      case RouteKeys.bottomScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case RouteKeys.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case RouteKeys.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteKeys.auStepOneScreen:
        return MaterialPageRoute(builder: (_) => const AuStepOneScreen());
      case RouteKeys.auStepTwoScreen:
        return MaterialPageRoute(builder: (_) => const AuStepTwoScreen());
      case RouteKeys.auStepThreeScreen:
        return MaterialPageRoute(builder: (_) => const AuStepThreeScreen());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
