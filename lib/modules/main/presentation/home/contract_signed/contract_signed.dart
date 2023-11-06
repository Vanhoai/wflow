import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/contract_signed/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract_signed/widgets/shimmer_signed_card.dart';
import 'package:wflow/modules/main/presentation/home/contract_signed/widgets/signed_card.dart';

class ContractSignedScreen extends StatefulWidget {
  const ContractSignedScreen({super.key});

  @override
  State<ContractSignedScreen> createState() => _ContractSignedScreenState();
}

class _ContractSignedScreenState extends State<ContractSignedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContractSignedBloc(
        contractUseCase: instance.get<ContractUseCase>(),
      )..add(ContractSignedEventFetch()),
      child: CommonScaffold(
        hideKeyboardWhenTouchOutside: true,
        appBar: const AppHeader(text: 'Contract Waiting Sign'),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SharedSearchBar(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                onClear: () {},
                onSearch: (value) {},
              ),
              Expanded(
                child: BlocBuilder<ContractSignedBloc, ContractSignedState>(
                  builder: (context, state) {
                    return SizedBox(
                      child: Visibility(
                        visible: !state.isLoading,
                        replacement: const ShimmerSignedCard(),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<ContractSignedBloc>().add(ContractSignedEventRefresh());
                          },
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => 16.verticalSpace,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: state.contracts.length,
                            itemBuilder: (context, index) {
                              final contractEntity = state.contracts[index];
                              return SignedCard(contractEntity: contractEntity);
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
