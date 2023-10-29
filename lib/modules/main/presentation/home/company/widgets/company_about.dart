import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

class CompanyAboutWidget extends StatefulWidget {
  const CompanyAboutWidget({super.key});

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
        return SingleChildScrollView(
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
                          color: AppColors.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    6.verticalSpace,
                    Text(
                      'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        color: AppColors.textColor,
                        fontSize: 14.sp,
                      ),
                      maxLines: 14,
                    ),
                    const Divider(),
                    Text('Website',
                        style: themeData.textTheme.displayMedium!.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14.sp,
                        )),
                    InkWell(
                      onTap: () {},
                      child: Text('https://wflow.space',
                          style: themeData.textTheme.displayMedium!.copyWith(
                            color: AppColors.blueColor,
                            fontSize: 14.sp,
                          )),
                    ),
                    6.verticalSpace,
                    Text('Information',
                        style: themeData.textTheme.displayLarge!.copyWith(
                          color: AppColors.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    6.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Primary Email',
                            style: themeData.textTheme.displayMedium!.copyWith(
                              color: AppColors.textColor,
                              fontSize: 14.sp,
                            )),
                        Text(companyEntity.email,
                            style: themeData.textTheme.displayLarge!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Phone',
                            style: themeData.textTheme.displayMedium!.copyWith(
                              color: AppColors.textColor,
                              fontSize: 14.sp,
                            )),
                        Text(companyEntity.phone,
                            style: themeData.textTheme.displayLarge!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Address',
                            style: themeData.textTheme.displayMedium!.copyWith(
                              color: AppColors.textColor,
                              fontSize: 14.sp,
                            )),
                        Text(companyEntity.address,
                            style: themeData.textTheme.displayLarge!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Created At',
                            style: themeData.textTheme.displayMedium!.copyWith(
                              color: AppColors.textColor,
                              fontSize: 14.sp,
                            )),
                        Text(
                            '${companyEntity.createdAt!.day}/${companyEntity.createdAt!.month}/${companyEntity.createdAt!.year}',
                            style: themeData.textTheme.displayLarge!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            )),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
