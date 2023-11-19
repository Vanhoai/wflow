import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
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
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<ReputationBloc>(
      create: (context) => ReputationBloc(feedbackUseCase: instance.call<FeedbackUseCase>())
        ..add(ReputationLoad())
        ..add(FeedbackLoad()),
      child: CommonScaffold(
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate('reputation') ?? 'Reputation',
            style: themeData.textTheme.displayLarge,
          ),
        ),
        body: BlocConsumer<ReputationBloc, ReputationState>(
          listener: (context, state) {},
          buildWhen: (previous, current) => true,
          listenWhen: (previous, current) => true,
          builder: (context, state) {
            final ReputationEntity reputationEntity = state.reputationEntity;
            final List<FeedbackEntity> feedbacks = state.feedbacks;

            return MediaQuery(
              data: MediaQuery.of(context),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ReputationBloc>().add(ReputationLoad());
                  context.read<ReputationBloc>().add(FeedbackLoad());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: !state.isLoading,
                        replacement: Shimmer.fromColors(
                          baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                          highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                          child: RatingSummary(
                            counter: 0,
                            label: instance.get<AppLocalization>().translate('totalRating') ?? 'Total Rating',
                            average: 0,
                            averageStyle: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            counterOneStars: 0,
                            counterTwoStars: 0,
                            counterThreeStars: 0,
                            counterFourStars: 0,
                            counterFiveStars: 0,
                            color: const Color.fromARGB(255, 255, 204, 64),
                          ),
                        ),
                        child: RatingSummary(
                          counter: reputationEntity.totalFeedback,
                          label: instance.get<AppLocalization>().translate('totalRating') ?? 'Total Rating',
                          average: reputationEntity.reputation,
                          averageStyle: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          counterOneStars: reputationEntity.countStarOne,
                          counterTwoStars: reputationEntity.countStarTwo,
                          counterThreeStars: reputationEntity.countStarThree,
                          counterFourStars: reputationEntity.countStarFour,
                          counterFiveStars: reputationEntity.countStarFive,
                          color: const Color.fromARGB(255, 255, 204, 64),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20.r),
                          child: Visibility(
                            visible: !state.isLoading,
                            replacement: Shimmer.fromColors(
                              baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                              highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                              child: Container(
                                height: 20.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: themeData.colorScheme.onBackground.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                            child: Text(
                              '${reputationEntity.totalFeedback} ${instance.get<AppLocalization>().translate('feedback') ?? 'Feedbacks'}',
                              style: themeData.textTheme.displayLarge,
                            ),
                          )),
                      Visibility(
                        visible: !state.isLoading,
                        replacement: Shimmer.fromColors(
                          baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                          highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => 20.verticalSpace,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Header(
                                      leadingPhotoUrl: '',
                                      title: const Text(''),
                                      subtitle: const Text(''),
                                      actions: [
                                        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                                      ],
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
                                        color: Color.fromARGB(255, 255, 204, 64),
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
                                  ],
                                ),
                              );
                            },
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => 20.verticalSpace,
                          padding: const EdgeInsets.only(bottom: 20),
                          itemBuilder: (context, index) {
                            final FeedbackEntity feedbackEntity = feedbacks[index];
                            final date =
                                DateFormat('dd/MM/yyyy').format(DateTime.parse(feedbackEntity.createdAt.toString()));
                            final time =
                                DateFormat('HH:mm:ss').format(DateTime.parse(feedbackEntity.createdAt.toString()));

                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
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
                                      color: Color.fromARGB(255, 255, 204, 64),
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
                                ],
                              ),
                            );
                          },
                          itemCount: feedbacks.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
