import 'package:flutter/material.dart';

class LazyLoadIndexedStack extends StatefulWidget {
  LazyLoadIndexedStack({
    Key? key,
    Widget? unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : super(key: key) {
    this.unloadWidget = unloadWidget ?? Container();
  }

  /// Widget to be built when not loaded. Default widget is [Container].
  late final Widget unloadWidget;

  /// Same as alignment attribute of original IndexedStack.
  final AlignmentGeometry alignment;

  /// Same as sizing attribute of original IndexedStack.
  final StackFit sizing;

  /// Same as textDirection attribute of original IndexedStack.
  final TextDirection? textDirection;

  /// The index of the child to show.
  final int index;

  /// The widgets below this widget in the tree.
  ///
  /// A child widget will not be built until the index associated with it is specified.
  /// When the index associated with the widget is specified again, the built widget is returned.
  final List<Widget> children;

  @override
  State<LazyLoadIndexedStack> createState() => _LazyLoadIndexedStackState();
}

class _LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  late List<Widget> children;
  final stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    children = _initialChildren();
  }

  @override
  void didUpdateWidget(final LazyLoadIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.children.length != oldWidget.children.length) {
      children = _initialChildren();
    }

    children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      key: stackKey,
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: children,
    );
  }

  List<Widget> _initialChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;
      return index == widget.index ? childWidget : widget.unloadWidget;
    }).toList();
  }
}
