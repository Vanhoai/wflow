import 'package:flutter/material.dart';
import 'package:wflow/modules/main/presentation/work/search_work/utils/constants.dart';
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

  @override
  void initState() {
    _controller = TextEditingController();
    _isHiddenSuffixIcon = true;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangedSearch(String value) {
    List<Map<String, dynamic>> result = [];

    if (value.isEmpty) {
      result = posts;
    } else {
      result = posts
          .where((post) => post['position']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }

    setState(() {
      _isHiddenSuffixIcon = value.isEmpty;
      foundPosts = result;
    });
  }

  void _onClearSearch() {
    setState(() {
      _isHiddenSuffixIcon = true;
      foundPosts = posts;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Search for work'),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          SearchWorkBar(
            controller: _controller,
            isHiddenSuffixIcon: _isHiddenSuffixIcon,
            onChangedSearch: (value) => _onChangedSearch(value),
            onClearSearch: () => _onClearSearch(),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => WorkCard(
                position: foundPosts[index]['position'],
                company: foundPosts[index]['company'],
                content: foundPosts[index]['content'],
                image: foundPosts[index]['image'],
              ),
              itemCount: foundPosts.length,
            ),
          )
        ],
      ),
    );
  }
}
