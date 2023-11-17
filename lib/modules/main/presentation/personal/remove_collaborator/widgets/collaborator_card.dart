import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';

class CollaboratorCard extends StatefulWidget {
  const CollaboratorCard({
    super.key,
    required this.image,
    required this.name,
    required this.email,
    required this.isCheck,
    required this.onCheck,
    required this.role,
  });

  final String image;
  final String name;
  final String email;
  final bool isCheck;
  final Function(bool?)? onCheck;
  final int role;

  @override
  State<CollaboratorCard> createState() => _CollaboratorCardState();
}

class _CollaboratorCardState extends State<CollaboratorCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.role == 3) {
          widget.onCheck!(!widget.isCheck);
        }
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingScreenDefault,
          vertical: AppSize.paddingMedium * 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
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
                Visibility(
                  visible: widget.role == 3,
                  child: Container(
                    width: ((MediaQuery.sizeOf(context).width) / 100) * 7.14,
                    height: ((MediaQuery.sizeOf(context).height) / 100) * 3.41,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        width: ((MediaQuery.sizeOf(context).width) / 100) * 0.51,
                        style: BorderStyle.solid,
                        color: widget.isCheck ? AppColors.primary : const Color(0XFFD9D9D9),
                      ),
                      borderRadius: BorderRadius.circular(AppSize.borderSmall),
                    ),
                    child: Transform.scale(
                      scale: 1.3,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
