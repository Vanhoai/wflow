import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/widgets/related_job_card_widget.dart';
import 'package:wflow/modules/main/presentation/work/work/bloc/bloc.dart';

class RelatedJobWidget extends StatefulWidget {
  const RelatedJobWidget({super.key, required this.scrollController, required this.currentJobId});

  final ScrollController scrollController;
  final num currentJobId;

  @override
  State<RelatedJobWidget> createState() => _RelatedJobWidgetState();
}

class _RelatedJobWidgetState extends State<RelatedJobWidget> {
  void pressCard(num work) {
    Navigator.pushNamed(context, RouteKeys.jobInformationScreen, arguments: work);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: BlocProvider<WorkBloc>(
          create: (context) =>
              WorkBloc(postUseCase: instance.call(), categoryUseCase: instance.call())..add(GetRelationPostEvent()),
          lazy: true,
          child: BlocBuilder<WorkBloc, WorkState>(
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
                      separatorBuilder: (context, index) {
                        final job = state.posts[index];
                        if (widget.currentJobId == job.id) return const SizedBox();
                        return const SizedBox(width: 20);
                      },
                      controller: widget.scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: state.posts.length,
                      padding: const EdgeInsets.only(left: 20.0),
                      itemBuilder: (context, index) {
                        final job = state.posts[index];

                        if (widget.currentJobId == job.id) return const SizedBox();

                        return RelatedJobCardWidget(
                          job: job,
                          constraints: constraints,
                          pressCard: pressCard,
                          paymentAvailable: job.paymentAvailable,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
