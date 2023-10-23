import 'package:flutter/material.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/arguments_model/arguments_call.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/modules/auth/presentation/create_account/bloc/bloc.dart';
import 'package:wflow/modules/auth/presentation/create_account/create_account.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';
import 'package:wflow/modules/auth/presentation/sign_in/sign_in_ui.dart';
import 'package:wflow/modules/auth/presentation/verification/verification.dart';
import 'package:wflow/modules/introduction/presentation/introduction.dart';
import 'package:wflow/modules/main/presentation/bottom.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract.dart';
import 'package:wflow/modules/main/presentation/home/job/job.dart';
import 'package:wflow/modules/main/presentation/message/message/message.dart';
import 'package:wflow/modules/main/presentation/message/rooms/rooms.dart';
import 'package:wflow/modules/main/presentation/message/video_call/call.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/index.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/add_business_screen.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/chat_business_screen.dart';
import 'package:wflow/modules/main/presentation/personal/notification/notification_screen.dart';
import 'package:wflow/modules/main/presentation/personal/security/security.dart';
import 'package:wflow/modules/main/presentation/personal/setting/setting.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/upgrade_business_screen.dart';
import 'package:wflow/modules/main/presentation/photo/photo.dart';
import 'package:wflow/modules/main/presentation/work/task/task.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/contract_screen.dart';

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
        final args = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => PhotoScreen(
                  multiple: args,
                ));
      case RouteKeys.callScreen:
        final args = settings.arguments as ArgumentsCall;
        return MaterialPageRoute(
          builder: (_) => CallScreen(argumentsCall: args),
        );
      case RouteKeys.createAccountScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CreateAccountScreen(
              createAccountBloc: instance.get<CreateAccountBloc>(), str: args),
        );
      case RouteKeys.bottomScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case RouteKeys.candidateContractScreen:
        return MaterialPageRoute(
            builder: (_) => const CandidateContractScreen());
      case RouteKeys.jobInformationScreen:
        final work = settings.arguments as num;
        return MaterialPageRoute(builder: (_) => JobInformationScreen(work: work));
      case RouteKeys.candidateListScreen:
        return MaterialPageRoute(builder: (_) => const CandidateListScreen());
      case RouteKeys.createContractScreen:
        return MaterialPageRoute(builder: (_) => const CreateContractScreen());
      case RouteKeys.reviewContractScreen:
        return MaterialPageRoute(builder: (_) => const ReviewContractScreen());
      case RouteKeys.viewContractScreen:
        return MaterialPageRoute(builder: (_) => const ViewContractScreen());
      case RouteKeys.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingScreen());
      case RouteKeys.securityScreen:
        return MaterialPageRoute(builder: (_) => const SecurityScreen());
      case RouteKeys.auStepOneScreen:
        return MaterialPageRoute(builder: (_) => const AuthStepOneScreen());
      case RouteKeys.auStepTwoScreen:
        return MaterialPageRoute(builder: (_) => const AuthStepTwoScreen());
      case RouteKeys.auStepThreeScreen:
        return MaterialPageRoute(builder: (_) => const AuthStepThreeScreen());
      case RouteKeys.taskScreen:
        return MaterialPageRoute(builder: (_) => const TaskScreen());
      case RouteKeys.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case RouteKeys.addBusinessScreen:
        return MaterialPageRoute(builder: (_) => const AddBusinessScreen());
      case RouteKeys.chatBusinessScreen:
        return MaterialPageRoute(builder: (_) => const ChatBusinessScreen());
      case RouteKeys.contractScreen:
        return MaterialPageRoute(builder: (_) => const ContractScreen());
      case RouteKeys.upgradeBusinessScreen:
        return MaterialPageRoute(builder: (_) => const UpgradeBusinessScreen());
      case RouteKeys.companyScreen:
        return MaterialPageRoute(builder: (_) => const CompanyScreen());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
