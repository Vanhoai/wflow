import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/bloc/bloc.dart';

class RecentJobListWidget extends StatefulWidget {
  const RecentJobListWidget({super.key});

  @override
  State<RecentJobListWidget> createState() => _RecentJobListWidgetState();
}

class _RecentJobListWidgetState extends State<RecentJobListWidget> {
  void pressCard(num work) {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen,
        arguments: work);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.loadingCategory != current.loadingCategory ||
          previous.categorySelected != current.categorySelected ||
          previous.bookmarksRecent != current.bookmarksRecent,
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          sliver: Visibility(
            visible: !state.isLoading && !state.loadingCategory,
            replacement: SliverToBoxAdapter(
              child: ShimmerWork(
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
            ),
            child: SliverList.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
              itemCount: state.recentJobs.length,
              itemBuilder: (context, index) {
                final job = state.recentJobs[index];

                return Container(
                  constraints: const BoxConstraints(maxHeight: 280),
                  child: JobCard(
                    time: job.updatedAt!,
                    jobId: job.id,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    cardPressed: () => pressCard(job.id),
                    boxDecoration: BoxDecoration(
                      color: themeData.colorScheme.background,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: themeData.colorScheme.onBackground
                              .withOpacity(0.1),
                          blurRadius: 1,
                          offset: const Offset(-1, 1),
                        ),
                        BoxShadow(
                          color: themeData.colorScheme.onBackground
                              .withOpacity(0.1),
                          blurRadius: 1,
                          offset: const Offset(-0.5, -0.5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    header: Header(
                      idBusiness: job.business.toString(),
                      leadingPhotoUrl: job.companyLogo,
                      title: Text(
                        job.position,
                        style:
                            themeData.textTheme.displayLarge!.merge(TextStyle(
                          fontSize: 18,
                          color: themeData.colorScheme.onBackground,
                        )),
                      ),
                      subtitle: Text(
                        job.companyName,
                        style:
                            themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground
                              .withOpacity(0.5),
                        )),
                      ),
                      leadingSize: 30,
                      actions: [
                        InkWell(
                          onTap: () => context.read<HomeBloc>().add(
                              ToggleBookmarkRecentHomeEvent(
                                  id: job.id,
                                  index: index,
                                  isBookmarkeded:
                                      !state.bookmarksRecent[index])),
                          child: SvgPicture.asset(
                            AppConstants.bookmark,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              state.bookmarksRecent[index]
                                  ? themeData.colorScheme.primary
                                  : themeData.colorScheme.onBackground
                                      .withOpacity(0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                    cost: instance
                        .get<ConvertString>()
                        .moneyFormat(value: job.salary),
                    duration: job.duration,
                    description: Text(
                      job.content,
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
        );
      },
    );
  }
}
