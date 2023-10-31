import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
import 'package:wflow/modules/main/presentation/personal/personal/bloc/bloc.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({super.key, required this.morePressed});

  final VoidCallback morePressed;

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<PersonalBloc, PersonalState>(
      bloc: BlocProvider.of<PersonalBloc>(context),
      buildWhen: (previous, current) =>
          previous.userEntity != current.userEntity || previous.isLoading != current.isLoading,
      builder: (context, state) {
        final UserEntity userEntity = state.userEntity;
        return SliverPadding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 60.h),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userEntity.name,
                  style: themeData.textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                8.verticalSpace,
                Text(
                  userEntity.email,
                  style: themeData.textTheme.displayMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                24.verticalSpace,
                Text(
                  'I am a software engineer with 5 years of experience in the field of software development. I have worked with many programming languages and frameworks. I have a lot of experience in building large-scale applications.',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: themeData.textTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),
                ),
                20.verticalSpace,
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Reputation',
                            style: themeData.textTheme.displayMedium!
                                .copyWith(color: Theme.of(context).colorScheme.onBackground),
                          ),
                          4.verticalSpace,
                          Text(
                            '90',
                            style: themeData.textTheme.displayLarge!
                                .copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 22.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Worked',
                            style: themeData.textTheme.displayMedium!
                                .copyWith(color: Theme.of(context).colorScheme.onBackground),
                          ),
                          4.verticalSpace,
                          Text(
                            '90',
                            style: themeData.textTheme.displayLarge!
                                .copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 22.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Material(
                          color: themeData.colorScheme.background,
                          elevation: 3.0,
                          shadowColor: themeData.colorScheme.onBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pushNamed(RouteKeys.securityScreen),
                              borderRadius: BorderRadius.circular(4.r),
                              child: Center(
                                child: Text(
                                  'Security',
                                  style: themeData.textTheme.displayMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Material(
                          color: themeData.colorScheme.background,
                          elevation: 3.0,
                          shadowColor: themeData.colorScheme.onBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(4.r),
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: themeData.textTheme.displayLarge!.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Material(
                          color: themeData.colorScheme.background,
                          elevation: 3.0,
                          shadowColor: themeData.colorScheme.onBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: InkWell(
                              onTap: widget.morePressed,
                              borderRadius: BorderRadius.circular(4.r),
                              child: Center(
                                child: Text(
                                  'More',
                                  style: themeData.textTheme.displayMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
