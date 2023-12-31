import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

final List<Map<String, dynamic>> staticMenuSelection = [
  {
    'title': 'Balance',
    'icon': AppConstants.ic_balance,
    'onTap': () {},
  },
  {
    'title': 'Reputation',
    'icon': AppConstants.ic_reputation,
    'onTap': () {},
  },
  {
    'title': 'Business',
    'icon': AppConstants.ic_business,
    'onTap': () {},
  },
  {
    'title': 'More',
    'icon': AppConstants.ic_more,
    'onTap': () {},
  }
];

class NavigateFeatWidget extends StatefulWidget {
  const NavigateFeatWidget({super.key});

  @override
  State<NavigateFeatWidget> createState() => _NavigateFeatWidgetState();
}

class _NavigateFeatWidgetState extends State<NavigateFeatWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      sliver: SliverToBoxAdapter(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 90,
            maxHeight: 100,
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: staticMenuSelection.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: constraints.maxWidth / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.white,
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(12.0),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.black,
                          child: InkWell(
                            onTap: staticMenuSelection[index]['onTap'],
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.transparent,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                staticMenuSelection[index]['icon'],
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          staticMenuSelection[index]['title'],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
