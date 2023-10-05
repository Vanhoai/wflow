import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:logger/logger.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/header_avatar_widget.dart';
import 'package:wflow/modules/main/presentation/personal/personal/widgets/information_widget.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Logger logger = Logger();

  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
      debugLabel: 'HomeScreen',
      onAttach: (position) {
        logger.d('onAttach$position');
      },
      onDetach: (position) {
        logger.d('onDetach$position');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: RefreshIndicator(
        child: CustomScrollView(
          slivers: const [
            HeaderAvatarWidget(),
            InformationWidget(),
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
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    );
  }
}
