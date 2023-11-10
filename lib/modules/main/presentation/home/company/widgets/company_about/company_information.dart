import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';

class CompanyInformationWidget extends StatelessWidget {
  final CompanyEntity companyEntity;
  final TabController tabController;
  const CompanyInformationWidget({super.key, required this.companyEntity, required this.tabController});

  _handleClickContact() {}

  _handleClickWebsite() {}

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final TextStyle contentStyle =
        themeData.textTheme.displaySmall!.copyWith(color: themeData.textTheme.displaySmall!.color!.withOpacity(0.7));

    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview',
              style: themeData.textTheme.displayLarge!.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          6.verticalSpace,
          Text(
            companyEntity.overview.toString() == ''
                ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec odio eget dolor.'
                : companyEntity.overview.toString(),
            style: themeData.textTheme.displayMedium!.copyWith(color: AppColors.textColor, fontSize: 12.sp),
            maxLines: 10,
          ),
          6.verticalSpace,
          Text('Website', style: themeData.textTheme.displayMedium),
          InkWell(
            onTap: () => _handleClickWebsite(),
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
                      onTap: () => _handleClickContact(),
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
          Text(companyEntity.email, style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Text('Collaborators', style: themeData.textTheme.displayMedium),
          Text(companyEntity.collaborators.length.toString(), style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Text('Members', style: themeData.textTheme.displayMedium),
          Text(companyEntity.members.toString(), style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Text('Posts', style: themeData.textTheme.displayMedium),
          Text(companyEntity.posts.toString(), style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Text('Address', style: themeData.textTheme.displayMedium),
          Text(companyEntity.address.toString(), style: contentStyle, maxLines: 2),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => tabController.animateTo(3, curve: Curves.easeOut),
                child:
                    Text('Get direction', style: themeData.textTheme.displaySmall!.copyWith(color: AppColors.primary)),
              ),
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.primary)
            ],
          ),
        ],
      ),
    );
  }
}
