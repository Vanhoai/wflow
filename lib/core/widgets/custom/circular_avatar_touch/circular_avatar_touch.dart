import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';

// ignore: constant_identifier_names
const String FakeImage = 'https://res.cloudinary.com/dhwzs1m4l/image/upload/v1697453686/notion-avatar_sxmijk.png';

class CircularAvatarTouch extends StatelessWidget {
  const CircularAvatarTouch({
    super.key,
    this.onTap,
    this.imageUrl,
    this.width,
    this.height,
  });

  final String? imageUrl;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(99.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? FakeImage,
              width: width ?? 48.w,
              height: height ?? 48.h,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              errorWidget: (context, url, error) =>
                  const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              filterQuality: FilterQuality.high,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: const Duration(milliseconds: 500),
              fadeOutCurve: Curves.easeOut,
              fadeOutDuration: const Duration(milliseconds: 500),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(99),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(99),
              highlightColor: AppColors.purpleColor.withOpacity(0.1),
            ),
          ),
        )
      ],
    );
  }
}
