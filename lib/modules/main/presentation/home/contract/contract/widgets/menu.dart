import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/enum/enum.dart';
import 'package:wflow/core/routes/arguments_model/arguments_report.dart';
import 'package:wflow/core/routes/keys.dart';

class ContractMenu extends StatelessWidget {
  ContractMenu({super.key, required this.child, this.margin = const EdgeInsets.all(20), required this.contractId});
  final Widget child;
  final EdgeInsets margin;
  final num contractId;
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
            trailingIcon: CupertinoIcons.share,
            child: const Text('Share'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
              if (instance.get<AppBloc>().state.userEntity.isVerify) {
                Navigator.of(context).pushNamed(RouteKeys.reportScreen,
                    arguments: ArgumentsReport(type: ReportEnum.CONTRACT, target: contractId));
              } else {
                Navigator.of(context).pushNamed(RouteKeys.auStepOneScreen);
              }
            },
            isDestructiveAction: true,
            trailingIcon: CupertinoIcons.exclamationmark_circle_fill,
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
