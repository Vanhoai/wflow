import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _tabs = [
    'About',
    'Posts',
    'Members',
    'Location',
  ];

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<MyCompanyBloc>(
      create: (context) => MyCompanyBloc(companyUseCase: instance.call<CompanyUseCase>())
        ..add(const GetMyCompanyEvent(isLoading: true, message: 'Start load company')),
      lazy: true,
      child: CommonScaffold(
        appBar: AppBarCenterWidget(
          center: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Company',
                style:
                    themeData.textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor),
              ),
            ],
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
                          onPressed: () {
                            Navigator.of(context)
                              ..pop()
                              ..pushNamed(RouteKeys.addBusinessScreen);
                          },
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
        ),
        body: BlocConsumer<MyCompanyBloc, MyCompanyState>(
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          listenWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          builder: (context, state) {
            final companyEntity = state.companyEntity;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !state.isLoadingCompany,
                  replacement: Shimmer.fromColors(
                    baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                    highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircularAvatarTouch(
                            height: 60.h,
                            width: 60.h,
                            onTap: () {},
                            imageUrl: companyEntity.logo == '' ? null : companyEntity.logo,
                          ),
                          10.verticalSpace,
                          Text(
                            companyEntity.name,
                            style: themeData.textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                              fontSize: 26.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TabBar(
                    controller: _tabController,
                    labelColor: themeData.colorScheme.primary,
                    unselectedLabelStyle: themeData.textTheme.displaySmall!.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    labelStyle: themeData.textTheme.displaySmall!.copyWith(
                      color: themeData.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    unselectedLabelColor: themeData.colorScheme.onBackground,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.fill,
                    splashFactory: NoSplash.splashFactory,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorWeight: 2,
                    labelPadding: EdgeInsets.zero,
                    onTap: (index) {
                      final MyCompanyBloc bloc = context.read<MyCompanyBloc>();
                      switch (index) {
                        case 0:
                          _tabController.animateTo(0, curve: Curves.decelerate);
                          break;
                        case 1:
                          if (isFirstLoad[1] == false) {
                            bloc.add(
                              const GetMyPostCompanyEvent(
                                  isLoading: true, message: 'Start load post', page: 1, pageSize: 10),
                            );
                            isFirstLoad[1] = true;
                          }
                          _tabController.animateTo(1, curve: Curves.easeOut);
                          break;
                        case 2:
                          if (isFirstLoad[2] == false) {
                            bloc.add(
                              const GetMyMemberCompanyEvent(
                                  isLoading: true, message: 'Start load member', page: 1, pageSize: 10),
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
                    },
                    tabs: _tabs.map((e) => Tab(child: Text(e))).toList()),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      CompanyAboutWidget(tabController: _tabController),
                      const CompanyJobPostWidget(),
                      const CompanyMemberWidget(),
                      const CompanyLocationWidget(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
