import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/home/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/home/widgets/hot_job_card.dart';

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
                      return HotJobCard(
                        job: job,
                        constraints: constraints,
                        pressCard: pressCard,
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
