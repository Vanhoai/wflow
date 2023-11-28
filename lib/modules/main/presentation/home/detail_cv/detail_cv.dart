import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_contract/widgets/widget.dart';

class DetailCVScreen extends StatefulWidget {
  const DetailCVScreen({required this.cvEntity, super.key});

  final CVEntity cvEntity;

  @override
  State<DetailCVScreen> createState() => _DetailCVScreenState();
}

class _DetailCVScreenState extends State<DetailCVScreen> {
  late final PdfViewerController pdfViewerController;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    pdfViewerController = PdfViewerController();
    scrollController = ScrollController();
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
    return CommonScaffold(
        appBar: AppHeader(
          text: Text(
            'CV',
            style: themeData.textTheme.displayMedium,
          ),
        ),
        hideKeyboardWhenTouchOutside: true,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: CustomScrollView(
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
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '# Tiêu đề',
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                          fontSize: 18,
                        )),
                      ),
                      Text(
                        widget.cvEntity.title,
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18,
                        )),
                      ),
                      const SizedBox(height: 40.0),
                      Text(
                        '# Mô tả',
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                          fontSize: 18,
                        )),
                      ),
                      Text(
                        widget.cvEntity.content,
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                sliver: SliverToBoxAdapter(
                  child: CandidateCVWidget(
                    cv: widget.cvEntity.url,
                    pdfViewerController: pdfViewerController,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ));
  }
}
