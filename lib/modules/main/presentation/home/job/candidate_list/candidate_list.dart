import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/routes/arguments_model/arguments_message.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/models/worker.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';
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
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => CandidateListBloc(
        contractUseCase: instance.get<ContractUseCase>(),
      )..add(GetCandidateAppliedListEvent(post: widget.post)),
      child: BlocBuilder<CandidateListBloc, CandidateListState>(
        builder: (context, state) {
          _scrollController.addListener(() {
            if (state.meta.currentPage >= state.meta.totalPage) return;
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
              context.read<CandidateListBloc>().add(GetCandidateAppliedListMoreEvent());
            }
          });
          return CommonScaffold(
            hideKeyboardWhenTouchOutside: true,
            appBar: AppHeader(
              text: Text(
                instance.get<AppLocalization>().translate('candidate') ?? 'candidate',
                style: themeData.textTheme.displayMedium,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<CandidateListBloc>().add(GetCandidateAppliedListEvent(post: widget.post));
              },
              child: Column(
                children: [
                  Container(
                    color: themeData.colorScheme.background,
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: const SearchCandidateWidget(),
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
                                  'Chưa có ứng viên',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              );
                            }
                            return ListView.builder(
                              padding: const EdgeInsets.all(20),
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.candidateEntities.length,
                              itemBuilder: (context, index) {
                                return CandidateItemWidget(
                                  candidateEntity: state.candidateEntities[index],
                                  onTap: () => Navigator.of(context).pushNamed(
                                    RouteKeys.candidateContractScreen,
                                    arguments: state.candidateEntities[index].id.toString(),
                                  ),
                                  onTapChat: () {
                                    Worker worker = state.candidateEntities[index].worker;
                                    UserEntity userEntity = UserEntity(
                                      id: worker.id as int,
                                      createdAt: null,
                                      updatedAt: null,
                                      deletedAt: null,
                                      address: '',
                                      age: worker.age,
                                      avatar: worker.avatar,
                                      dob: worker.dob,
                                      email: worker.email,
                                      identifyCode: worker.identifyCode,
                                      isVerify: worker.isVerify,
                                      name: worker.name,
                                      phone: worker.phone,
                                      role: worker.role as int,
                                      business: worker.business as int,
                                      balance: 0,
                                      customerID: '',
                                      background: '',
                                      bio: '',
                                      reputation: 0,
                                      workDone: 0,
                                    );
                                    ArgumentsMessage argumentsMessage =
                                        ArgumentsMessage(id: null, userEntity: userEntity);
                                    Navigator.of(context)
                                        .pushNamed(RouteKeys.messageScreen, arguments: argumentsMessage);
                                  },
                                  onTapCv: () {},
                                  onTapName: () {},
                                  onTapLeading: () {
                                    Navigator.of(context).pushNamed(RouteKeys.detailUserScreen,
                                        arguments: state.candidateEntities[index].worker.id);
                                  },
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
