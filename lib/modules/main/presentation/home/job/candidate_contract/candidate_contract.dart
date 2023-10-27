import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
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

  void navigateToCreateContract(BuildContext context) {
    Navigator.of(context).pushNamed(RouteKeys.createContractScreen);
  }

  @override
  void dispose() {
    super.dispose();
    pdfViewerController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandidateDetailBloc(contractUseCase: instance.get<ContractUseCase>())
        ..add(GetCandidateDetailEvent(id: widget.candidate)),
      child: CommonScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          surfaceTintColor: Colors.transparent,
        ),
        hideKeyboardWhenTouchOutside: true,
        body: BlocBuilder<CandidateDetailBloc, CandidateDetailState>(
          builder: (context, state) {
            return RefreshIndicator(
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
                            SliverPadding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
                              sliver: SliverToBoxAdapter(
                                child: PrimaryButton(
                                  label: 'Create Contract',
                                  onPressed: () => navigateToCreateContract(context),
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (state is GetCandidateDetailFailureState) {
                        return Center(
                          child: Text('No Information', style: Theme.of(context).textTheme.bodyLarge),
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
            );
          },
        ),
      ),
    );
  }
}
