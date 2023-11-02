import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wflow/core/routes/keys.dart';
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
    final noSimbolInUSFormat = NumberFormat.currency(locale: "vi_VN", symbol: "");
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
          onTap: () => Navigator.of(context).pushNamed(RouteKeys.taskScreen),
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 13, left: 9, right: 9),
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
                            style: themeData.textTheme.labelMedium!
                                .copyWith(fontWeight: FontWeight.w500, color: Colors.green),
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
                      percent: 0.5,
                      center: const Text(
                        '50%',
                      ),
                      progressColor: _progressColor(0.5),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.contractEntity.state,
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
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
                      'Deadline',
                      style: themeData.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      Time().getDayMonthYear(DateTime.now().toString()),
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
