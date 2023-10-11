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
  String searchContent = '';

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
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: TextField(
          controller: controller,
          onChanged: (value) => setState(() {
            searchContent = controller.text;
          }),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.textGrey,
            ),
            prefixIcon: const Icon(
              Icons.search_outlined,
              size: 32,
              color: Color(0XFF828282),
            ),
            suffixIcon: Align(
              widthFactor: 1,
              heightFactor: 1,
              child: searchContent.isEmpty
                  ? const SizedBox(
                      width: 0,
                      height: 0,
                    )
                  : InkWell(
                      onTap: () => setState(
                        () {
                          searchContent = '';
                          controller.clear();
                        },
                      ),
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
            ),
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
      ),
    );
  }
}
