import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/loading/bloc.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/apply/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/apply/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/apply/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/widgets/contract_card.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplyBloc(contractUseCase: instance.get<ContractUseCase>())..add(InitApplyEvent()),
      child: BlocBuilder<ApplyBloc, ApplyState>(
        builder: (context, state) {
          _scrollController.addListener(() {
            if (_scrollController.position.maxScrollExtent == _scrollController.offset && !state.isLoadMore) {
              BlocProvider.of<ApplyBloc>(context).add(ScrollApplyEvent());
            }
          });
          return CommonScaffold(
            isSafe: true,
            appBar: AppHeader(
              text: Text(
                instance.get<AppLocalization>().translate('applied') ?? 'Applied',
                style: themeData.textTheme.displayLarge,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state.applies.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async => context.read<ApplyBloc>().add(InitApplyEvent()),
                          child: ListView.separated(
                            controller: _scrollController,
                            padding: const EdgeInsets.only(bottom: 20, top: 4),
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => ContractCard(
                              contractEntity: state.applies[index],
                            ),
                            itemCount: state.applies.length,
                          ),
                        );
                      } else {
                        return BlocBuilder<AppLoadingBloc, AppLoadingState>(
                          bloc: instance.get<AppLoadingBloc>(),
                          builder: (context, state) {
                            if (state is AppShowLoadingState) {
                              return const SizedBox();
                            } else if (state is AppHideLoadingState) {
                              return Center(
                                child: Text(
                                    instance.get<AppLocalization>().translate('appliedIsEmpty') ?? 'Applied is empty'),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (state is LoadMoreApplySate) {
                      return Visibility(
                        visible: state.isLoadMore,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
