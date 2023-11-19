import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/enum/role_enum.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/utils.dart';

class NavigateFeatWidget extends StatefulWidget {
  const NavigateFeatWidget({super.key});

  @override
  State<NavigateFeatWidget> createState() => _NavigateFeatWidgetState();
}

class _NavigateFeatWidgetState extends State<NavigateFeatWidget> {
  late final List<Map<String, dynamic>> staticMenuSelection;

  @override
  void initState() {
    final isUser = instance.get<AppBloc>().state.role == RoleEnum.user.index + 1;
    staticMenuSelection = [
      {
        'title': instance.get<AppLocalization>().translate('balance') ?? 'Balance',
        'icon': AppConstants.ic_balance,
      },
      {
        'title': instance.get<AppLocalization>().translate('reputation') ?? 'Reputation',
        'icon': AppConstants.ic_reputation,
      },
      {
        'title': isUser
            ? instance.get<AppLocalization>().translate('apply') ?? 'Apply'
            : instance.get<AppLocalization>().translate('business') ?? 'Business',
        'icon': isUser ? AppConstants.apply : AppConstants.ic_business,
      },
      {
        'title': instance.get<AppLocalization>().translate('bookmark') ?? 'Bookmark',
        'icon': AppConstants.ic_bookmark_navigate,
      },
      {
        'title': instance.get<AppLocalization>().translate('sign') ?? 'Waiting',
        'icon': AppConstants.ic_more,
      },
      {
        'title': instance.get<AppLocalization>().translate('signed') ?? 'Signed',
        'icon': AppConstants.ic_signed,
      },
      {
        'title': isUser ? 'Cv' : instance.get<AppLocalization>().translate('upPost') ?? 'Up Post',
        'icon': isUser ? AppConstants.ic_cv : AppConstants.more,
      },
      {
        'title': 'Graph',
        'icon': AppConstants.ic_graph,
      },
    ];
    super.initState();
  }

  void navigateTo(int index) {
    final isUser = instance.get<AppBloc>().state.role == RoleEnum.user.index + 1;
    final balance = instance.get<AppBloc>().state.userEntity.balance;
    final isVerify = instance.get<AppBloc>().state.userEntity.isVerify;

    switch (index) {
      case 0:
        if (isVerify) {
          Navigator.of(context).pushNamed(RouteKeys.balanceScreen, arguments: balance.toString());
        } else {
          AlertUtils.showMessage(instance.get<AppLocalization>().translate('notification'),
              'You not have balance, please verify your account!');
        }
        break;
      case 1:
        Navigator.of(context).pushNamed(RouteKeys.reputationScreen);
        break;
      case 2:
        if (isUser) {
          Navigator.of(context).pushNamed(RouteKeys.applyScreen);
        } else {
          Navigator.of(context).pushNamed(
            RouteKeys.companyScreen,
            arguments: instance.get<AppBloc>().state.userEntity.business.toString(),
          );
        }
        break;
      case 3:
        Navigator.of(context).pushNamed(RouteKeys.bookmarkScreen);
        break;
      case 4:
        if (isVerify) {
          Navigator.of(context).pushNamed(RouteKeys.contractWaitingSignScreen);
        } else {
          AlertUtils.showMessage(
            instance.get<AppLocalization>().translate('notification'),
            instance.get<AppLocalization>().translate('notBalancePleaseVerify'),
          );
        }
        break;
      case 5:
        if (isVerify) {
          Navigator.of(context).pushNamed(RouteKeys.signedScreen);
        } else {
          AlertUtils.showMessage(
            instance.get<AppLocalization>().translate('notification'),
            instance.get<AppLocalization>().translate('notBalancePleaseVerify'),
          );
        }
        break;
      case 6:
        if (!isVerify) {
          AlertUtils.showMessage(
            instance.get<AppLocalization>().translate('notification'),
            instance.get<AppLocalization>().translate('notBalancePleaseVerify'),
          );
          return;
        }

        if (isUser) {
          Navigator.of(context).pushNamed(RouteKeys.cvScreen);
        } else {
          Navigator.of(context).pushNamed(RouteKeys.upPostScreen);
        }
        break;
      case 7:
        Navigator.of(context).pushNamed(RouteKeys.graphScreen);
        break;
      default:
        Navigator.of(context).pushNamed(RouteKeys.developScreen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 1,
        ),
        itemCount: staticMenuSelection.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => navigateTo(index),
                  child: Container(
                    height: 48.w,
                    width: 48.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      staticMenuSelection[index]['icon'],
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
                4.verticalSpace,
                Text(
                  staticMenuSelection[index]['title'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
