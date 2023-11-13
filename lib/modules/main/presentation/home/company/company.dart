import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
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
  late final ScrollController scrollController;

  List<bool> isFirstLoad = [false, false, false];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget buildLoading(ThemeData themeData) {
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
      create: (context) => MyCompanyBloc(
        companyUseCase: instance.call<CompanyUseCase>(),
      )..add(const GetMyCompanyEvent(isLoading: true, message: 'Start load company')),
      lazy: true,
      child: CommonScaffold(
        isSafe: true,
        appBar: const AppHeader(
          text: 'TheFlow',
          actions: [],
        ),
        body: BlocConsumer<MyCompanyBloc, MyCompanyState>(
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          listenWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: 130.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  clipBehavior: Clip.none,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: CachedNetworkImage(
                            imageUrl: state.companyEntity.logo.toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(32.w, -30.h, 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 80.w,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CachedNetworkImage(
                            imageUrl: state.companyEntity.logo.toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CupertinoActivityIndicator(radius: 16),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          '${state.companyEntity.collaborators.length} members',
                          style: themeData.textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0, -12.h, 0),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: themeData.colorScheme.onBackground.withOpacity(0.1),
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: AppColors.primary,
                  unselectedLabelStyle: themeData.textTheme.displaySmall!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                  labelStyle: themeData.textTheme.displaySmall!.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                const Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CompanyAboutWidget(),
                      CompanyJobPostWidget(),
                      CompanyMemberWidget(),
                      CompanyLocationWidget()
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
        break;
      case 3:
        break;
      default:
    }
  }
}
