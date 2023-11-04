import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String defaultUrl = 'https://www.pinclipart.com/picdir/middle/148-1486972_mystery-man-avatar-circle-clipart.png';

class Header extends StatefulWidget {
  const Header({
    super.key,
    required this.title,
    required this.subtitle,
    this.decoration,
    this.leadingSize = 30,
    this.leadingPhotoUrl = '',
    this.leadingBadge = false,
    this.onTapLeading,
    this.actions = const [],
  });
  final Widget title;
  final VoidCallback? onTapLeading;
  final Widget subtitle;
  final double leadingSize;
  final String leadingPhotoUrl;
  final bool leadingBadge;
  final Decoration? decoration;
  final List<Widget> actions;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      width: MediaQuery.of(context).size.width,
      height: kBottomNavigationBarHeight,
      decoration: widget.decoration,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Builder(builder: (context) {
            return InkWell(
              onTap: widget.onTapLeading,
              highlightColor: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(99),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                backgroundImage: NetworkImage(
                  widget.leadingPhotoUrl == '' ? defaultUrl : widget.leadingPhotoUrl,
                ),
                radius: widget.leadingSize,
                onBackgroundImageError: (exception, stackTrace) {
                  return;
                },
              ),
            );
          }),
          12.horizontalSpace,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.title,
                  const SizedBox(height: 4),
                  widget.subtitle,
                ],
              ),
            ),
          ),
          Builder(builder: (BuildContext context) {
            return Row(
              children: widget.actions,
            );
          }),
        ],
      ),
    );
  }
}
