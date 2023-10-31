import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/job/candidate_list/bloc/event.dart';
import 'package:wflow/configuration/constants.dart';

class SearchCandidateWidget extends StatefulWidget {
  const SearchCandidateWidget({super.key, this.onClear});

  final Function()? onClear;

  @override
  State<SearchCandidateWidget> createState() => _SearchCandidateWidgetState();
}

class _SearchCandidateWidgetState extends State<SearchCandidateWidget> {
  final TextEditingController textEditingController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    textEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void clearInputSearch() {
    textEditingController.clear();
    context.read<CandidateListBloc>().add(GetCandidateAppliedSearchEvent(search: ''));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return TextField(
      controller: textEditingController,
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          context.read<CandidateListBloc>().add(GetCandidateAppliedSearchEvent(search: value));
        });
      },
      decoration: InputDecoration(
        hintText: 'Enter here',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            AppConstants.search,
            fit: BoxFit.cover,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeData.colorScheme.onBackground.withOpacity(0.3),
            width: 1,
          ),
        ),
        filled: true,
        fillColor: themeData.colorScheme.background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeData.colorScheme.onBackground.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeData.colorScheme.onBackground.withOpacity(0.3),
          ),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        suffixIcon: Visibility(
          visible: textEditingController.text.isNotEmpty,
          child: InkWell(
            onTap: clearInputSearch,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                AppConstants.close,
                fit: BoxFit.cover,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
