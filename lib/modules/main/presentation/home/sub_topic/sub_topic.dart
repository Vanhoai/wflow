import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/domain/category/category_usecase.dart';
import 'package:wflow/modules/main/domain/category/entities/category_entity.dart';
import 'package:wflow/modules/main/presentation/home/sub_topic/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/sub_topic/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/sub_topic/bloc/state.dart';

class SubTopic extends StatefulWidget {
  const SubTopic({super.key});

  @override
  State<SubTopic> createState() => _SubTopicState();
}

class _SubTopicState extends State<SubTopic> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SubTopicBloc(categoryUseCase: instance.get<CategoryUseCase>())
            ..add(InitSubTopicEvent()),
      child: Scaffold(
        body: BlocBuilder<SubTopicBloc, SubTopicState>(
          builder: (context, state) {
            return state.categories.isNotEmpty
                ? Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              instance
                                      .get<AppLocalization>()
                                      .translate('topicYouCare') ??
                                  'Topic you care',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            ChipsChoice<CategoryEntity>.multiple(
                              wrapped: true,
                              value: state.categorySelected,
                              onChanged: (val) {},
                              choiceItems: C2Choice.listFrom<CategoryEntity,
                                  CategoryEntity>(
                                source: state.categories,
                                value: (i, v) => v,
                                label: (i, v) => v.name,
                              ),
                              choiceBuilder: (item, index) {
                                final selected =
                                    state.categorySelected.contains(item.value);

                                return InkWell(
                                  onTap: () => context.read<SubTopicBloc>().add(
                                      ToggleSubTopicEvent(
                                          category: item.value)),
                                  child: Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: selected
                                          ? AppColors.primary
                                          : AppColors.primary.withOpacity(0.7),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.value.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            context
                                .read<SubTopicBloc>()
                                .add(NextSubTopicEvent());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteKeys.bottomScreen, (route) => false);
                          },
                          child: SvgPicture.asset(
                            width: 48,
                            height: 48,
                            AppConstants.next,
                            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Lottie.asset(
                    width: 100,
                    height: 100,
                    'assets/json/loading.json',
                  ));
          },
        ),
      ),
    );
  }
}
