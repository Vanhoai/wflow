import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/widgets/contract_card_history.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/widgets/search_bar_contract_history.dart';

class ContractHistoryScreen extends StatefulWidget {
  const ContractHistoryScreen({super.key});

  @override
  State<ContractHistoryScreen> createState() => _ContractHistoryScreenState();
}

class _ContractHistoryScreenState extends State<ContractHistoryScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ContractHistoryBloc(contractUseCase: instance.get<ContractUseCase>())..add(InitContractHistoryEvent()),
      child: Scaffold(
          appBar: AppHeader(
            text: Text(
              instance.get<AppLocalization>().translate('contractCompleted') ?? 'Contract completed',
              style: themeData.textTheme.displayLarge,
            ),
          ),
          body: BlocBuilder<ContractHistoryBloc, ContractHistoryState>(
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  if (state.contractHistories.isNotEmpty) {
                    return Column(
                      children: [
                        SearchBarContractHistory(
                          controller: _controller,
                          isHiddenSuffixIcon: state.isHiddenClearIconSearch,
                          onChangedSearch: (value) => context
                              .read<ContractHistoryBloc>()
                              .add(ChangedIconClearSearchContractHistoryEvent(txtSearch: value)),
                          onClearSearch: () {
                            _controller.clear();
                            context
                                .read<ContractHistoryBloc>()
                                .add(const ChangedIconClearSearchContractHistoryEvent(txtSearch: ''));
                          },
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 20, top: 4),
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemCount: state.contractHistories.length,
                            itemBuilder: (context, index) => ContractCardHistory(
                              contractEntity: state.contractHistories[index],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: BlocBuilder<AppLoadingBloc, AppLoadingState>(
                        bloc: instance.get<AppLoadingBloc>(),
                        builder: (context, state) {
                          if (state is AppShowLoadingState) {
                            return const SizedBox();
                          } else if (state is AppHideLoadingState) {
                            return Text(instance.get<AppLocalization>().translate('dontHaveContractCompleted') ??
                                'You don\'t have any completed contract');
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    );
                  }
                },
              );
            },
          )),
    );
  }
}
