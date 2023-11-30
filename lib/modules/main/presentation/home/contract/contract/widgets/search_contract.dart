import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/contract/contract/bloc/event.dart';

class SearchContract extends StatefulWidget {
  const SearchContract({
    super.key,
  });

  @override
  State<SearchContract> createState() => _SearchContractState();
}

class _SearchContractState extends State<SearchContract> {
  late TextEditingController _controller;
  late bool _isHiddenSuffixIcon;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _isHiddenSuffixIcon = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void clearInputSearch() {
    _controller.clear();
    setState(() {
      _isHiddenSuffixIcon = true;
    });
    context.read<ContractListBloc>().add(GetListContractSearchEvent(search: ''));
  }

  void _onChanged(String value) {
    setState(() {
      _isHiddenSuffixIcon = value.isEmpty;
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ContractListBloc>().add(GetListContractSearchEvent(search: value));
    });
  }

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
        controller: _controller,
        onChanged: _onChanged,
        decoration: InputDecoration(
          hintText: instance.get<AppLocalization>().translate('search') ?? 'Search',
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
      child: _isHiddenSuffixIcon
          ? const SizedBox(
              width: 0,
              height: 0,
            )
          : InkWell(
              onTap: clearInputSearch,
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
