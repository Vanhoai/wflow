import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wflow/core/theme/them.dart';

class Loading extends StatefulWidget {
  const Loading({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      color: Colors.transparent,
      child: const CupertinoActivityIndicator(radius: 16),
    );
  }
}

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromARGB(20, 24, 24, 24),
      child: const Center(
        child: CupertinoActivityIndicator(radius: 16),
      ),
    );
  }
}

class LoadingWithWhite extends StatelessWidget {
  const LoadingWithWhite({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: themeData.colorScheme.background.withOpacity(0.5),
      child: const Loading(),
    );
  }
}
