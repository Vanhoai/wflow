import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
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
  late final ThemeData themeData;
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
    themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => SearchWorkBloc(postUseCase: instance.get<PostUseCase>())
        ..add(
          const InitSearchWorkEvent(),
        ),
      child: Scaffold(
        appBar: const AppHeader(text: 'Works'),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchWorkBloc, SearchWorkState>(
      builder: (context, state) {
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset) {
            BlocProvider.of<SearchWorkBloc>(context)
                .add(const ScrollSearchWorkEvent());
          }
        });
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              SearchWorkBar(
                controller: _controller,
                isHiddenSuffixIcon: state.isHiddenSuffixIcon,
                onChangedSearch: (value) => {
                  BlocProvider.of<SearchWorkBloc>(context)
                      .add(ChangedIconClearSearchWorkEvent(txtSearch: value)),
                  if (_debounce?.isActive ?? false) _debounce?.cancel(),
                  _debounce = Timer(const Duration(milliseconds: 400), () {
                    BlocProvider.of<SearchWorkBloc>(context)
                        .add(ChangedSearchWorkEvent(txtSearch: value));
                  })
                },
                onClearSearch: () => {
                  _controller.clear(),
                  BlocProvider.of<SearchWorkBloc>(context).add(
                      const ChangedIconClearSearchWorkEvent(txtSearch: '')),
                },
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => JobCard(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    boxDecoration: BoxDecoration(
                      color: themeData.colorScheme.background,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: themeData.colorScheme.onBackground
                              .withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: themeData.colorScheme.onBackground
                              .withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    header: Header(
                      leadingPhotoUrl: state.postsData[index].companyLogo,
                      title: Text(
                        state.postsData[index].position,
                        style:
                            themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: themeData.colorScheme.onBackground,
                        )),
                      ),
                      onTapTitle: () {},
                      onTapLeading: () {},
                      subtitle: Text(
                        state.postsData[index].companyName,
                        style:
                            themeData.textTheme.displayMedium!.merge(TextStyle(
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
                      style: themeData.textTheme.displayMedium!.merge(
                        TextStyle(
                          color: themeData.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  itemCount: state.postsData.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
