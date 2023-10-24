import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHotJob extends StatelessWidget {
  const ShimmerHotJob({
    super.key,
    required this.height,
    required this.width,
    this.scrollDirection = Axis.horizontal,
    this.margin = const EdgeInsets.only(right: 20),
    this.padding = const EdgeInsets.only(left: 20.0),
    this.physics = const BouncingScrollPhysics(),
    required this.decoration,
  });

  final double height;
  final double width;
  final Axis scrollDirection;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: themeData.colorScheme.onBackground.withOpacity(0.1),
      highlightColor: themeData.colorScheme.onBackground.withOpacity(0.05),
      child: ListView.builder(
        physics: physics,
        itemCount: 5,
        padding: padding,
        scrollDirection: scrollDirection,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: height,
            width: width,
            margin: margin,
            padding: const EdgeInsets.all(12),
            decoration: decoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 32,
                    ),
                    const SizedBox(width: 12),
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
