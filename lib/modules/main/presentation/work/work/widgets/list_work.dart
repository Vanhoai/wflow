import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
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
                  child: ListView.separated(
                    cacheExtent: 100,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
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
                          elevation: 2,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          BlocConsumer<WorkBloc, WorkState>(
            listener: (context, state) {
              if (state.isFinal) {
                // Fluttertoast.showToast(
                //   msg: 'Đã hiển thị hết bài đăng',
                //   toastLength: Toast.LENGTH_SHORT,
                //   gravity: ToastGravity.CENTER,
                //   timeInSecForIosWeb: 1,
                //   fontSize: 16.0,
                // );
              }
            },
            buildWhen: (prev, cur) =>
                prev.isLoading != cur.isLoading || prev.isLoadMore != cur.isLoadMore || prev.isFinal != cur.isFinal,
            builder: (context, state) {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<WorkBloc>().add(RefreshEvent());
                  },
                  child: SizedBox(
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
                                radius: 12,
                              ),
                            );
                          }

                          final post = state.posts[index];

                          return Container(
                            constraints: const BoxConstraints(maxHeight: 270),
                            child: JobCard(
                              cardPressed: () => pressCard(post.id),
                              margin: const EdgeInsets.symmetric(horizontal: 20.0),
                              boxDecoration: BoxDecoration(
                                color: themeData.colorScheme.background,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                  BoxShadow(
                                    color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
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
                                    child: SvgPicture.asset(
                                      AppConstants.bookmark,
                                      height: 24,
                                      width: 24,
                                      colorFilter: ColorFilter.mode(
                                        themeData.colorScheme.onBackground.withOpacity(0.5),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                ],
                              ),
                              cost: '${post.salary} VND',
                              duration: post.duration,
                              description: TextMore(
                                post.content,
                                trimMode: TrimMode.Hidden,
                                trimHiddenMaxLines: 3,
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
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
