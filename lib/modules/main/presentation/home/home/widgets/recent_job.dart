import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/bloc/bloc.dart';

class RecentJobListWidget extends StatefulWidget {
  const RecentJobListWidget({super.key});

  @override
  State<RecentJobListWidget> createState() => _RecentJobListWidgetState();
}

class _RecentJobListWidgetState extends State<RecentJobListWidget> {
  void pressCard() {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.loadingCategory != current.loadingCategory ||
          previous.categorySelected != current.categorySelected,
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

                return JobCard(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  cardPressed: pressCard,
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
                    leadingPhotoUrl: job.companyLogo,
                    title: Text(
                      job.position,
                      style: themeData.textTheme.displayLarge!.merge(TextStyle(
                        fontSize: 18,
                        color: themeData.colorScheme.onBackground,
                      )),
                    ),
                    onTapLeading: () {},
                    subtitle: Text(
                      job.companyName,
                      style: themeData.textTheme.displayMedium!.merge(TextStyle(
                        color: themeData.colorScheme.onBackground.withOpacity(0.5),
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
                  cost: '${job.salary} VND',
                  duration: job.duration,
                  description: TextMore(
                    job.content,
                    trimMode: TrimMode.Hidden,
                    trimHiddenMaxLines: 3,
                    style: themeData.textTheme.displayMedium!.merge(
                      TextStyle(
                        color: themeData.colorScheme.onBackground,
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
