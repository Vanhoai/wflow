import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/modules/main/domain/post/post_usecase.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/event.dart';
import 'package:wflow/modules/main/presentation/work/search_work/bloc/state.dart';
import 'package:wflow/modules/main/presentation/work/search_work/widgets/search_work_bar.dart';
import 'package:wflow/modules/main/presentation/work/search_work/widgets/work_card.dart';

class SearchWorkScreen extends StatefulWidget {
  const SearchWorkScreen({super.key});

  @override
  State<SearchWorkScreen> createState() => _SearchWorkScreenState();
}

class _SearchWorkScreenState extends State<SearchWorkScreen> {
  late final TextEditingController _controller;
  late bool _isHiddenSuffixIcon;
  Timer? _debounce;

  @override
  void initState() {
    _controller = TextEditingController();
    _isHiddenSuffixIcon = true;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChangedSearch(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      BlocProvider.of<SearchWorkBloc>(context)
          .add(ChangedSearchWorkEvent(txtSearch: value));
    });
  }

  void _onClearSearch() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchWorkBloc(postUseCase: instance.get<PostUseCase>()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Search for work'),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SearchWorkBloc, SearchWorkState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              SearchWorkBar(
                controller: _controller,
                isHiddenSuffixIcon: _isHiddenSuffixIcon,
                onChangedSearch: (value) => _onChangedSearch(value, context),
                onClearSearch: () => _onClearSearch(),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => WorkCard(
                    position: state.postsData[index].position,
                    company: state.postsData[index].companyName,
                    content: state.postsData[index].content,
                    image: state.postsData[index].companyLogo,
                    onTap: () => {},
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
