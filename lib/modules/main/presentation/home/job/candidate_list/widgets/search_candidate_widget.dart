import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchCandidateWidget extends StatefulWidget {
  const SearchCandidateWidget({super.key, this.onClear, this.textEditingController});

  final Function()? onClear;
  final TextEditingController? textEditingController;

  @override
  State<SearchCandidateWidget> createState() => _SearchCandidateWidgetState();
}

class _SearchCandidateWidgetState extends State<SearchCandidateWidget> {
  @override
  void dispose() {
    super.dispose();
    widget.textEditingController?.dispose();
  }

  void clearInputSearch() {
    widget.textEditingController?.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        hintText: 'Enter here',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeData.colorScheme.onBackground.withOpacity(0.3),
              width: 1,
            )),
        filled: true,
        fillColor: themeData.colorScheme.background,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeData.colorScheme.onBackground.withOpacity(0.3),
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        suffixIcon: IconButton(
          onPressed: clearInputSearch,
          icon: SvgPicture.asset(
            'assets/icons/close.svg',
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
        ),
        counterText: '',
      ),
    );
  }
}
