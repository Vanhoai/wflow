import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const String IMAGE_PHOTO = 'https://i.pinimg.com/564x/b5/19/65/b5196523468e198c8d6f09dd6320855f.jpg';

class Header extends StatefulWidget {
  const Header({
    super.key,
    this.title,
    this.onTapTitle,
    this.subtitle,
    this.leadingSize = 32,
    this.leadingPhotoUrl = IMAGE_PHOTO,
    this.leadingPadding = const EdgeInsets.all(0),
    this.leadingBadge = false,
    this.onTapLeading,
    this.decoration,
    this.actions = const [],
    this.actionsSpacing = 4,
    this.decorationAction,
  });

  final String? title;
  final String? subtitle;
  final Decoration? decorationAction;
  final Decoration? decoration;
  final String leadingPhotoUrl;
  final double leadingSize;
  final bool leadingBadge;
  final Function()? onTapLeading;
  final Function()? onTapTitle;
  final List<IconButton> actions;
  final double actionsSpacing;
  final EdgeInsets leadingPadding;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Widget _buildLeading(BuildContext context, ThemeData themeData) {
    return InkWell(
      onTap: widget.onTapLeading,
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(99),
      enableFeedback: false,
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              if (widget.leadingSize > 32) {
                return Container();
              }
              return CircleAvatar(
                backgroundColor: themeData.colorScheme.onBackground.withOpacity(0.1),
                backgroundImage: NetworkImage(widget.leadingPhotoUrl),
                radius: widget.leadingSize,
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/icons/online.svg',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayLarge!.merge(TextStyle(
      color: themeData.colorScheme.onBackground,
    ));
    return InkWell(
      onTap: widget.onTapTitle,
      enableFeedback: false,
      splashFactory: InkRipple.splashFactory,
      child: Text(widget.title ?? '', style: titleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }

  Widget _buildSubtitle(BuildContext context, ThemeData themeData) {
    final TextStyle titleStyle = themeData.textTheme.displayMedium!.merge(TextStyle(
      color: themeData.colorScheme.onBackground,
    ));
    return Text(
      widget.subtitle ?? '',
      style: titleStyle,
      strutStyle: const StrutStyle(height: 1.3),
      textScaleFactor: 0.8,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildActionContainer(BuildContext context, IconButton icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.actionsSpacing),
      alignment: Alignment.center,
      child: Center(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
          decoration: widget.decorationAction ??
              BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 0.2,
                    blurRadius: 0.2,
                    offset: Offset(0, 0.2),
                  ),
                ],
                shape: BoxShape.circle,
              ),
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      key: widget.key,
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      decoration: widget.decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: widget.leadingPadding,
            child: _buildLeading(context, themeData),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTitle(context, themeData),
                  _buildSubtitle(context, themeData),
                ],
              ),
            ),
          ),
          Builder(builder: (BuildContext context) {
            return Row(
              children: widget.actions.map((e) => _buildActionContainer(context, e)).toList(),
            );
          }),
        ],
      ),
    );
  }
}
