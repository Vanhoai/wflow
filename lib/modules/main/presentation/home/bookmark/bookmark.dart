import 'package:flutter/material.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const AppHeader(text: 'Bookmark  Works'),
      body: Container(),
    );
  }
}
