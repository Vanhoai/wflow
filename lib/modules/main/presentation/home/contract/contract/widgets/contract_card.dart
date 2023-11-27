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
import 'package:wflow/core/widgets/custom/circular_percent/circular_percent.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';

class ContractCard extends StatefulWidget {
  const ContractCard({super.key, required this.contractEntity});

  final ContractEntity contractEntity;

  @override
  State<ContractCard> createState() => _ContractCardState();
}

class _ContractCardState extends State<ContractCard> {
  @override
  Widget build(BuildContext context) {
    final noSimbolInUSFormat =
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
                    _buildAvatar(),
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
                            '${noSimbolInUSFormat.format(int.parse(widget.contractEntity.salary))} VNĐ',
                            style: themeData.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    CircularPercentIndicator(
                      animation: true,
                      radius: 25,
                      percent: widget.contractEntity.progress / 100,
                      center: Text(
                        '${widget.contractEntity.progress}%',
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      progressColor:
                          _progressColor(widget.contractEntity.progress / 100),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                              fontWeight: FontWeight.w500,
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
                            fontWeight: FontWeight.w500,
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
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instance.get<AppLocalization>().translate('status') ??
                          'Status',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      instance.get<AppLocalization>().translate(widget
                              .contractEntity.state
                              .toString()
                              .toLowerCase()) ??
                          'Apply',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor,
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
                      instance.get<AppLocalization>().translate('deadline') ??
                          'Deadline',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      instance
                          .get<Time>()
                          .getDayMonthYear(DateTime.now().toString()),
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
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

  Color _progressColor(double value) {
    if (value < 0.3) {
      return Colors.red;
    } else if (value < 0.6) {
      return Colors.orange;
    } else if (value < 0.9) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 12.75,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 6.1,
      child: CircleAvatar(
        radius: MediaQuery.sizeOf(context).width,
        backgroundImage: NetworkImage(
          widget.contractEntity.business.logo,
        ),
      ),
    );
  }
}
