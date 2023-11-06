import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

class SignedCard extends StatelessWidget {
  const SignedCard({super.key, required this.contractEntity});

  final ContractEntity contractEntity;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: themeData.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      width: double.infinity,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          RouteKeys.createContractScreen,
          arguments: contractEntity.id.toString(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(48.r),
                  child: CachedNetworkImage(
                    imageUrl: contractEntity.business.logo,
                    placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(radius: 16)),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fadeInCurve: Curves.easeIn,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    height: 48.w,
                    width: 48.w,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(contractEntity.business.name, style: themeData.textTheme.labelLarge),
                      Text('${contractEntity.salary} VND', style: themeData.textTheme.labelMedium),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      AppConstants.ic_clock,
                      height: 16.w,
                      width: 16.w,
                    ),
                    const Text('2 min ago'),
                  ],
                )
              ],
            ),
            12.verticalSpace,
            Text(
              'Google has just created a contract and is waiting for you to accept the job 🤑️',
              maxLines: 2,
              style: themeData.textTheme.labelMedium,
            ),
            12.verticalSpace,
            Row(
              children: [
                SvgPicture.asset(AppConstants.ic_money, height: 16.w, width: 16.w),
                8.horizontalSpace,
                Text('Not money available', style: themeData.textTheme.labelMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
