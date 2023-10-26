import 'package:flutter/material.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/my_company_bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    instance.call<MyCompanyBloc>().add(const GetMyCompanyEvent());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    instance.call<MyCompanyBloc>().add(const MyCompanyEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      appBar: const AppHeader(),
      isSafe: true,
      body: Column(
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
            indicator: CircleTabIndicator(color: themeData.colorScheme.primary, radius: 4),
            tabAlignment: TabAlignment.center,
            splashFactory: NoSplash.splashFactory,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            dividerColor: Colors.transparent,
            splashBorderRadius: BorderRadius.zero,
            tabs: const [
              Tab(child: Text('Information')),
              Tab(child: Text('Posts(20)')),
              Tab(child: Text('Members(20)')),
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
    );
  }
}
