import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
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
  @override
  void initState() {
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // ignore: unused_local_variable
    int choiceValue = 0;

    void callBackSetChoiceValue(int value) {
      setState(() {
        choiceValue = value;
      });
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
                  title: Text(
                    'Huynh Hong Vy',
                    style: themeData.textTheme.displayLarge!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground,
                    )),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'vyhhps22919@fpt.edu.vn',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.displayMedium!.merge(TextStyle(
                      color: themeData.colorScheme.onBackground.withOpacity(0.5),
                    )),
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
                            color: themeData.colorScheme.onBackground,
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
                          color: themeData.colorScheme.onBackground,
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
                                color: themeData.colorScheme.onBackground,
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
                              color: themeData.colorScheme.onBackground,
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
            const NavigateFeatWidget(),
            SliverPadding(
              padding: const EdgeInsets.only(top: 10, bottom: 4, left: 20, right: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Hot Job',
                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                    color: themeData.colorScheme.onBackground,
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
                    color: themeData.colorScheme.onBackground,
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
