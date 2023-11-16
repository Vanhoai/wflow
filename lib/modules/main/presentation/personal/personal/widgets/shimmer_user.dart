import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUser extends StatelessWidget {
  const ShimmerUser({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
          highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            height: 260,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
          highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            height: 260,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                8.verticalSpace,
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                24.verticalSpace,
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                20.verticalSpace,
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                20.verticalSpace,
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
