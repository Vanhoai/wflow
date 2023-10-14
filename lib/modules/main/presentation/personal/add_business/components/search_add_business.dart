import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';

class SearchAddBusiness extends StatefulWidget {
  const SearchAddBusiness({
    super.key,
    required this.controller,
    required this.isHiddenSuffixIcon,
    required this.onChangedSearch,
    required this.onClearSearch,
  });

  final TextEditingController controller;
  final bool isHiddenSuffixIcon;
  final Function onChangedSearch;
  final Function onClearSearch;

  @override
  State<SearchAddBusiness> createState() => _SearchAddBusinessState();
}

class _SearchAddBusinessState extends State<SearchAddBusiness> {
  @override
  Widget build(BuildContext context) {
    return _buildSearchContainer();
  }

  Widget _buildSearchContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: AppSize.paddingScreenDefault,
        right: AppSize.paddingScreenDefault,
        top: AppSize.paddingMedium * 2,
        bottom: AppSize.paddingMedium * 2,
      ),
      child: _buildSearch(),
    );
  }

  Widget _buildSearch() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextField(
        controller: widget.controller,
        onChanged: (value) => widget.onChangedSearch(value),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppColors.textGrey,
          ),
          prefixIcon: _buildPrefixIcon(),
          suffixIcon: _buildSuffixIcon(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.borderMedium),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.borderMedium),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: SvgPicture.asset(
        height: 20,
        width: 20,
        AppConstants.ic_search,
        color: AppColors.borderColor,
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: widget.isHiddenSuffixIcon
          ? const SizedBox(
              width: 0,
              height: 0,
            )
          : InkWell(
              onTap: () => widget.onClearSearch(),
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      999,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
