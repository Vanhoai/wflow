import 'package:flutter/material.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/home/post/candidate_list/widgets/widgets.dart';

class CandidateListScreen extends StatefulWidget {
  const CandidateListScreen({super.key});

  @override
  State<CandidateListScreen> createState() => _CandidateListScreenState();
}

class _CandidateListScreenState extends State<CandidateListScreen> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  final String _searchText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController(text: _searchText);
    _scrollController = ScrollController(initialScrollOffset: 0);

    _searchController.addListener(() {
      print(_searchController.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void navigateCandidateContract(BuildContext context) {
    Navigator.of(context).pushNamed(RouteKeys.candidateContractScreen);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, false),
              ),
              backgroundColor: themeData.colorScheme.background,
              surfaceTintColor: Colors.transparent,
              pinned: false,
              snap: false,
              floating: true,
              title: Text(
                'Candidates',
                style: themeData.textTheme.displayLarge!.merge(TextStyle(
                  color: themeData.colorScheme.onBackground,
                  fontSize: 18,
                )),
              ),
              centerTitle: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: SearchCandidateWidget(
                  textEditingController: _searchController,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: CandidateItemWidget(
                  onTapLeading: () {
                    navigateCandidateContract(context);
                  },
                  onTapChat: () {},
                  onTapCv: () {},
                  onTapName: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
