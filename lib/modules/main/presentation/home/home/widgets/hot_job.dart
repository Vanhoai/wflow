import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/bloc/bloc.dart';

class HowJobListWidget extends StatefulWidget {
  const HowJobListWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HowJobListWidget> createState() => _HowJobListWidgetState();
}

class _HowJobListWidgetState extends State<HowJobListWidget> {
  void pressCard(num work) {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen, arguments: work);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => previous.isLoading != current.isLoading,
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Visibility(
                  visible: !state.isLoading,
                  replacement: ShimmerWork(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: themeData.colorScheme.onBackground.withOpacity(0.8),
                        width: 2,
                      ),
                    ),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(width: 20),
                    controller: widget.scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.hotJobs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemBuilder: (context, index) {
                      final job = state.hotJobs[index];

                      return Container(
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: JobCard(
                          isHorizontal: true,
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
                          cardPressed: () => pressCard(job.id),
                          padding: const EdgeInsets.all(12),
                          header: Header(
                            leadingPhotoUrl: job.companyLogo,
                            title: Text(
                              job.position,
                              style: themeData.textTheme.displayLarge!.merge(
                                TextStyle(
                                  fontSize: 18,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              job.companyName,
                              style: themeData.textTheme.displayMedium!.merge(
                                TextStyle(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            onTapTitle: () {},
                            onTapLeading: () {},
                            leadingSize: 32,
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
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
