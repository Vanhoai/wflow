import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/work/work/bloc/bloc.dart';

class ListWorks extends StatefulWidget {
  const ListWorks({super.key});

  @override
  State<ListWorks> createState() => _ListWorksState();
}

class _ListWorksState extends State<ListWorks> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void pressCard(num work) {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen, arguments: work);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        context.read<WorkBloc>().add(LoadMoreEvent());
      }
    });

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Categories',
              style: themeData.textTheme.displayMedium,
            ),
          ),
          BlocBuilder<WorkBloc, WorkState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20, top: 8),
                height: 40,
                child: Visibility(
                  replacement: Shimmer.fromColors(
                    baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                    highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                    child: ListView.separated(
                      cacheExtent: 100,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 32,
                          child: ChoiceChip.elevated(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            label: Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            selected: false,
                            onSelected: (value) {},
                            showCheckmark: false,
                            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                            visualDensity: VisualDensity.compact,
                            labelStyle: themeData.textTheme.labelMedium!.copyWith(
                              color: themeData.colorScheme.onBackground.withOpacity(0.5),
                            ),
                            elevation: 2,
                          ),
                        );
                      },
                    ),
                  ),
                  child: ListView.separated(
                    cacheExtent: 100,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = state.categories[index].name;
                      final selected = category == state.categorySelected;

                      return SizedBox(
                        height: 32,
                        child: ChoiceChip.elevated(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          label: Text(category),
                          selected: selected,
                          onSelected: (value) =>
                              context.read<WorkBloc>().add(OnSelectCategoryEvent(category: category)),
                          showCheckmark: false,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                          labelStyle: themeData.textTheme.labelMedium!.copyWith(
                            color: selected ? Colors.white : themeData.colorScheme.onBackground,
                          ),
                          color: selected
                              ? const MaterialStatePropertyAll(AppColors.primary)
                              : MaterialStatePropertyAll(themeData.colorScheme.background),
                          elevation: 1,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          BlocBuilder<WorkBloc, WorkState>(
            buildWhen: (prev, cur) =>
                prev.isLoading != cur.isLoading ||
                prev.isLoadMore != cur.isLoadMore ||
                prev.isFinal != cur.isFinal ||
                prev.bookmarks != cur.bookmarks,
            builder: (context, state) {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<WorkBloc>().add(RefreshEvent());
                  },
                  child: Visibility(
                    visible: !state.isLoading,
                    replacement: ShimmerWork(
                      physics: const NeverScrollableScrollPhysics(),
                      height: 280,
                      width: double.infinity,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: themeData.colorScheme.onBackground.withOpacity(0.8),
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: state.posts.length + 1,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 20, top: 2),
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16.0);
                      },
                      itemBuilder: (context, index) {
                        if (index == state.posts.length) {
                          return Visibility(
                            visible: !state.isFinal && state.isLoadMore,
                            replacement: const SizedBox(),
                            child: const CupertinoActivityIndicator(
                              radius: 16,
                            ),
                          );
                        }

                        final post = state.posts[index];

                        return Container(
                          constraints: const BoxConstraints(maxHeight: 270),
                          child: JobCard(
                            time: post.updatedAt!,
                            jobId: post.id,
                            cardPressed: () => pressCard(post.id),
                            margin: const EdgeInsets.symmetric(horizontal: 20.0),
                            boxDecoration: BoxDecoration(
                              color: themeData.colorScheme.background,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: const Offset(-1, 1),
                                ),
                                BoxShadow(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: const Offset(-0.5, -0.5),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            header: Header(
                              leadingPhotoUrl: post.companyLogo,
                              title: Text(
                                post.position,
                                style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                )),
                              ),
                              onTapLeading: () {},
                              subtitle: Text(
                                post.companyName,
                                style: themeData.textTheme.displayMedium!.merge(TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                )),
                              ),
                              leadingSize: 30,
                              actions: [
                                InkWell(
                                  onTap: () => context.read<WorkBloc>().add(ToggleBookmarkWorkEvent(
                                      id: post.id, index: index, isBookmarkeded: !state.bookmarks[index])),
                                  child: SvgPicture.asset(
                                    AppConstants.bookmark,
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      state.bookmarks[index]
                                          ? themeData.colorScheme.primary
                                          : themeData.colorScheme.onBackground.withOpacity(0.5),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                              ],
                            ),
                            cost: instance.get<ConvertString>().moneyFormat(value: post.salary),
                            duration: post.duration,
                            description: Text(
                              post.content,
                              maxLines: 4,
                              style: themeData.textTheme.displayMedium!.merge(
                                TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
