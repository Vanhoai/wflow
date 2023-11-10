import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
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
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
      debugLabel: 'HomeScreen',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PersonalBloc(userUseCase: instance.get<UserUseCase>())
            ..add(const GetPersonalInformationEvent(
                isLoading: true,
                message: 'Start loading personal information')),
      lazy: true,
      child: BlocConsumer<PersonalBloc, PersonalState>(
        listener: (context, state) {
          if (state.isSignOut == true) {
            Navigator.of(context)
              ..pop()
              ..pushNamedAndRemoveUntil(
                  RouteKeys.signInScreen, (route) => false);
          }
        },
        buildWhen: (previous, current) =>
            previous.userEntity != current.userEntity ||
            previous.isLoading != current.isLoading,
        listenWhen: (previous, current) =>
            previous.isSignOut != current.isSignOut ||
            previous.userEntity != current.userEntity,
        builder: (context, state) {
          final PersonalBloc personalBloc =
              BlocProvider.of<PersonalBloc>(context);
          return CommonScaffold(
            isSafe: true,
            body: Visibility(
              visible: !state.isLoading,
              replacement: const ShimmerUser(),
              child: RefreshIndicator(
                onRefresh: () async => personalBloc.add(
                    const GetPersonalInformationEvent(
                        isLoading: true,
                        message: 'Start loading personal information')),
                child: CustomScrollView(
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
                                  visible: instance.get<AppBloc>().state.role ==
                                      RoleEnum.user.index + 1,
                                  child: CupertinoActionSheetAction(
                                    onPressed: () => Navigator.of(context)
                                      ..pop(context)
                                      ..pushNamed(
                                          RouteKeys.upgradeBusinessScreen),
                                    child: const Text('Upgrade'),
                                  ),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () => Navigator.of(context)
                                    ..pop(context)
                                    ..pushNamed(RouteKeys.contractScreen),
                                  child: const Text('Works'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () => Navigator.of(context)
                                    ..pop()
                                    ..pushNamed(RouteKeys.notificationScreen),
                                  child: const Text('Notification'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () => Navigator.of(context)
                                    ..pop()
                                    ..pushNamed(RouteKeys.settingScreen),
                                  child: const Text('Settings'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () => Navigator.of(context)
                                    ..pop()
                                    ..pushNamed(RouteKeys.addBusinessScreen),
                                  child: const Text('Add'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () => Navigator.of(context)
                                    ..pop()
                                    ..pushNamed(
                                        RouteKeys.removeCollaboratorScreen),
                                  child: const Text('Remove'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () =>
                                      personalBloc.add(const SignOutEvent()),
                                  isDestructiveAction: true,
                                  child: const Text('Sign out'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  dragStartBehavior: DragStartBehavior.start,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
