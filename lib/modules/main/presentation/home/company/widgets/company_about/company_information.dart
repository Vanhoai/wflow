import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

class CompanyInformationWidget extends StatelessWidget {
  final CompanyEntity companyEntity;
  const CompanyInformationWidget({super.key, required this.companyEntity});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final TextStyle contentStyle = themeData.textTheme.displayMedium!.copyWith(
      color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7),
    );

    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: themeData.colorScheme.background,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: themeData.colorScheme.primary.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '🙋🏻‍♂️ Collaboration',
                        style: themeData.textTheme.displayMedium!,
                      ),
                      4.verticalSpace,
                      Text(
                        companyEntity.collaborators.length.toString(),
                        style: themeData.textTheme.displayMedium!.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 32.h,
                  width: 1.w,
                  color: themeData.colorScheme.primary.withOpacity(0.1),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '📝 Posted',
                        style: themeData.textTheme.displayMedium!,
                      ),
                      4.verticalSpace,
                      Text(
                        companyEntity.posts.toString(),
                        style: themeData.textTheme.displayMedium!.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Text(
            '🔎 Overview',
            style: themeData.textTheme.displayMedium!.copyWith(
              fontSize: 16.sp,
            ),
          ),
          4.verticalSpace,
          Text(
            companyEntity.overview.toString() == '' ? 'No overview' : companyEntity.overview.toString(),
            style: themeData.textTheme.displayMedium!.copyWith(
              fontSize: 16.sp,
            ),
            maxLines: 10,
          ),
          12.verticalSpace,
          Text(
            '📞 Phone',
            style: themeData.textTheme.displayMedium!.copyWith(
              fontSize: 16.sp,
            ),
          ),
          4.verticalSpace,
          Text(companyEntity.phone, style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Text(
            '📬 Email',
            style: themeData.textTheme.displayMedium!.copyWith(
              fontSize: 16.sp,
            ),
          ),
          4.verticalSpace,
          Text(companyEntity.email, style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Text(
            '🏡 Address',
            style: themeData.textTheme.displayMedium!.copyWith(
              fontSize: 16.sp,
            ),
          ),
          4.verticalSpace,
          Text(companyEntity.address.toString(), style: contentStyle, maxLines: 2),
        ],
      ),
    );
  }
}
