import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/utils/string.util.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class HotJobCard extends StatefulWidget {
  const HotJobCard({
    super.key,
    required this.job,
    required this.constraints,
    required this.pressCard,
    this.onToggleBookmark,
    required this.isBookmarked,
    required this.paymentAvailable,
  });

  final PostEntity job;
  final BoxConstraints constraints;
  final Function(int id) pressCard;
  final void Function()? onToggleBookmark;
  final bool isBookmarked;
  final bool paymentAvailable;

  @override
  State<HotJobCard> createState() => _HotJobCardState();
}

class _HotJobCardState extends State<HotJobCard> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      width: widget.constraints.maxWidth * 0.8,
      height: widget.constraints.maxHeight,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: JobCard(
        time: widget.job.updatedAt!,
        paymentAvailable: widget.paymentAvailable,
        jobId: widget.job.id,
        isHorizontal: true,
        boxDecoration: BoxDecoration(
          color: themeData.colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: themeData.colorScheme.onBackground.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: themeData.colorScheme.onBackground.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        cardPressed: () => widget.pressCard(widget.job.id),
        padding: const EdgeInsets.all(12),
        header: Header(
          leadingPhotoUrl: widget.job.companyLogo,
          title: Text(
            widget.job.position,
            style: themeData.textTheme.displayLarge!.merge(
              TextStyle(
                fontSize: 18,
                color: themeData.colorScheme.onBackground,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          subtitle: Text(
            widget.job.companyName,
            style: themeData.textTheme.displayMedium!.merge(
              TextStyle(
                color: themeData.colorScheme.onBackground.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          onTapLeading: () {},
          leadingSize: 32,
          actions: [
            InkWell(
              onTap: widget.onToggleBookmark,
              child: SvgPicture.asset(
                AppConstants.bookmark,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  widget.isBookmarked
                      ? themeData.colorScheme.primary
                      : themeData.colorScheme.onBackground.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        cost: instance.get<ConvertString>().moneyFormat(value: widget.job.salary),
        duration: widget.job.duration,
        description: TextMore(
          widget.job.content,
          trimLines: 3,
          trimMode: TrimMode.Hidden,
          trimHiddenMaxLines: 3,
          style: themeData.textTheme.displayMedium!.merge(
            TextStyle(
              color: themeData.colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
