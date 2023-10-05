import 'package:flutter/material.dart';

class ExploreCardTile extends StatefulWidget {
  const ExploreCardTile({
    super.key,
    this.onExpansionChanged,
    required this.children,
    this.bottomChild,
    this.icon,
    this.initialElevation = 0.0,
    this.initiallyExpanded = false,
    this.initialPadding = const EdgeInsets.symmetric(vertical: 6.0),
    this.finalPadding = const EdgeInsets.symmetric(vertical: 6.0),
    this.duration = const Duration(milliseconds: 200),
    this.elevationCurve = Curves.easeOut,
    this.heightFactorCurve = Curves.easeIn,
    this.turnsCurve = Curves.easeIn,
    this.colorCurve = Curves.easeIn,
    this.paddingCurve = Curves.easeIn,
  });

  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Widget? icon;
  final double initialElevation;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry initialPadding;
  final EdgeInsetsGeometry finalPadding;
  final Duration duration;
  final Curve elevationCurve;
  final Curve heightFactorCurve;
  final Curve turnsCurve;
  final Curve colorCurve;
  final Curve paddingCurve;
  final Widget? bottomChild;

  @override
  State<ExploreCardTile> createState() => _ExploreCardTileState();
}

class _ExploreCardTileState extends State<ExploreCardTile> with SingleTickerProviderStateMixin {
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  late EdgeInsetsTween _edgeInsetsTween;
  late Animatable<double> _heightFactorTween;
  late Animatable<double> _turnsTween;
  late Animatable<double> _paddingTween;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<EdgeInsets> _padding;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _edgeInsetsTween =
        EdgeInsetsTween(begin: widget.initialPadding as EdgeInsets?, end: widget.finalPadding as EdgeInsets?);
    _heightFactorTween = CurveTween(curve: widget.heightFactorCurve);
    _turnsTween = CurveTween(curve: widget.turnsCurve);
    _paddingTween = CurveTween(curve: widget.paddingCurve);

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(_heightFactorTween);
    _iconTurns = _controller.drive(_halfTween.chain(_turnsTween));
    _padding = _controller.drive(_edgeInsetsTween.chain(_paddingTween));
    _isExpanded = PageStorage.of(context).readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setExpansion(bool shouldBeExpanded) {
    if (shouldBeExpanded != _isExpanded) {
      setState(() {
        _isExpanded = shouldBeExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((void value) {
            if (!mounted) return;
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context).writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  void expand() {
    _setExpansion(true);
  }

  void collapse() {
    _setExpansion(false);
  }

  void toggleExpansion() {
    _setExpansion(!_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Padding(
      padding: EdgeInsets.only(bottom: _padding.value.bottom, top: _padding.value.top),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRect(
              child: Align(
                heightFactor: _heightFactor.value,
                alignment: Alignment.topLeft,
                child: child,
              ),
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: IconButton(
                    onPressed: toggleExpansion,
                    icon: RotationTransition(
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                      turns: _iconTurns,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: widget.icon ??
                            Icon(
                              Icons.arrow_back_rounded,
                              size: 16,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    tooltip: _isExpanded ? 'Collapse' : 'Expand',
                  ),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if (widget.bottomChild != null) {
                  return widget.bottomChild!;
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.children,
            ),
    );
  }
}
