import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum TrimMode { Length, Lines, None }

/// Trim mode:
///  + Length - Trim the text to a specific length. Default is 240 characters. (trimLength)
///  + Lines - Trim the text to a specific number of lines. Default is 2 lines. (trimLines)
///  + None - Don't trim, show all the text. (maxLines)
class TextMore extends StatefulWidget {
  const TextMore({
    super.key,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.Length,
    this.moreStyle,
    this.lessStyle,
    this.preDataText,
    this.postDataText,
    this.preDataTextStyle,
    this.postDataTextStyle,
    this.callback,
    this.onLinkPressed,
    this.linkTextStyle,
    this.delimiter = '$_kEllipsis ',
    this.data = '',
    this.trimExpandedText = '...Show more',
    this.trimCollapsedText = ' show less',
    this.colorClickableText,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.delimiterStyle,
    this.maxLines,
  });

  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle? moreStyle;
  final TextStyle? lessStyle;
  final String? preDataText;
  final String? postDataText;
  final TextStyle? preDataTextStyle;
  final TextStyle? postDataTextStyle;
  final Function(bool val)? callback;
  final ValueChanged<String>? onLinkPressed;
  final TextStyle? linkTextStyle;
  final String delimiter;
  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color? colorClickableText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final double? textScaleFactor;
  final TextStyle? delimiterStyle;
  final int? maxLines;

  @override
  State<TextMore> createState() => _TextMoreState();
}

const String _kEllipsis = '\u2026';
const String _kLineSeparator = '\u2028';

class _TextMoreState extends State<TextMore> {
  bool _isExpanded = true;

  void _onTapLink() {
    setState(() {
      _isExpanded = !_isExpanded;
      widget.callback?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }
    final textAlign = widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor = widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale = widget.locale ?? Localizations.maybeLocaleOf(context);
    final colorClickableText = widget.colorClickableText ?? Theme.of(context).colorScheme.secondary;
    final defaultLessStyle = widget.lessStyle ?? effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultMoreStyle = widget.moreStyle ?? effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultDelimiterStyle = widget.delimiterStyle ?? effectiveTextStyle;
    TextSpan link = TextSpan(
      text: _isExpanded ? widget.trimExpandedText : widget.trimCollapsedText,
      style: _isExpanded ? defaultMoreStyle : defaultLessStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: _isExpanded
          ? widget.trimCollapsedText.isNotEmpty
              ? widget.delimiter
              : ''
          : '',
      style: defaultDelimiterStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final maxWidth = constraints.maxWidth;
        TextSpan? preTextSpan;
        TextSpan? postTextSpan;

        // if preDataText is not null then add it to preTextSpan
        if (widget.preDataText != null) {
          preTextSpan = TextSpan(
            text: '${widget.preDataText!} ',
            style: widget.preDataTextStyle ?? effectiveTextStyle,
          );
        }

        // if postDataText is not null then add it to postTextSpan
        if (widget.postDataText != null) {
          postTextSpan = TextSpan(
            text: ' ${widget.postDataText!}',
            style: widget.postDataTextStyle ?? effectiveTextStyle,
          );
        }

        final text = TextSpan(
          children: [
            if (preTextSpan != null) preTextSpan,
            TextSpan(
              text: widget.data,
              style: effectiveTextStyle,
            ),
            if (postTextSpan != null) postTextSpan,
          ],
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
          textWidthBasis: defaultTextStyle.textWidthBasis,
          textHeightBehavior: defaultTextStyle.textHeightBehavior,
          strutStyle: StrutStyle.fromTextStyle(effectiveTextStyle!),
        );

        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(Offset(
            textDirection == TextDirection.rtl ? readMoreSize : textSize.width - readMoreSize,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        TextSpan textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = _buildData(
                data: _isExpanded ? widget.data.substring(0, widget.trimLength) : widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
            break;
          case TrimMode.Lines:
            if (textPainter.didExceedMaxLines) {
              textSpan = _buildData(
                data: _isExpanded
                    ? widget.data.substring(0, endIndex) + (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
            break;
          case TrimMode.None:
            if (widget.maxLines != null && textPainter.didExceedMaxLines) {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: effectiveTextStyle?.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
          default:
            throw Exception('TrimMode type: ${widget.trimMode} is not supported');
        }

        return Text.rich(
          TextSpan(children: [
            if (preTextSpan != null) preTextSpan,
            textSpan,
            if (postTextSpan != null) postTextSpan,
          ]),
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          textScaleFactor: textScaleFactor,
          overflow: widget.trimMode == TrimMode.None ? TextOverflow.ellipsis : overflow,
          locale: locale,
          maxLines: widget.maxLines,
        );
      },
    );
    return result;
  }

  TextSpan _buildData({
    required String data,
    TextStyle? textStyle,
    TextStyle? linkTextStyle,
    ValueChanged<String>? onPressed,
    required List<TextSpan> children,
  }) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    List<TextSpan> contents = [];
    while (exp.hasMatch(data)) {
      final match = exp.firstMatch(data);
      final firstTextPart = data.substring(0, match!.start);
      // get the link text in the data
      final linkTextPart = data.substring(match.start, match.end);
      contents.add(TextSpan(text: firstTextPart));
      contents.add(TextSpan(
          text: linkTextPart,
          style: linkTextStyle,
          recognizer: TapGestureRecognizer()..onTap = () => onPressed?.call(linkTextPart.trim())));
      data = data.substring(match.end, data.length);
    }
    contents.add(TextSpan(text: data));
    return TextSpan(children: contents..addAll(children), style: textStyle);
  }
}
