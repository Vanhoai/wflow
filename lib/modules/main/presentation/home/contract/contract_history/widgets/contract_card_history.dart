import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

class ContractCardHistory extends StatefulWidget {
  const ContractCardHistory({super.key, required this.contractEntity});

  final ContractEntity contractEntity;

  @override
  State<ContractCardHistory> createState() => _ContractCardHistoryState();
}

class _ContractCardHistoryState extends State<ContractCardHistory> {
  @override
  Widget build(BuildContext context) {
    final noSymbolInUSFormat =
        NumberFormat.currency(locale: 'vi_VN', symbol: '');
    return Container(
      margin: const EdgeInsets.only(
        left: AppSize.paddingScreenDefault,
        right: AppSize.paddingScreenDefault,
        top: AppSize.marginSmall * 2,
        bottom: AppSize.paddingSmall * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: themeData.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => Navigator.of(context).pushNamed(RouteKeys.taskScreen,
              arguments: widget.contractEntity.id),
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 13, left: 9, right: 9),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildAvatar(widget.contractEntity.business.id.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.contractEntity.title,
                            style: themeData.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${noSymbolInUSFormat.format(int.parse(widget.contractEntity.salary))} VNĐ',
                            style: themeData.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.contractEntity.content,
                        style: themeData.textTheme.displayMedium!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.fadeText,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('totalTask') ??
                          'Total task',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      widget.contractEntity.tasks.length.toString(),
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Builder(
                  builder: (context) {
                    if (instance.get<AppBloc>().state.role !=
                        RoleEnum.business.index + 1) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            instance
                                    .get<AppLocalization>()
                                    .translate('business') ??
                                'Business',
                            style: themeData.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteKeys.companyScreen,
                                  arguments: widget.contractEntity.business.id
                                      .toString());
                            },
                            child: Ink(
                              child: Text(
                                widget.contractEntity.business.name,
                                style: themeData.textTheme.displayMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: themeData.primaryColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          instance.get<AppLocalization>().translate('worker') ??
                              'Worker',
                          style: themeData.textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteKeys.detailUserScreen,
                                arguments: widget.contractEntity.worker.id);
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Ink(
                            child: Text(
                              widget.contractEntity.worker.name,
                              style: themeData.textTheme.displayMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: themeData.primaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('status') ??
                          'Status',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      instance.get<AppLocalization>().translate(widget
                              .contractEntity.state
                              .toString()
                              .toLowerCase()) ??
                          widget.contractEntity.state,
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('createAt') ??
                          'Contract created',
                      style: themeData.textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      instance.get<Time>().getDayMonthYear(
                          widget.contractEntity.createdAt.toString()),
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('endDateAt') ??
                          'Contract closed',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      instance.get<Time>().getDayMonthYear(
                          widget.contractEntity.updatedAt.toString()),
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String idBusiness) {
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 12.75,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 6.1,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(RouteKeys.companyScreen, arguments: idBusiness),
        child: CircleAvatar(
          radius: MediaQuery.sizeOf(context).width,
          backgroundImage: NetworkImage(
            widget.contractEntity.business.logo,
          ),
        ),
      ),
    );
  }
}
