import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/extensions/number.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

Color changeColorWithStatus(String status) {
  switch (status) {
    case 'WaitingSign':
      return Colors.orange;
    case 'Apply':
      return Colors.green;
    case 'Reject':
      return Colors.red;
    case 'Success':
      return Colors.green;
    case 'Accepted':
      return Colors.green;
    default:
      return Colors.orange;
  }
}

class SignCard extends StatelessWidget {
  const SignCard({super.key, required this.contractEntity});

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
                      Text(contractEntity.position, style: themeData.textTheme.labelMedium),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('status') ?? 'Status',
                      style: themeData.textTheme.labelMedium,
                    ),
                    4.verticalSpace,
                    Text(
                      instance.get<AppLocalization>().translate(contractEntity.state) ?? 'Not Found',
                      style: themeData.textTheme.labelMedium!.copyWith(
                        color: changeColorWithStatus(contractEntity.state),
                      ),
                    ),
                  ],
                )
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🙍️ ${instance.get<AppLocalization>().translate('candidate')}",
                  style: themeData.textTheme.labelMedium,
                ),
                Text(
                  contractEntity.worker.name,
                  style: themeData.textTheme.labelMedium,
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "🤑️ ${instance.get<AppLocalization>().translate('budget')}",
                  style: themeData.textTheme.labelMedium,
                ),
                Text(
                  num.parse(contractEntity.salary).toVND(),
                  style: themeData.textTheme.labelMedium,
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "⏰️ ${instance.get<AppLocalization>().translate('createdAt')}",
                  style: themeData.textTheme.labelMedium,
                ),
                Text(
                  Time().getDayMonthYear(contractEntity.createdAt.toString()),
                  style: themeData.textTheme.labelMedium,
                ),
              ],
            ),
            6.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "📅️ ${instance.get<AppLocalization>().translate('updatedAt')}",
                  style: themeData.textTheme.labelMedium,
                ),
                Text(
                  Time().getDayMonthYear(contractEntity.updatedAt.toString()),
                  style: themeData.textTheme.labelMedium,
                ),
              ],
            ),
            4.verticalSpace,
            Divider(
              color: themeData.colorScheme.onBackground.withOpacity(0.1),
              thickness: 1,
            ),
            4.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '⌛️ ${instance.get<AppLocalization>().translate('contractWillCancelAfter')}',
                  style: themeData.textTheme.labelMedium,
                ),
                Text(
                  Time().getDayMonthYear(contractEntity.updatedAt.toString()),
                  style: themeData.textTheme.labelMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
