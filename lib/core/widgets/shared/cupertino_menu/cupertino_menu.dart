import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContextMenu extends StatelessWidget {
  ContextMenu({super.key, required this.child, this.margin = const EdgeInsets.all(20)});
  final Widget child;
  final EdgeInsets margin;
  final DecorationTween _tween = DecorationTween(
    begin: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    ),
    end: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
  Animation<Decoration> _boxDecorationAnimation(Animation<double> animation) {
    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.0,
          CupertinoContextMenu.animationOpensAt,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CupertinoContextMenu.builder(
        actions: <Widget>[
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
            child: const Text('Copy'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            trailingIcon: CupertinoIcons.share,
            child: const Text('Share'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            trailingIcon: CupertinoIcons.heart,
            child: const Text('Favorite'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            trailingIcon: CupertinoIcons.delete,
            child: const Text('Report'),
          ),
        ],
        builder: (BuildContext context, Animation<double> animation) {
          final Animation<Decoration> boxDecorationAnimation = _boxDecorationAnimation(animation);
          return Material(
            color: Colors.transparent,
            child: Container(
              decoration: animation.value < CupertinoContextMenu.animationOpensAt ? boxDecorationAnimation.value : null,
              margin: animation.value >= 0.98
                  ? (margin.left != 0 ? const EdgeInsets.only(top: 20) : const EdgeInsets.all(20))
                  : const EdgeInsets.all(0),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
