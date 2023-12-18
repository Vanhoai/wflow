import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/appbar/appbar_back_title.dart';
import 'package:wflow/core/widgets/shared/scaffold/scaffold.dart';

class GuileUseExcel extends StatelessWidget {
  const GuileUseExcel({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: AppHeader(
        text: Text(
          instance.get<AppLocalization>().translate('guileExcel') ?? 'Guile use excel',
          style: themeData.textTheme.displayLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InstaImageViewer(
              child: Image.asset(AppConstants.guileExcel, width: MediaQuery.of(context).size.width, fit: BoxFit.contain),
            )
          ],
        ),
      ),
    );
  }
}
