import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CandidateCvItemWidget extends StatefulWidget {
  const CandidateCvItemWidget({super.key, this.onTap, this.cvName = 'CV.pdf'});

  final VoidCallback? onTap;
  final String cvName;

  @override
  State<CandidateCvItemWidget> createState() => _CandidateCvItemWidgetState();
}

class _CandidateCvItemWidgetState extends State<CandidateCvItemWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: themeData.colorScheme.onBackground.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SvgPicture.asset(
                'assets/icons/cv.svg',
                width: 10,
                height: 10,
              ),
            ),
            const SizedBox(width: 8),
            Builder(
              builder: (context) {
                final String content = widget.cvName;

                return Expanded(
                  child: Text(
                    content,
                    style: themeData.textTheme.displaySmall!.merge(
                      TextStyle(
                        color: themeData.colorScheme.onBackground,
                        fontSize: 10,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
