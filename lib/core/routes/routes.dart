import 'package:flutter/material.dart';
import 'package:wflow/core/routes/arguments_model/arguments_call.dart';
import 'package:wflow/core/routes/arguments_model/arguments_message.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/routes/arguments_model/arguments_report.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/develop/develop.dart';
import 'package:wflow/modules/auth/presentation/register/register.dart';
import 'package:wflow/modules/auth/presentation/sign_in/sign_in_ui.dart';
import 'package:wflow/modules/auth/presentation/verification/verification.dart';
import 'package:wflow/modules/introduction/presentation/introduction.dart';
import 'package:wflow/modules/main/presentation/bottom.dart';
import 'package:wflow/modules/main/presentation/home/add_cv/add_cv.dart';
import 'package:wflow/modules/main/presentation/home/apply/apply.dart';
import 'package:wflow/modules/main/presentation/home/balance/balance.dart';
import 'package:wflow/modules/main/presentation/home/bookmark/bookmark_screen.dart';
import 'package:wflow/modules/main/presentation/home/company/company.dart';
import 'package:wflow/modules/main/presentation/home/completed/completed.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/contract_screen.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_waiting_sign/contract_waiting_sign.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/up_post.dart';
import 'package:wflow/modules/main/presentation/home/contract_signed/contract_signed.dart';
import 'package:wflow/modules/main/presentation/home/cv/cv.dart';
import 'package:wflow/modules/main/presentation/home/graph/graph.dart';
import 'package:wflow/modules/main/presentation/home/job/job.dart';
import 'package:wflow/modules/main/presentation/home/report/report.dart';
import 'package:wflow/modules/main/presentation/home/reputation/reputation.dart';
import 'package:wflow/modules/main/presentation/message/message/message.dart';
import 'package:wflow/modules/main/presentation/message/rooms/rooms.dart';
import 'package:wflow/modules/main/presentation/message/rooms/search_room.dart';
import 'package:wflow/modules/main/presentation/message/video_call/call.dart';
import 'package:wflow/modules/main/presentation/personal/add_business/add_business_screen.dart';
import 'package:wflow/modules/main/presentation/personal/authentications/index.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/chat_business_screen.dart';
import 'package:wflow/modules/main/presentation/personal/detail_user/detail_user.dart';
import 'package:wflow/modules/main/presentation/personal/editprofile/editprofile.dart';
import 'package:wflow/modules/main/presentation/personal/notification/notification_screen.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/remove_collaborator_screen.dart';
import 'package:wflow/modules/main/presentation/personal/security/security.dart';
import 'package:wflow/modules/main/presentation/personal/setting/setting.dart';
import 'package:wflow/modules/main/presentation/personal/update_business/update_business.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/upgrade_business_screen.dart';
import 'package:wflow/modules/main/presentation/photo/photo.dart';
import 'package:wflow/modules/main/presentation/work/search_work/search_work_screen.dart';
import 'package:wflow/modules/main/presentation/work/task/task.dart';

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
        final args = settings.arguments as FormRegisterArgument;
        return MaterialPageRoute(builder: (_) => VerificationScreen(arguments: args));
      case RouteKeys.roomsScreen:
        return MaterialPageRoute(builder: (_) => const RoomsScreen());
      case RouteKeys.messageScreen:
        final args = settings.arguments as ArgumentsMessage;
        return MaterialPageRoute(builder: (_) => MessageScreen(argumentsMessage: args));
      case RouteKeys.photoScreen:
        final args = settings.arguments as ArgumentsPhoto;
        return MaterialPageRoute(
            builder: (_) => PhotoScreen(argumentsPhoto: args));
      case RouteKeys.callScreen:
        final args = settings.arguments as ArgumentsCall;
        return MaterialPageRoute(
          builder: (_) => CallScreen(argumentsCall: args),
        );
      case RouteKeys.bottomScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case RouteKeys.candidateContractScreen:
        final candidate = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => CandidateContractScreen(candidate: candidate));
      case RouteKeys.jobInformationScreen:
        final work = settings.arguments as num;
        return MaterialPageRoute(
            builder: (_) => JobInformationScreen(work: work));
      case RouteKeys.candidateListScreen:
        final post = settings.arguments as num;
        return MaterialPageRoute(
            builder: (_) => CandidateListScreen(post: post));
      case RouteKeys.createContractScreen:
        final contract = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CreateContractScreen(contract: contract),
        );
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
        final args = settings.arguments as num;
        return MaterialPageRoute(builder: (_) => TaskScreen(idContract: args));
      case RouteKeys.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case RouteKeys.addBusinessScreen:
        final business = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => AddBusinessScreen(business: business));
      case RouteKeys.chatBusinessScreen:
        return MaterialPageRoute(builder: (_) => const ChatBusinessScreen());
      case RouteKeys.contractScreen:
        return MaterialPageRoute(builder: (_) => const ContractScreen());
      case RouteKeys.upgradeBusinessScreen:
        return MaterialPageRoute(builder: (_) => const UpgradeBusinessScreen());
      case RouteKeys.companyScreen:
        final company = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => CompanyScreen(companyID: company));
      case RouteKeys.upPostScreen:
        return MaterialPageRoute(builder: (_) => const UpPostScreen());
      case RouteKeys.developScreen:
        return MaterialPageRoute(builder: (_) => const DevelopeScreen());
      case RouteKeys.applyScreen:
        return MaterialPageRoute(builder: (_) => const ApplyScreen());
      case RouteKeys.balanceScreen:
        final balance = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => BalanceScreen(balanceID: balance));
      case RouteKeys.searchWorkScreen:
        return MaterialPageRoute(builder: (_) => const SearchWorkScreen());
      case RouteKeys.contractWaitingSignScreen:
        return MaterialPageRoute(
            builder: (_) => const ContractWaitingSignScreen());
      case RouteKeys.addCVScreen:
        return MaterialPageRoute(builder: (_) => const AddCVScreen());
      case RouteKeys.cvScreen:
        return MaterialPageRoute(builder: (_) => const CVScreen());
      case RouteKeys.bookmarkScreen:
        return MaterialPageRoute(builder: (_) => const BookmarkScreen());
      case RouteKeys.signedScreen:
        return MaterialPageRoute(builder: (_) => const ContractSignedScreen());
      case RouteKeys.graphScreen:
        return MaterialPageRoute(builder: (_) => const GraphScreen());
      case RouteKeys.removeCollaboratorScreen:
        final business = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => RemoveCollaboratorScreen(business: business));
      case RouteKeys.completedContractScreen:
        return MaterialPageRoute(builder: (_) => const CompletedContractScreen());
      case RouteKeys.reportScreen:
        final report = settings.arguments as ArgumentsReport;
        return MaterialPageRoute(builder: (_) => ReportScreen(argumentsReport: report));
      case RouteKeys.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case RouteKeys.detailUserScreen:
        final idUser = settings.arguments as num;
        return MaterialPageRoute(builder: (_) => DetailUserScreen(id: idUser));
      case RouteKeys.reputationScreen:
        return MaterialPageRoute(builder: (_) => const ReputationScreen());
        case RouteKeys.searchRoomScreen:
        return MaterialPageRoute(builder: (_) => const SearchRoomsScreen());
      case RouteKeys.updateBusinessScreen:
        return MaterialPageRoute(builder: (_) => const UpdateBusinessScreen());
      default:
        return MaterialPageRoute(builder: (_) => const DevelopeScreen());
    }
  }
}
