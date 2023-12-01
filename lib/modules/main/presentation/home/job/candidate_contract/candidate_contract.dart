import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/contract/contract_usecase.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/bloc/state.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/widgets/widget.dart';

class CandidateContractScreen extends StatefulWidget {
  const CandidateContractScreen({required this.candidate, super.key});

  final String candidate;

  @override
  State<CandidateContractScreen> createState() => _CandidateContractScreenState();
}

class _CandidateContractScreenState extends State<CandidateContractScreen> {
  late final PdfViewerController pdfViewerController;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    pdfViewerController = PdfViewerController();
    scrollController = ScrollController();
  }

  void navigateToCreateContract() {
    Navigator.of(context).pushNamed(RouteKeys.createContractScreen, arguments: widget.candidate);
  }

  @override
  void dispose() {
    pdfViewerController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (_) => CandidateDetailBloc(contractUseCase: instance.get<ContractUseCase>())
        ..add(GetCandidateDetailEvent(id: widget.candidate)),
      child: CommonScaffold(
        appBar: AppHeader(
          text: Text(
            'Chi tiết ứng viên',
            style: themeData.textTheme.displayMedium,
          ),
        ),
        hideKeyboardWhenTouchOutside: true,
        body: BlocBuilder<CandidateDetailBloc, CandidateDetailState>(
          builder: (context, state) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<CandidateDetailBloc>().add(GetCandidateDetailEvent(id: widget.candidate));
                    },
                    child: Stack(
                      children: [
                        Builder(
                          builder: (context) {
                            if (state is GetCandidateDetailSuccessState) {
                              return CustomScrollView(
                                clipBehavior: Clip.none,
                                cacheExtent: 1000,
                                controller: scrollController,
                                dragStartBehavior: DragStartBehavior.start,
                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                slivers: [
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    sliver: CandidateContractInfoWidget(
                                        candidateName: state.contractEntity.worker.name,
                                        introduction: state.contractEntity.introduction),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    sliver: SliverToBoxAdapter(
                                      child: CandidateCVWidget(
                                        cv: state.contractEntity.cv,
                                        pdfViewerController: pdfViewerController,
                                      ),
                                    ),
                                  ),
                                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                                ],
                              );
                            } else if (state is GetCandidateDetailFailureState) {
                              return Center(
                                child: Text('Không có thông tin', style: Theme.of(context).textTheme.bodyLarge),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Positioned(
                          child: Visibility(
                            visible: state.isLoading,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black12,
                              child: const Loading(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: PrimaryButton(
                        label: 'Tạo họp đồng',
                        onPressed: navigateToCreateContract,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
