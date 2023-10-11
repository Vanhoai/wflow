import 'package:flutter/material.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({super.key, required this.morePressed});

  final VoidCallback morePressed;

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 60),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Trần Văn Hoài',
              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              )),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 15),
            Text(
              'hoaitvps22068@fpt.edu.vn',
              style: themeData.textTheme.displayMedium!.merge(TextStyle(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              )),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it ',
              textAlign: TextAlign.center,
              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              )),
            ),
            const SizedBox(height: 30),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Reputation',
                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '90',
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 22,
                        )),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Worked',
                        style: themeData.textTheme.displayMedium!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '90',
                        style: themeData.textTheme.displayLarge!.merge(TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 22,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: themeData.colorScheme.background,
                      elevation: 3.0,
                      shadowColor: themeData.colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Text(
                              'Security',
                              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: themeData.colorScheme.background,
                      elevation: 3.0,
                      shadowColor: themeData.colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Text(
                              'Edit',
                              style: themeData.textTheme.displayLarge!.merge(const TextStyle(
                                fontSize: 16,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: themeData.colorScheme.background,
                      elevation: 3.0,
                      shadowColor: themeData.colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: widget.morePressed,
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Text(
                              'More',
                              style: themeData.textTheme.displayLarge!.merge(TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
