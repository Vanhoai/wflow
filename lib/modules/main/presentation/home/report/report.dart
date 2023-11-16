import 'package:flutter/cupertino.dart';
import 'package:wflow/core/enum/enum.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.type, required this.target});
  final ReportEnum type;
  final num target;
  @override
  State<StatefulWidget> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
