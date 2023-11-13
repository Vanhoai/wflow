import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/utils/utils.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/data/cv/model/request_model.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/presentation/home/add_cv/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/widgets/widget.dart';

class AddCVScreen extends StatefulWidget {
  const AddCVScreen({super.key});

  @override
  State<AddCVScreen> createState() => _AddCVScreenState();
}

class _AddCVScreenState extends State<AddCVScreen> {
  final TextEditingController titleEditorController = TextEditingController();
  final TextEditingController contentEditorController = TextEditingController();
  final PdfViewerController pdfViewerController = PdfViewerController();
  File? file;

  Future<void> chosePDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        this.file = file;
      });
    } else {
      AlertUtils.showMessage('Notification', 'No file selected');
    }
  }

  Future<void> listener(BuildContext context, AddCVState state) async {
    if (state is AddCVSuccessState) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Notification',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: const Text('Add CV Success'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text('OK'),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

  _addCV(BuildContext context) {
    if (file != null) {
      RequestAddCV requestAddCV =
          RequestAddCV(cv: file!, title: titleEditorController.text, content: contentEditorController.text);
      BlocProvider.of<AddCVBloc>(context).add(AddMyCVEvent(requestAddCV: requestAddCV));
    }
  }

  @override
  void dispose() {
    titleEditorController.dispose();
    contentEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCVBloc(cvUseCase: instance.get<CVUseCase>()),
      lazy: true,
      child: CommonScaffold(
        appBar: const AppHeader(text: 'Add CV'),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: BlocConsumer<AddCVBloc, AddCVState>(
            listener: listener,
            builder: (context, state) {
              return Stack(
                children: [
                  CustomScrollView(
                    clipBehavior: Clip.none,
                    cacheExtent: 1000,
                    dragStartBehavior: DragStartBehavior.start,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              TextFieldHelper(
                                enabled: true,
                                controller: titleEditorController,
                                minLines: 1,
                                maxLines: 1,
                                hintText: 'Enter cv heading',
                                keyboardType: TextInputType.name,
                              ),
                              12.verticalSpace,
                              TextFieldHelper(
                                enabled: true,
                                controller: contentEditorController,
                                minLines: 2,
                                maxLines: 3,
                                hintText: 'Enter cv description (optional)',
                                keyboardType: TextInputType.name,
                              ),
                              12.verticalSpace,
                              InkWell(
                                onTap: () => chosePDFFile(),
                                child: Builder(
                                  builder: (context) {
                                    if (file != null) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 400.h,
                                        child: SfPdfViewer.file(
                                          File(file!.path),
                                          pageLayoutMode: PdfPageLayoutMode.single,
                                          scrollDirection: PdfScrollDirection.horizontal,
                                          controller: pdfViewerController,
                                          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                                            print(details.description);
                                          },
                                        ),
                                      );
                                    }

                                    return Container(
                                      height: 200.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: Colors.grey.shade300),
                                        color: Colors.grey.shade100,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              60.verticalSpace,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(20.r),
                        child: PrimaryButton(
                          label: 'Add',
                          onPressed: () {
                            _addCV(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Visibility(
                      visible: state.isLoading,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white.withOpacity(0.1),
                        child: const Loading(),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
