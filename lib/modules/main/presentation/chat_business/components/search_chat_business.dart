import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';

class SearchChatBusiness extends StatefulWidget {
  const SearchChatBusiness({super.key});

  @override
  State<SearchChatBusiness> createState() => _SearchChatBusinessState();
}

class _SearchChatBusinessState extends State<SearchChatBusiness> {
  TextEditingController controller = TextEditingController();
  bool isHiddenSuffixIcon = true;

  void onChangedSearch(String value) => setState(() {
        isHiddenSuffixIcon = value.isEmpty;
      });

  void onClearSearch() => setState(() {
        isHiddenSuffixIcon = true;
        controller.clear();
      });

  @override
  Widget build(BuildContext context) {
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
        controller: controller,
        onChanged: (value) => onChangedSearch(value),
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
    return const Icon(
      Icons.search_outlined,
      size: 32,
      color: Color(0XFF828282),
    );
  }

  Widget _buildSuffixIcon() {
    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: isHiddenSuffixIcon
          ? const SizedBox(
              width: 0,
              height: 0,
            )
          : InkWell(
              onTap: () => onClearSearch(),
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
