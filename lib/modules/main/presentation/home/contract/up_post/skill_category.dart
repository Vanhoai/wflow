import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';

class SkillAndCategory extends StatefulWidget {
  const SkillAndCategory({super.key});

  @override
  State<SkillAndCategory> createState() => _SkillAndCategoryState();
}

class _SkillAndCategoryState extends State<SkillAndCategory> {
  void addSkill(UpPostBloc bloc) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (_) => BlocProvider<UpPostBloc>.value(
        value: bloc,
        child: FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                BlocBuilder<UpPostBloc, UpPostState>(
                  builder: (context, state) {
                    return ChipsChoice<CategoryEntity>.multiple(
                      wrapped: true,
                      value: state.skillSelected,
                      onChanged: (val) {},
                      choiceItems: C2Choice.listFrom<CategoryEntity, CategoryEntity>(
                        source: state.skills,
                        value: (i, v) => v,
                        label: (i, v) => v.name,
                      ),
                      choiceBuilder: (item, index) {
                        final selected = state.skillSelected.contains(item.value);

                        return InkWell(
                          onTap: () {
                            context.read<UpPostBloc>().add(ToggleSkillEvent(item.value));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: selected ? AppColors.primary : AppColors.primary.withOpacity(0.7),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item.value.name,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                ),
                                6.horizontalSpace,
                                Visibility(
                                  visible: selected,
                                  child: SvgPicture.asset(
                                    AppConstants.close,
                                    height: 16,
                                    width: 16,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: PrimaryButton(
                    label: 'Done',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCategory(UpPostBloc bloc) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (_) => BlocProvider<UpPostBloc>.value(
        value: bloc,
        child: FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                BlocBuilder<UpPostBloc, UpPostState>(
                  builder: (context, state) {
                    return ChipsChoice<CategoryEntity>.multiple(
                      wrapped: true,
                      value: state.categorySelected,
                      onChanged: (val) {},
                      choiceItems: C2Choice.listFrom<CategoryEntity, CategoryEntity>(
                        source: state.categories,
                        value: (i, v) => v,
                        label: (i, v) => v.name,
                      ),
                      choiceBuilder: (item, index) {
                        final selected = state.categorySelected.contains(item.value);

                        return InkWell(
                          onTap: () {
                            context.read<UpPostBloc>().add(ToggleCategoryEvent(item.value));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: selected ? AppColors.primary : AppColors.primary.withOpacity(0.7),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item.value.name,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                ),
                                6.horizontalSpace,
                                Visibility(
                                  visible: selected,
                                  child: SvgPicture.asset(
                                    AppConstants.close,
                                    height: 16,
                                    width: 16,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: PrimaryButton(
                    label: 'Done',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<UpPostBloc, UpPostState>(
      builder: (context, state) {
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Skills',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(
                            color: themeData.colorScheme.onBackground,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => addSkill(context.read<UpPostBloc>()),
                        borderRadius: BorderRadius.circular(4),
                        child: Text(
                          'Add',
                          style: themeData.textTheme.displayMedium!.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                8.verticalSpace,
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, state) => 12.horizontalSpace,
                    itemCount: state.skillSelected.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: themeData.colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(state.skillSelected[index].name),
                            4.horizontalSpace,
                            InkWell(
                              onTap: () {
                                context.read<UpPostBloc>().add(ToggleSkillEvent(state.skillSelected[index]));
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppConstants.close,
                                  height: 14.w,
                                  width: 14.w,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: themeData.textTheme.displayMedium!.merge(
                          TextStyle(
                            color: themeData.colorScheme.onBackground,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => addCategory(context.read<UpPostBloc>()),
                        borderRadius: BorderRadius.circular(4),
                        child: Text(
                          'Add',
                          style: themeData.textTheme.displayMedium!.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                8.verticalSpace,
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, state) => 12.horizontalSpace,
                    itemCount: state.categorySelected.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: themeData.colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(state.categorySelected[index].name),
                            4.horizontalSpace,
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  AppConstants.close,
                                  height: 14.w,
                                  width: 14.w,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
