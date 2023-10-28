import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/my_company_bloc.dart';

class CompanyHomeWidget extends StatefulWidget {
  const CompanyHomeWidget({super.key});

  @override
  State<CompanyHomeWidget> createState() => _CompanyHomeWidgetState();
}

class _CompanyHomeWidgetState extends State<CompanyHomeWidget> {
  late final ScrollController _scrollController;

  final List<String> _listSelection = [
    'Total job',
    'Total member',
    'Total candidate',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      buildWhen: (previous, current) =>
          previous.isLoadingCompany != current.isLoadingCompany || previous.companyEntity != current.companyEntity,
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;

        return SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: Axis.vertical,
          child: Container(
            color: themeData.colorScheme.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: _listSelection.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: AppColors.fade,
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          width: 120.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              10.verticalSpace,
                              Text(_listSelection[index].toString(),
                                  style: themeData.textTheme.displayLarge!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  )),
                              const Divider(),
                              10.verticalSpace,
                              index == 0
                                  ? Text(
                                      companyEntity.posts.toString(),
                                      style: themeData.textTheme.displayLarge!.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor,
                                      ),
                                    )
                                  : index == 1
                                      ? Text(
                                          companyEntity.members.toString(),
                                          style: themeData.textTheme.displayLarge!.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor,
                                          ),
                                        )
                                      : Text(
                                          companyEntity.collaborators.length.toString(),
                                          style: themeData.textTheme.displayLarge!.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
