import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/common/security/bloc.dart';
import 'package:wflow/core/enum/role_enum.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/personal/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/header_avatar_widget.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/information_widget.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/shimmer_user.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalBloc(
        userUseCase: instance.get<UserUseCase>(),
      )..add(GetPersonalInformationEvent()),
      lazy: true,
      child: BlocBuilder<PersonalBloc, PersonalState>(
        buildWhen: (previous, current) =>
            previous.userEntity != current.userEntity || previous.isLoading != current.isLoading,
        builder: (context, state) {
          final PersonalBloc personalBloc = BlocProvider.of<PersonalBloc>(context);
          return CommonScaffold(
            isSafe: true,
            body: Visibility(
              visible: !state.isLoading,
              replacement: const ShimmerUser(),
              child: CustomScrollView(
                dragStartBehavior: DragStartBehavior.start,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.vertical,
                slivers: [
                  const HeaderAvatarWidget(),
                  InformationWidget(
                    morePressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return BlocProvider<PersonalBloc>.value(
                          value: personalBloc,
                          child: CupertinoActionSheet(
                            actions: [
                              Visibility(
                                visible: instance.get<AppBloc>().state.role == RoleEnum.user.index + 1,
                                child: CupertinoActionSheetAction(
                                  onPressed: () => Navigator.of(context)
                                    ..pop(context)
                                    ..pushNamed(RouteKeys.upgradeBusinessScreen),
                                  child: Text(instance.get<AppLocalization>().translate('upgrade') ?? 'Upgrade'),
                                ),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () => Navigator.of(context)
                                  ..pop(context)
                                  ..pushNamed(RouteKeys.contractScreen),
                                child: Text(instance.get<AppLocalization>().translate('work') ?? 'Works'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () => Navigator.of(context)
                                  ..pop()
                                  ..pushNamed(RouteKeys.notificationScreen),
                                child:
                                    Text(instance.get<AppLocalization>().translate('notification') ?? 'Notification'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () => Navigator.of(context)
                                  ..pop()
                                  ..pushNamed(RouteKeys.settingScreen),
                                child: Text(instance.get<AppLocalization>().translate('setting') ?? 'Settings'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  personalBloc.add(SignOutEvent());
                                  instance.get<SecurityBloc>().add(const ClearAllDataEvent());
                                },
                                isDestructiveAction: true,
                                child: Text(instance.get<AppLocalization>().translate('signOut') ?? 'Sign out'),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(instance.get<AppLocalization>().translate('cancel') ?? 'Cancel'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
