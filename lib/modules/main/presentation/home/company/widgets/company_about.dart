import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

class CompanyAboutWidget extends StatefulWidget {
  final TabController tabController;

  const CompanyAboutWidget({super.key, required this.tabController});

  @override
  State<CompanyAboutWidget> createState() => _CompanyAboutWidgetState();
}

class _CompanyAboutWidgetState extends State<CompanyAboutWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      buildWhen: (previous, current) =>
          previous.isLoadingCompany != current.isLoadingCompany || previous.companyEntity != current.companyEntity,
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;
        return Visibility(
          visible: !state.isLoadingCompany,
          replacement: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(child: CupertinoActivityIndicator()),
            ],
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<MyCompanyBloc>()
                  .add(const GetMyCompanyEvent(isLoading: true, message: 'Start load company'));
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 20.h),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overview',
                            style: themeData.textTheme.displayLarge!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        6.verticalSpace,
                        Text(
                          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor',
                          style: themeData.textTheme.displayMedium!.copyWith(
                            color: AppColors.textColor,
                            fontSize: 12.sp,
                          ),
                          maxLines: 10,
                        ),
                        6.verticalSpace,
                        Text('Website', style: themeData.textTheme.displayMedium),
                        InkWell(
                          onTap: () {},
                          child: Text('https://wflow.space',
                              style: themeData.textTheme.displaySmall!.copyWith(color: AppColors.blueColor)),
                        ),
                        6.verticalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Phone', style: themeData.textTheme.displayMedium),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      companyEntity.phone.toString(),
                                      style: themeData.textTheme.displaySmall!.copyWith(color: AppColors.primary),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        6.verticalSpace,
                        Text('Email', style: themeData.textTheme.displayMedium),
                        Text(companyEntity.email,
                            style: themeData.textTheme.displaySmall!
                                .copyWith(color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7)),
                            maxLines: 2),
                        12.verticalSpace,
                        Text('Collaborators', style: themeData.textTheme.displayMedium),
                        Text(companyEntity.collaborators.length.toString(),
                            style: themeData.textTheme.displaySmall!
                                .copyWith(color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7)),
                            maxLines: 2),
                        12.verticalSpace,
                        Text('Members', style: themeData.textTheme.displayMedium),
                        Text(companyEntity.members.toString(),
                            style: themeData.textTheme.displaySmall!
                                .copyWith(color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7)),
                            maxLines: 2),
                        12.verticalSpace,
                        Text('Posts', style: themeData.textTheme.displayMedium),
                        Text(companyEntity.posts.toString(),
                            style: themeData.textTheme.displaySmall!
                                .copyWith(color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7)),
                            maxLines: 2),
                        12.verticalSpace,
                        Text('Address', style: themeData.textTheme.displayMedium),
                        Text(companyEntity.address.toString(),
                            style: themeData.textTheme.displaySmall!
                                .copyWith(color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7)),
                            maxLines: 2),
                        12.verticalSpace,
                        InkWell(
                          onTap: () => widget.tabController.animateTo(3, curve: Curves.easeOut),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Get direction',
                                  style: themeData.textTheme.displaySmall!.copyWith(color: AppColors.primary)),
                              Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.primary)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
