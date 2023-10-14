import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/widgets/widget.dart';

class CandidateContractScreen extends StatefulWidget {
  const CandidateContractScreen({super.key});

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
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          clipBehavior: Clip.none,
          cacheExtent: 1000,
          controller: scrollController,
          dragStartBehavior: DragStartBehavior.start,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, false),
              ),
              surfaceTintColor: Colors.transparent,
              pinned: true,
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              sliver: CandidateContractInfoWidget(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              sliver: SliverToBoxAdapter(
                child: CandidateCVWidget(
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
        ),
      ),
    );
  }
}
