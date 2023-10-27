import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/company/company_usecase.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/my_company_bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  List<bool> isFirstLoad = [false, false, false];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<MyCompanyBloc>(
      create: (context) => MyCompanyBloc(companyUseCase: instance.call<CompanyUseCase>())
        ..add(const GetMyCompanyEvent(isLoading: true, message: 'Start load company')),
      lazy: true,
      child: CommonScaffold(
        appBar: const AppHeader(text: 'Company'),
        isSafe: true,
        body: BlocConsumer<MyCompanyBloc, MyCompanyState>(
          listener: (context, state) {
            if (state.message.isNotEmpty) {
              print(state.message);
            }
          },
          buildWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          listenWhen: (previous, current) =>
              previous.companyEntity != current.companyEntity || previous.isLoadingCompany != current.isLoadingCompany,
          builder: (context, state) => Visibility(
            visible: !state.isLoadingCompany,
            replacement: ShimmerWork(
              physics: const NeverScrollableScrollPhysics(),
              height: 280,
              width: double.infinity,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              itemCount: 1,
              margin: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeData.colorScheme.onBackground.withOpacity(0.8),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderAvatarCompanyWidget(),
                TabBar(
                  controller: _tabController,
                  labelColor: themeData.colorScheme.primary,
                  unselectedLabelColor: themeData.colorScheme.onBackground,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: themeData.colorScheme.primary,
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  dividerColor: Colors.transparent,
                  splashBorderRadius: BorderRadius.zero,
                  dragStartBehavior: DragStartBehavior.start,
                  onTap: (index) {
                    final MyCompanyBloc bloc = context.read<MyCompanyBloc>();
                    switch (index) {
                      case 0:
                        _tabController.animateTo(
                          0,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 300),
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
                        _tabController.animateTo(
                          1,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
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
                        _tabController.animateTo(
                          2,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        break;
                      default:
                        _tabController.animateTo(0);
                    }
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        'Information',
                        style: themeData.textTheme.bodyMedium!.copyWith(color: themeData.colorScheme.primary),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Posts (${state.companyEntity.posts.toString()})',
                        style: themeData.textTheme.bodyMedium!.copyWith(color: themeData.colorScheme.primary),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Members (${state.companyEntity.members.toString()})',
                        style: themeData.textTheme.bodyMedium!.copyWith(color: themeData.colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      CompanyInformationWidget(),
                      CompanyJobPostWidget(),
                      CompanyMemberWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
