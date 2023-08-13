import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(body: Container());
  }
}
