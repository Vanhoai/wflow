import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';

class AddBusinessCard extends StatefulWidget {
  const AddBusinessCard({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.isCheck,
    required this.onCheck,
  });

  final String image;
  final String name;
  final String email;
  final bool isCheck;
  final Function(bool?)? onCheck;

  @override
  State<AddBusinessCard> createState() => _AddBusinessCardState();
}

class _AddBusinessCardState extends State<AddBusinessCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onCheck!(!widget.isCheck),
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingScreenDefault,
          vertical: AppSize.paddingMedium * 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.w,
              height: 50.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.trim(),
                    style: textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.email.trim(),
                    style: textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: widget.isCheck ? AppColors.primary : const Color(0XFFD9D9D9),
                ),
                borderRadius: BorderRadius.circular(AppSize.borderSmall),
              ),
              child: Transform.scale(
                scale: 1,
                child: Checkbox(
                  value: widget.isCheck,
                  onChanged: widget.onCheck,
                  checkColor: AppColors.primary,
                  side: const BorderSide(
                    color: Colors.transparent,
                  ),
                  fillColor: const MaterialStatePropertyAll(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
