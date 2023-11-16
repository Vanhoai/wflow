import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/company_about/company_information.dart';

class CompanyAboutWidget extends StatefulWidget {
  const CompanyAboutWidget({
    super.key,
  });

  @override
  State<CompanyAboutWidget> createState() => _CompanyAboutWidgetState();
}

class _CompanyAboutWidgetState extends State<CompanyAboutWidget> {
  late final ScrollController scrollController;

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

  Widget buildVisible() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: CupertinoActivityIndicator(radius: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      buildWhen: (previous, current) =>
          previous.isLoadingCompany != current.isLoadingCompany || previous.companyEntity != current.companyEntity,
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;
        return Visibility(
          visible: !state.isLoadingCompany,
          replacement: buildVisible(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20.h),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CompanyInformationWidget(companyEntity: companyEntity),
              ],
            ),
          ),
        );
      },
    );
  }
}
