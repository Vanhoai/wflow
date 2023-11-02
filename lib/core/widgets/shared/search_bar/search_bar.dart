import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
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
    debounce.cancel();
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
        onFieldSubmitted: (value) {
          setState(() {});
          widget.onSearch?.call(value);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          hintText: widget.placeHolder,
          hintStyle: themeData.textTheme.bodyMedium?.copyWith(
            color: AppColors.textGrey,
          ),
          labelStyle: themeData.textTheme.bodyMedium?.copyWith(
            color: AppColors.textGrey,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.w),
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
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: SvgPicture.asset(
                  AppConstants.close,
                  colorFilter: const ColorFilter.mode(AppColors.textGrey, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
