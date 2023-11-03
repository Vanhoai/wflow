import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/widgets/contract_card.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/widgets/search_contract.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
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
      create: (_) => ContractListBloc(contractUseCase: instance.get<ContractUseCase>())..add(GetListContractEvent()),
      lazy: true,
      child: BlocBuilder<ContractListBloc, ContractListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          _scrollController.addListener(() {
            if (state.meta.currentPage >= state.meta.totalPage) return;
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
              context.read<ContractListBloc>().add(GetListContractMoreEvent());
            }
          });
          return CommonScaffold(
            hideKeyboardWhenTouchOutside: true,
            appBar: const AppHeader(text: 'Works'),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<ContractListBloc>().add(GetListContractEvent());
              },
              child: Column(
                children: [
                  const SearchContract(),
                  Expanded(
                    child: Visibility(
                      visible: !state.isLoading,
                      replacement: const Loading(),
                      child: Builder(builder: (context) {
                        if (state is GetContractListSuccessState) {
                          if (state.contractEntities.isEmpty) {
                            return Center(
                              child: Text(
                                'No item applied',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _scrollController,
                            itemCount: state.contractEntities.length,
                            itemBuilder: (context, index) => ContractCard(
                              contractEntity: state.contractEntities[index],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (state is GetContractListSuccessState) {
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
