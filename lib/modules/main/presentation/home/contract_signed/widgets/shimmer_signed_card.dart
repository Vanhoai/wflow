import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSignedCard extends StatelessWidget {
  const ShimmerSignedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
      highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => 16.verticalSpace,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: themeData.colorScheme.onBackground.withOpacity(0.8),
                width: 2,
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(48.r),
                      child: Container(
                        height: 48.w,
                        width: 48.w,
                        color: Colors.white,
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                  ),
                ),
                6.verticalSpace,
                Container(
                  height: 16.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
