import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/state.dart';
import 'package:wflow/modules/main/presentation/work/search_work/widgets/search_work_bar.dart';
import 'package:flutter_svg/svg.dart';

class SearchWorkScreen extends StatefulWidget {
  const SearchWorkScreen({super.key});

  @override
  State<SearchWorkScreen> createState() => _SearchWorkScreenState();
}

class _SearchWorkScreenState extends State<SearchWorkScreen> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => SearchWorkBloc(postUseCase: instance.get<PostUseCase>())
        ..add(
          InitSearchWorkEvent(),
        ),
      child: Scaffold(
        appBar: const AppHeader(text: 'Works'),
        body: BlocBuilder<SearchWorkBloc, SearchWorkState>(
          builder: (context, state) {
            _scrollController.addListener(() {
              if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent &&
                  !state.isLoadMore) {
                BlocProvider.of<SearchWorkBloc>(context)
                    .add(ScrollSearchWorkEvent());
              }
            });

            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  SearchWorkBar(
                    controller: _controller,
                    isHiddenSuffixIcon: state.txtSearch.isEmpty,
                    onChangedSearch: (value) => {
                      BlocProvider.of<SearchWorkBloc>(context).add(
                          ChangedIconClearSearchWorkEvent(txtSearch: value)),
                      if (_debounce?.isActive ?? false) _debounce?.cancel(),
                      _debounce = Timer(const Duration(milliseconds: 400), () {
                        BlocProvider.of<SearchWorkBloc>(context)
                            .add(ChangedSearchWorkEvent(txtSearch: value));
                      }),
                    },
                    onClearSearch: () => {
                      _controller.clear(),
                      BlocProvider.of<SearchWorkBloc>(context).add(
                          const ChangedIconClearSearchWorkEvent(txtSearch: '')),
                      BlocProvider.of<SearchWorkBloc>(context)
                          .add(const ChangedSearchWorkEvent(txtSearch: '')),
                    },
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if ((state).postsData.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async =>
                                BlocProvider.of<SearchWorkBloc>(context)
                                    .add(RefreshSearchWorkEvent()),
                            child: ListView.separated(
                              controller: _scrollController,
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 4),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 270),
                                child: JobCard(
                                  jobId: state.postsData[index].id,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  boxDecoration: BoxDecoration(
                                    color: themeData.colorScheme.background,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: themeData
                                            .colorScheme.onBackground
                                            .withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                      BoxShadow(
                                        color: themeData
                                            .colorScheme.onBackground
                                            .withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  header: Header(
                                    leadingPhotoUrl:
                                        state.postsData[index].companyLogo,
                                    title: Text(
                                      state.postsData[index].position,
                                      style: themeData.textTheme.displayLarge!
                                          .merge(TextStyle(
                                        color:
                                            themeData.colorScheme.onBackground,
                                      )),
                                    ),
                                    onTapLeading: () {},
                                    subtitle: Text(
                                      state.postsData[index].companyName,
                                      style: themeData.textTheme.displayMedium!
                                          .merge(TextStyle(
                                        color:
                                            themeData.colorScheme.onBackground,
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
                                            themeData.colorScheme.onBackground
                                                .withOpacity(0.5),
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                    ],
                                  ),
                                  cost: '${state.postsData[index].salary} VND',
                                  duration: state.postsData[index].duration,
                                  description: TextMore(
                                    state.postsData[index].content,
                                    trimMode: TrimMode.Hidden,
                                    trimHiddenMaxLines: 3,
                                    style: themeData.textTheme.displayMedium!
                                        .merge(
                                      TextStyle(
                                        color:
                                            themeData.colorScheme.onBackground,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: state.postsData.length,
                            ),
                          );
                        } else {
                          return const Center(child: Text('Works is empty'));
                        }
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (state.isLoadMore) {
                        return Visibility(
                          visible: state.isLoadMore,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: const Loading(),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
