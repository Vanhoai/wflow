import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/presentation/home/post/candidate_contract/widgets/widget.dart';

class CandidateContractScreen extends StatefulWidget {
  const CandidateContractScreen({super.key});

  @override
  State<CandidateContractScreen> createState() => _CandidateContractScreenState();
}

class _CandidateContractScreenState extends State<CandidateContractScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      isSafe: true,
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              sliver: SliverToBoxAdapter(
                child: CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  slivers: [
                    const CandidateContractInfoWidget(),
                    // IntroductionWidget(),
                    const CandidateCVWidget(),
                    SliverToBoxAdapter(
                      child: PrimaryButton(
                        label: 'Create Contract',
                        onPressed: () {},
                        width: double.infinity,
                      ),
                    ),
                  ],
                  clipBehavior: Clip.none,
                  cacheExtent: 1000,
                  dragStartBehavior: DragStartBehavior.start,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
