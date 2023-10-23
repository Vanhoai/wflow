import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      AppConstants.search,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(10.0),
                  filled: true,
                  fillColor: themeData.colorScheme.background,
                  disabledBorder: InputBorder.none,
                ),
                clipBehavior: Clip.none,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: themeData.colorScheme.background,
            elevation: 3.0,
            shadowColor: themeData.colorScheme.onBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.transparent,
                ),
                child: SvgPicture.asset(
                  AppConstants.ic_filter,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    themeData.textTheme.displayMedium!.color!.withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
