import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/utils.dart';

class SharedSearchBar extends StatefulWidget {
  const SharedSearchBar({
    super.key,
    this.decoration,
    this.padding,
    this.margin,
    this.onClear,
    this.onSearch,
    this.placeHolder = 'Search here',
  });

  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String placeHolder;
  final Function()? onClear;
  final Function(String)? onSearch;

  @override
  State<SharedSearchBar> createState() => _SharedSearchBarState();
}

class _SharedSearchBarState extends State<SharedSearchBar> {
  final TextEditingController editingController = TextEditingController();
  final Debounce debounce = Debounce(duration: const Duration(milliseconds: 500));

  void onChange(String value) {
    debounce.call(() {
      widget.onSearch?.call(value);
    });
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      padding: widget.padding,
      margin: widget.margin,
      child: TextFormField(
        controller: editingController,
        onChanged: (value) {
          setState(() {});
          onChange(value);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintText: widget.placeHolder,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              AppConstants.search,
              colorFilter: const ColorFilter.mode(AppColors.textGrey, BlendMode.srcIn),
            ),
          ),
          suffixIcon: Visibility(
            visible: editingController.text.isNotEmpty,
            child: InkWell(
              onTap: () {
                editingController.clear();
                widget.onClear?.call();
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(
                  AppConstants.close,
                  colorFilter: const ColorFilter.mode(AppColors.textGrey, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
