import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/hot_job_list.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/navigate_feat.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/recent_job_list.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/selection_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Logger logger = Logger();

  late ScrollController _scrollController;
  late ScrollController _hotJobScrollController;
  late ScrollController _selectionScrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectionScrollController = ScrollController(
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
    _hotJobScrollController = ScrollController(
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

    _scrollController.addListener(_scrollControllerListener);
  }

  _scrollControllerListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      logger.d('reach the bottom');
    }
    if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      logger.d('reach the top');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    int choiceValue = 0;

    void callBackSetChoiceValue(int value) {
      setState(() {
        choiceValue = value;
      });
      logger.d('choiceValue: $choiceValue');
    }

    return CommonScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Future<void>.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Header(
                  subtitle: const Text(
                    'vyhhps22919@fpt.edu.vn',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  title: const Text(
                    'Huynh Hong Vy',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTapLeading: () {},
                  onTapTitle: () {},
                  leadingBadge: true,
                  actions: [
                    InkWell(
                      onTap: () {},
                      radius: 99,
                      borderRadius: BorderRadius.circular(99),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          border: Border.all(
                            color: themeData.colorScheme.onBackground.withOpacity(0.5),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        width: 28,
                        height: 28,
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(
                          AppConstants.ic_search,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {},
                      radius: 99,
                      borderRadius: BorderRadius.circular(99),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(
                                color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              AppConstants.ic_notification,
                              width: 16,
                              height: 16,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const NavigateFeat(),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10, bottom: 4, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Hot Job',
                  style: themeData.textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            HotJobList(scrollController: _hotJobScrollController),
            SliverPadding(
              padding: const EdgeInsets.only(top: 6, bottom: 4, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Recent Job',
                  style: themeData.textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SelectionList(
              scrollController: _selectionScrollController,
              onSelected: callBackSetChoiceValue,
            ),
            RecentJobList(
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
