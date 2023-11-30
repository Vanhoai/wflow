import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/enum/role_enum.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/home/home/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onTabTapped});

  final Function(int) onTabTapped;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  late ScrollController hotJobScrollController;
  late ScrollController selectionScrollController;

  @override
  void initState() {
    super.initState();
    selectionScrollController = ScrollController();
    hotJobScrollController = ScrollController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    selectionScrollController.dispose();
    hotJobScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final isUser = instance.get<AppBloc>().state.role == RoleEnum.user.index + 1;

    return BlocProvider(
      create: (_) => HomeBloc(
        postUseCase: instance.get<PostUseCase>(),
        categoryUseCase: instance.get<CategoryUseCase>(),
        userUseCase: instance.get<UserUseCase>(),
      )..add(HomeInitialEvent()),
      child: CommonScaffold(
        isSafe: true,
        body: Builder(builder: (context) {
          final HomeBloc homeBloc = context.read<HomeBloc>();

          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: themeData.colorScheme.background,
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: RefreshIndicator(
              onRefresh: () async => homeBloc..add(HomeInitialEvent()),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                    sliver: SliverToBoxAdapter(
                      child: BlocBuilder<AppBloc, AppState>(
                        bloc: instance.get<AppBloc>(),
                        builder: (context, state) {
                          final userEntity = state.userEntity;

                          return BlocSelector<HomeBloc, HomeState, bool>(
                            selector: (state) => state.isLoading,
                            builder: (context, state) => Visibility(
                              visible: !state,
                              replacement: Shimmer.fromColors(
                                baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                                highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                                child: Container(
                                  height: kBottomNavigationBarHeight,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
                                ),
                              ),
                              child: Header(
                                leadingPhotoUrl: userEntity.avatar,
                                title: Text(
                                  'Chào ${userEntity.name} 👋🏻',
                                  style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: FontWeight.w400,
                                  )),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  userEntity.email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                    color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                                onTapLeading: () => isUser
                                    ? {
                                        widget.onTabTapped(4),
                                      }
                                    : Navigator.of(context).pushNamed(
                                        RouteKeys.companyScreen,
                                        arguments: instance.get<AppBloc>().state.userEntity.business.toString(),
                                      ),
                                leadingBadge: true,
                                actions: [
                                  HeaderIcon(
                                    icon: AppConstants.ic_notification,
                                    onTap: () => Navigator.of(context).pushNamed(RouteKeys.notificationScreen),
                                  ),
                                ],
                              ),
                            ),
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
                        instance.get<AppLocalization>().translate('hotWork') ?? 'Hot Work',
                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        )),
                      ),
                    ),
                  ),
                  HowJobListWidget(scrollController: hotJobScrollController),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 6, bottom: 4, left: 20, right: 20),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8, top: 16),
                        child: Text(
                          instance.get<AppLocalization>().translate('recentWork') ?? 'Recent Work',
                          style: themeData.textTheme.displayMedium!.merge(
                            TextStyle(
                              color: themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SelectionListWidget(scrollController: selectionScrollController),
                  const RecentJobListWidget(),
                ],
                dragStartBehavior: DragStartBehavior.start,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                controller: scrollController,
                scrollDirection: Axis.vertical,
              ),
            ),
          );
        }),
      ),
    );
  }
}
