import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/header_avatar_widget.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/information_widget.dart';

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

  void _showModalBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushNamed(RouteKeys.upgradeBusinessScreen);
              },
              child: const Text('Upgrade'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(RouteKeys.contractScreen);
              },
              child: const Text('Works'),
            ),
            CupertinoActionSheetAction(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
              child: const Text('Notification'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RouteKeys.settingScreen);
              },
              child: const Text('Settings'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteKeys.signInScreen, (route) => false),
              isDestructiveAction: true,
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isSafe: true,
      body: CustomScrollView(
        slivers: [
          const HeaderAvatarWidget(),
          InformationWidget(
            morePressed: () => _showModalBottomSheet(context),
          ),
        ],
        clipBehavior: Clip.none,
        cacheExtent: 1000,
        dragStartBehavior: DragStartBehavior.start,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        controller: _scrollController,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
