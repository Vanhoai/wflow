import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/routes/keys.dart';

class NavigateFeatWidget extends StatefulWidget {
  const NavigateFeatWidget({super.key});

  @override
  State<NavigateFeatWidget> createState() => _NavigateFeatWidgetState();
}

final List<Map<String, dynamic>> staticMenuSelection = [
  {
    'title': 'Balance',
    'icon': AppConstants.ic_balance,
  },
  {
    'title': 'Reputation',
    'icon': AppConstants.ic_reputation,
  },
  {
    'title': 'Business',
    'icon': AppConstants.ic_business,
  },
  {
    'title': 'More',
    'icon': AppConstants.ic_more,
  }
];

class _NavigateFeatWidgetState extends State<NavigateFeatWidget> {
  void navigateTo(int index) {
    switch (index) {
      default:
        Navigator.of(context).pushNamed(RouteKeys.companyScreen);
    }
  }

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
                            onTap: () => navigateTo(index),
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
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                TextStyle(
                                  color: Theme.of(context).textTheme.labelMedium!.color!.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
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