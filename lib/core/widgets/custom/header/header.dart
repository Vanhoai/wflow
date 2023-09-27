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
    this.leadingSize = 32,
    this.leadingPhotoUrl = IMAGE_PHOTO,
    this.leadingPadding = const EdgeInsets.all(0),
    this.leadingBadge = false,
    this.onTapLeading,
    this.actions = const [],
    this.actionsSpacing = 0,
    this.decorationAction,
  });
  final Text title;
  final Function()? onTapTitle;
  final Function()? onTapLeading;
  final Text subtitle;
  final double leadingSize;
  final String leadingPhotoUrl;
  final EdgeInsets leadingPadding;
  final bool leadingBadge;
  final Decoration? decoration;
  final List<IconButton> actions;
  final double actionsSpacing;
  final Decoration? decorationAction;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
          // ! LEADING =>>>>>>>>>>>>>>>>>>>
          Padding(
            padding: widget.leadingPadding,
            child: Builder(builder: (context) {
              if (widget.leadingSize > 32) {
                return Container();
              }
              return InkWell(
                onTap: widget.onTapLeading,
                enableFeedback: false,
                highlightColor: Theme.of(context).colorScheme.background,
                focusNode: FocusNode(canRequestFocus: false),
                borderRadius: BorderRadius.circular(widget.leadingSize),
                child: Material(
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.leadingPhotoUrl),
                      radius: widget.leadingSize,
                      onBackgroundImageError: (exception, stackTrace) {
                        return;
                      },
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset('assets/icons/online.svg', width: 20, height: 20)),
                    )),
              );
            }),
          ),
          // ! LEADING =>>>>>>>>>>>>>>>>>>>

          // ! TITLE =>>>>>>>>>>>>>>>>>>>
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
          // ! TITLE =>>>>>>>>>>>>>>>>>>>

          // ! ACTION BUTTON =>>>>>>>>>>>>>>>>>>>
          Builder(builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.alphabetic,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: widget.actions,
            );
          }),
          // ! ACTION BUTTON =>>>>>>>>>>>>>>>>>>>
        ],
      ),
    );
  }
}
