import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/company_about.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/company_location.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _tabs = [
    'Home',
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
      length: 5,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 300),
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
        appBar: AppBarCenterWidget(
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              onPressed: () {},
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
            return Visibility(
              visible: !state.isLoadingCompany,
              replacement: ShimmerWork(
                physics: const NeverScrollableScrollPhysics(),
                height: 280.h,
                width: double.infinity,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: 2,
                margin: EdgeInsets.only(bottom: 20.h, top: 10.h, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Card(
                    shape: LinearBorder.none,
                    color: AppColors.fade,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircularAvatarTouch(
                                height: 60.h,
                                width: 60.r,
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
                        ],
                      ),
                    ),
                  ),
                  TabBar(
                      controller: _tabController,
                      labelColor: themeData.colorScheme.primary,
                      unselectedLabelStyle: themeData.textTheme.displaySmall!.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                      labelStyle: themeData.textTheme.displaySmall!.copyWith(
                        color: themeData.colorScheme.primary,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                      ),
                      unselectedLabelColor: themeData.colorScheme.onBackground,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabAlignment: TabAlignment.start,
                      splashFactory: NoSplash.splashFactory,
                      physics: const AlwaysScrollableScrollPhysics(),
                      indicatorWeight: 1,
                      isScrollable: true,
                      onTap: (index) {
                        final MyCompanyBloc bloc = context.read<MyCompanyBloc>();
                        switch (index) {
                          case 1:
                            _tabController.animateTo(1, curve: Curves.decelerate);
                            break;
                          case 2:
                            if (isFirstLoad[1] == false) {
                              bloc.add(
                                const GetMyPostCompanyEvent(
                                    isLoading: true, message: 'Start load post', page: 1, pageSize: 10),
                              );
                              isFirstLoad[1] = true;
                            }
                            _tabController.animateTo(2, curve: Curves.easeOut);
                            break;
                          case 3:
                            if (isFirstLoad[2] == false) {
                              bloc.add(
                                const GetMyMemberCompanyEvent(
                                    isLoading: true, message: 'Start load member', page: 1, pageSize: 10),
                              );
                              isFirstLoad[2] = true;
                            }
                            _tabController.animateTo(3, curve: Curves.easeOut);
                            break;
                          case 4:
                            _tabController.animateTo(4, curve: Curves.easeOut);
                            break;
                          default:
                            _tabController.animateTo(0, curve: Curves.easeOut);
                        }
                      },
                      tabs: _tabs.map((e) => Tab(child: Text(e))).toList()),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        CompanyHomeWidget(),
                        CompanyAboutWidget(),
                        CompanyJobPostWidget(),
                        CompanyMemberWidget(),
                        CompanyLocationWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
