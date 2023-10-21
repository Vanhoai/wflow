import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/presentation/home/company/widgets/widgets.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      isSafe: true,
      body: Column(
        children: [
          HeaderAvatarCompanyWidget(),
          Expanded(
            child: CompanyJobPostWidget(),
          )
        ],
      ),
    );
  }
}
