import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CandidateCVWidget extends StatefulWidget {
  const CandidateCVWidget({super.key, required this.pdfViewerController, required this.cv});
  final String cv;
  final PdfViewerController pdfViewerController;

  @override
  State<CandidateCVWidget> createState() => _CandidateCVWidgetState();
}

class _CandidateCVWidgetState extends State<CandidateCVWidget> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '# CV',
          style: themeData.textTheme.displayLarge!.merge(TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          )),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 530,
          child: Scaffold(
            body: SfPdfViewer.network(
              widget.cv,
              pageLayoutMode: PdfPageLayoutMode.single,
              scrollDirection: PdfScrollDirection.horizontal,
              controller: widget.pdfViewerController,
              key: _pdfViewerKey,
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                print(details.toString());
              },
            ),
          ),
        ),
      ],
    );
  }
}
