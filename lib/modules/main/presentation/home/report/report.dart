import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/arguments_model/arguments_photo.dart';
import 'package:wflow/core/routes/arguments_model/arguments_report.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/custom/button/button.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';
import 'package:wflow/modules/main/domain/report/report_usecase.dart';
import 'package:wflow/modules/main/presentation/home/report/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/report/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/report/bloc/state.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.argumentsReport});
  final ArgumentsReport argumentsReport;
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage({required BuildContext context}) async {
    dynamic files = await Navigator.of(context)
        .pushNamed(RouteKeys.photoScreen, arguments: ArgumentsPhoto(multiple: true, onlyImage: true));
    if (files == null) return;
    files as List<File>;
    if (context.mounted) {
      BlocProvider.of<ReportBloc>(context).add(AddImageEvent(files: files));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportBloc(reportUseCase: instance.get<ReportUseCase>()),
      child: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          return CommonScaffold(
            hideKeyboardWhenTouchOutside: true,
            appBar: AppHeader(
              text: 'Report ${widget.argumentsReport.type.name}',
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      minLines: 5,
                      maxLines: 5,
                      // and thisS
                      controller: controller,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: 'Type your report',
                        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black26),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.black26, width: 1.2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => _pickImage(context: context),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Text(
                          'Add Image',
                          style: themeData.textTheme.displayMedium!.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: AppColors.fade, borderRadius: BorderRadius.circular(8)),
                      child: ListView.builder(
                        itemCount: state.files.length,
                        shrinkWrap: true,
                        cacheExtent: 99999,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Image(
                            height: 150,
                            image: FileImage(state.files[index]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                        label: 'Send Report',
                        onPressed: () {
                          context.read<ReportBloc>().add(Submit(
                              content: controller.text,
                              type: widget.argumentsReport.type.name,
                              target: widget.argumentsReport.target));
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
