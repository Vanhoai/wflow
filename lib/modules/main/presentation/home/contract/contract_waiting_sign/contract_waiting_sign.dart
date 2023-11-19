import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/domain/contract/entities/contract_entity.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_waiting_sign/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_waiting_sign/widgets/shimmer_sign_card.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract_waiting_sign/widgets/sign_card.dart';

class ContractWaitingSignScreen extends StatefulWidget {
  const ContractWaitingSignScreen({super.key});

  @override
  State<ContractWaitingSignScreen> createState() => _ContractWaitingSignScreenState();
}

class _ContractWaitingSignScreenState extends State<ContractWaitingSignScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => ContractWaitingSignBloc(
        contractUseCase: instance.get<ContractUseCase>(),
      )..add(ContractWaitingSignEventFetch()),
      child: CommonScaffold(
        hideKeyboardWhenTouchOutside: true,
        appBar: AppHeader(
          text: Text(
            instance.get<AppLocalization>().translate('waitingAccept') ?? 'Waiting Accept',
            style: themeData.textTheme.displayLarge,
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              BlocBuilder<ContractWaitingSignBloc, ContractWaitingSignState>(
                builder: (context, state) {
                  return SharedSearchBar(
                    placeHolder: instance.get<AppLocalization>().translate('searchByWorkNameOrCompany') ??
                        'Search by work name or company',
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    onClear: () {
                      context.read<ContractWaitingSignBloc>().add(ContractWaitingSignEventClearSearch());
                    },
                    onSearch: (value) {
                      context.read<ContractWaitingSignBloc>().add(ContractWaitingSignEventSearch(value));
                    },
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<ContractWaitingSignBloc, ContractWaitingSignState>(
                  builder: (context, state) {
                    return SizedBox(
                      child: Visibility(
                        visible: !state.isLoading,
                        replacement: const ShimmerSignCard(),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<ContractWaitingSignBloc>().add(ContractWaitingSignEventRefresh());
                          },
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => 16.verticalSpace,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: state.contracts.length,
                            itemBuilder: (context, index) {
                              final ContractEntity contractEntity = state.contracts[index];
                              return SignCard(contractEntity: contractEntity);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
