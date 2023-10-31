import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/widgets/widgets.dart';

class CandidateListScreen extends StatefulWidget {
  final num post;
  const CandidateListScreen({required this.post, super.key});

  @override
  State<CandidateListScreen> createState() => _CandidateListScreenState();
}

class _CandidateListScreenState extends State<CandidateListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandidateListBloc(contractUseCase: instance.get<ContractUseCase>())
        ..add(GetCandidateAppliedListEvent(post: widget.post)),
      child: BlocBuilder<CandidateListBloc, CandidateListState>(
        builder: (context, state) {
          _scrollController.addListener(() {
            if (state.meta.currentPage >= state.meta.totalPage) return;
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
              context.read<CandidateListBloc>().add(GetCandidateAppliedListMoreEvent());
            }
          });
          return CommonScaffold(
            appBar: const AppHeader(text: 'Candidates'),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<CandidateListBloc>().add(GetCandidateAppliedListEvent(post: widget.post));
              },
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: SearchCandidateWidget(),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: !state.isLoading,
                      replacement: const Loading(),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (state is GetCandidateAppliedListSuccess) {
                            if (state.candidateEntities.isEmpty) {
                              return Center(
                                child: Text(
                                  'No candidates have applied yet',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              );
                            }
                            return ListView.separated(
                              padding: const EdgeInsets.all(20),
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.candidateEntities.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 20),
                              itemBuilder: (context, index) {
                                return CandidateItemWidget(
                                  candidateEntity: state.candidateEntities[index],
                                  onTap: () => Navigator.of(context).pushNamed(
                                    RouteKeys.candidateContractScreen,
                                    arguments: state.candidateEntities[index].id.toString(),
                                  ),
                                  onTapChat: () {},
                                  onTapCv: () {},
                                  onTapName: () {},
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (state is GetCandidateAppliedListSuccess) {
                        return Visibility(
                          visible: state.loadMore,
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
