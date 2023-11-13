import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/enum/role_enum.dart';
import 'package:wflow/core/routes/keys.dart';

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
        'title': 'Balance',
        'icon': AppConstants.ic_balance,
      },
      {
        'title': 'Reputation',
        'icon': AppConstants.ic_reputation,
      },
      {
        'title': isUser ? 'Apply' : 'Business',
        'icon': isUser ? AppConstants.apply : AppConstants.ic_business,
      },
      {
        'title': 'Bookmark',
        'icon': AppConstants.ic_bookmark_navigate,
      },
      {
        'title': 'Sign',
        'icon': AppConstants.ic_more,
      },
      {
        'title': 'Signed',
        'icon': AppConstants.ic_signed,
      },
      {
        'title': isUser ? 'Cv' : 'Completed',
        'icon': isUser ? AppConstants.ic_cv : AppConstants.history,
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

    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(RouteKeys.balanceScreen, arguments: balance.toString());
        break;
      case 1:
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
        Navigator.of(context).pushNamed(RouteKeys.contractWaitingSignScreen);
        break;
      case 5:
        Navigator.of(context).pushNamed(RouteKeys.signedScreen);
        break;
      case 6:
        if (isUser) {
          Navigator.of(context).pushNamed(RouteKeys.addCVScreen);
        } else {
          Navigator.of(context).pushNamed(RouteKeys.completedContractScreen);
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
