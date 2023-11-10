import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/function.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  List<bool> isFirstLoad = [false, false, false];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 300),
    );
    _scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildLoading(ThemeData themeData) {
    return Shimmer.fromColors(
      baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
      highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 60.h,
                width: 60.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                )),
            10.verticalSpace,
            Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<MyCompanyBloc>(
      create: (context) => MyCompanyBloc(companyUseCase: instance.call<CompanyUseCase>())
        ..add(const GetMyCompanyEvent(isLoading: true, message: 'Start load company')),
      lazy: true,
      child: CommonScaffold(
        body: BlocConsumer<MyCompanyBloc, MyCompanyState>(
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          listenWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          builder: (context, state) {
            final companyEntity = state.companyEntity;
            return CustomScrollView(
              controller: _scrollController,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  backgroundColor: themeData.colorScheme.background,
                  automaticallyImplyLeading: true,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  stretch: true,
                  title: Visibility(
                    visible: !state.isLoadingCompany,
                    replacement: Shimmer.fromColors(
                      baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                      highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                      child: SizedBox(
                        height: 20.h,
                        width: 100.w,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      companyEntity.name,
                      style: themeData.textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                        fontSize: 26.sp,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {},
                                  child: const Text('Add post'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {},
                                  child: const Text('Add member'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {},
                                  child: const Text('Edit company'),
                                ),
                                CupertinoActionSheetAction(
                                  onPressed: () {},
                                  child: const Text('Share'),
                                ),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                onPressed: () {},
                                child: const Text('Cancel'),
                              ),
                            );
                          },
                        );
                      },
                      icon: SvgPicture.asset(
                        AppConstants.ic_more,
                        height: 24.h,
                        width: 24.w,
                        colorFilter: ColorFilter.mode(themeData.colorScheme.primary, BlendMode.srcIn),
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelStyle: themeData.textTheme.displaySmall!.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    labelStyle: themeData.textTheme.displaySmall!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    unselectedLabelColor: themeData.colorScheme.onBackground,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.fill,
                    splashFactory: NoSplash.splashFactory,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorWeight: 3,
                    labelPadding: EdgeInsets.zero,
                    onTap: (index) {
                      final MyCompanyBloc bloc = context.read<MyCompanyBloc>();
                      observeTabBar(index, bloc);
                    },
                    tabs: staticTab.map((e) => Tab(child: Text(e))).toList(),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CompanyAboutWidget(tabController: _tabController),
                      const CompanyJobPostWidget(),
                      const CompanyMemberWidget(),
                      const CompanyLocationWidget()
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void observeTabBar(int index, MyCompanyBloc bloc) {
    switch (index) {
      case 0:
        bloc.add(
          const GetMyPostCompanyEvent(
            isLoading: true,
            message: 'Start load post',
            page: 1,
            pageSize: 10,
          ),
        );
        _tabController.animateTo(0, curve: Curves.decelerate);
        break;
      case 1:
        if (isFirstLoad[1] == false) {
          bloc.add(
            const GetMyPostCompanyEvent(
              isLoading: true,
              message: 'Start load post',
              page: 1,
              pageSize: 10,
            ),
          );
          isFirstLoad[1] = true;
        }
        _tabController.animateTo(1, curve: Curves.easeOut);
        break;
      case 2:
        if (isFirstLoad[2] == false) {
          bloc.add(
            const GetMyMemberCompanyEvent(
              isLoading: true,
              message: 'Start load member',
              page: 1,
              pageSize: 10,
            ),
          );
          isFirstLoad[2] = true;
        }
        _tabController.animateTo(2, curve: Curves.easeOut);
        break;
      case 3:
        _tabController.animateTo(3, curve: Curves.easeOut);
        break;
      default:
        _tabController.animateTo(0, curve: Curves.easeOut);
    }
  }
}
