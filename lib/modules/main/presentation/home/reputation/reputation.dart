import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/feedback/entities/feedback_entity.dart';
import 'package:wflow/modules/main/domain/feedback/entities/reputation_entity.dart';
import 'package:wflow/modules/main/domain/feedback/feedback_usecase.dart';
import 'package:wflow/modules/main/presentation/home/reputation/bloc/reputation_bloc.dart';

class ReputationScreen extends StatefulWidget {
  const ReputationScreen({super.key});

  @override
  State<ReputationScreen> createState() => _ReputationScreenState();
}

class _ReputationScreenState extends State<ReputationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<ReputationBloc>(
      create: (context) => ReputationBloc(feedbackUseCase: instance.call<FeedbackUseCase>())
        ..add(ReputationLoad())
        ..add(FeedbackLoad()),
      child: CommonScaffold(
        appBar: const AppBarCenterWidget(center: Text('Reputation')),
        body: BlocConsumer<ReputationBloc, ReputationState>(
          listener: (context, state) {},
          buildWhen: (previous, current) => true,
          listenWhen: (previous, current) => true,
          builder: (context, state) {
            final ReputationEntity reputationEntity = state.reputationEntity;
            final List<FeedbackEntity> feedbacks = state.feedbacks;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ReputationBloc>().add(ReputationLoad());
                context.read<ReputationBloc>().add(FeedbackLoad());
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Visibility(
                        visible: reputationEntity.totalFeedback > 0,
                        replacement: Shimmer.fromColors(
                          baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                          highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                          child: const RatingSummary(
                            counter: 1,
                            label: 'Total Rating',
                            average: 0,
                            averageStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            counterOneStars: 0,
                            counterTwoStars: 0,
                            counterThreeStars: 0,
                            counterFourStars: 0,
                            counterFiveStars: 0,
                            color: AppColors.primary,
                          ),
                        ),
                        child: RatingSummary(
                          counter: reputationEntity.totalFeedback,
                          label: 'Total Rating',
                          average: reputationEntity.reputation,
                          averageStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          counterOneStars: reputationEntity.countStarOne,
                          counterTwoStars: reputationEntity.countStarTwo,
                          counterThreeStars: reputationEntity.countStarThree,
                          counterFourStars: reputationEntity.countStarFour,
                          counterFiveStars: reputationEntity.countStarFive,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    4.verticalSpace,
                    Visibility(
                      visible: feedbacks.isNotEmpty,
                      replacement: Shimmer.fromColors(
                        baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                        highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Header(
                                  leadingPhotoUrl: '',
                                  title: const Text(''),
                                  subtitle: const Text(''),
                                  actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
                                ),
                                4.verticalSpace,
                                RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: AppColors.primary,
                                  ),
                                  onRatingUpdate: (rating) {},
                                  glow: false,
                                  itemSize: 16,
                                  tapOnlyMode: false,
                                  ignoreGestures: true,
                                ),
                                4.verticalSpace,
                                TextMore(
                                  '',
                                  style: themeData.textTheme.displayMedium!,
                                  trimLines: 5,
                                  trimMode: TrimMode.Line,
                                ),
                                8.verticalSpace,
                              ],
                            );
                          },
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final FeedbackEntity feedbackEntity = feedbacks[index];
                          final date =
                              DateFormat('dd/MM/yyyy').format(DateTime.parse(feedbackEntity.createdAt.toString()));
                          final time =
                              DateFormat('HH:mm:ss').format(DateTime.parse(feedbackEntity.createdAt.toString()));
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Header(
                                leadingPhotoUrl: feedbackEntity.businessLogo,
                                title: Text(feedbackEntity.businessName, style: themeData.textTheme.displayMedium),
                                subtitle: Text(
                                  '$date $time',
                                  style: themeData.textTheme.displaySmall,
                                ),
                                actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
                              ),
                              4.verticalSpace,
                              RatingBar.builder(
                                initialRating: feedbackEntity.star.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: AppColors.primary,
                                ),
                                onRatingUpdate: (rating) {},
                                glow: false,
                                itemSize: 16,
                                tapOnlyMode: false,
                                ignoreGestures: true,
                              ),
                              4.verticalSpace,
                              TextMore(
                                feedbackEntity.description,
                                style: themeData.textTheme.displayMedium!,
                                trimLines: 5,
                                trimMode: TrimMode.Line,
                              ),
                              8.verticalSpace,
                            ],
                          );
                        },
                        itemCount: feedbacks.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
