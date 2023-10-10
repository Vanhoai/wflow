import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String IMAGE_PHOTO = 'https://i.pinimg.com/564x/b5/19/65/b5196523468e198c8d6f09dd6320855f.jpg';

class Header extends StatefulWidget {
  const Header({
    super.key,
    required this.title,
    required this.subtitle,
    this.decoration,
    this.onTapTitle,
    this.leadingSize = 30,
    this.leadingPhotoUrl = IMAGE_PHOTO,
    this.leadingBadge = false,
    this.onTapLeading,
    this.actions = const [],
  });
  final Text title;
  final VoidCallback? onTapTitle;
  final VoidCallback? onTapLeading;
  final Text subtitle;
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
    final ThemeData themeData = Theme.of(context);

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
            if (widget.leadingSize > 30) {
              return Container();
            }
            return InkWell(
              onTap: widget.onTapLeading,
              highlightColor: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(99),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.leadingPhotoUrl),
                radius: widget.leadingSize,
                onBackgroundImageError: (exception, stackTrace) {
                  return;
                },
                child: Builder(builder: (context) {
                  if (!widget.leadingBadge) {
                    return Container();
                  }
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset('assets/icons/online.svg', width: 20, height: 20),
                  );
                }),
              ),
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: widget.onTapTitle,
                    enableFeedback: false,
                    splashFactory: InkRipple.splashFactory,
                    splashColor: themeData.colorScheme.primary.withOpacity(0.2),
                    customBorder: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        side: BorderSide(color: Colors.transparent)),
                    highlightColor: themeData.colorScheme.primary.withOpacity(0.2),
                    focusNode: FocusNode(canRequestFocus: false),
                    overlayColor: MaterialStateProperty.all<Color>(
                      themeData.colorScheme.primary.withOpacity(0.2),
                    ),
                    child: widget.title,
                  ),
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
