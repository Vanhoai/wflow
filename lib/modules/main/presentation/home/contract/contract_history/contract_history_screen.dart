import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_history/widgets/contract_card_history.dart';

class ContractHistoryScreen extends StatefulWidget {
  const ContractHistoryScreen({super.key});

  @override
  State<ContractHistoryScreen> createState() => _ContractHistoryScreenState();
}

class _ContractHistoryScreenState extends State<ContractHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ContractHistoryBloc(contractUseCase: instance.get<ContractUseCase>())
            ..add(InitContractHistoryEvent()),
      child: Scaffold(
          appBar: const AppHeader(text: Text('Hợp đồng hoàn thành')),
          body: BlocBuilder<ContractHistoryBloc, ContractHistoryState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Center(
                    child: Text('Search bar here'),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20, top: 4),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: state.contractHistories.length,
                      itemBuilder: (context, index) => ContractCardHistory(
                        contractEntity: state.contractHistories[index],
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
