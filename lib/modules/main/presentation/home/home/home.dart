import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late ScrollController _hotJobScrollController;
  late ScrollController _selectionScrollController;

  int choiceValue = 0;

  @override
  void initState() {
    super.initState();
    _selectionScrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    _hotJobScrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
  }

  void callBackSetChoiceValue(int value) {
    setState(() {
      choiceValue = value;
    });
  }

  @override
  void dispose() {
    _selectionScrollController.dispose();
    _hotJobScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return CommonScaffold(
      isSafe: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: BlocBuilder<AppBloc, AppState>(
                  bloc: instance.get<AppBloc>(),
                  builder: (context, state) {
                    final name = state.authEntity.user.name;
                    final email = state.authEntity.user.email;

                    return Header(
                      leadingPhotoUrl: state.authEntity.user.avatar,
                      title: Text(
                        'Hi $name 👋🏻',
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                        )),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                        )),
                      ),
                      onTapLeading: () {},
                      onTapTitle: () {},
                      leadingBadge: true,
                      actions: [
                        InkWell(
                          onTap: () => Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
                          child: SvgPicture.asset(
                            AppConstants.ic_notification,
                            width: 28,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                              themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const NavigateFeatWidget(),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10, bottom: 4, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Hot Job',
                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                    color: themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
            HowJobListWidget(scrollController: _hotJobScrollController),
            SliverPadding(
              padding: const EdgeInsets.only(top: 6, bottom: 4, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recent Job',
                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                    color: themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ),
            SelectionListWidget(
              scrollController: _selectionScrollController,
              onSelected: callBackSetChoiceValue,
            ),
            const RecentJobListWidget(
              selectionValue: 0,
            )
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
      ),
    );
  }
}
