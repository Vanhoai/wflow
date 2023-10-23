import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/presentation/home/home/bloc/bloc.dart';

class SelectionListWidget extends StatefulWidget {
  const SelectionListWidget({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<SelectionListWidget> createState() => _SelectionListWidgetState();
}

class _SelectionListWidgetState extends State<SelectionListWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (cur, prev) => cur.categories != prev.categories || cur.categorySelected != prev.categorySelected,
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 42,
            ),
            child: ListView.separated(
              controller: widget.scrollController,
              itemCount: state.categories.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final category = state.categories[index].name;
                final selected = category == state.categorySelected;

                return SizedBox(
                  height: 32,
                  child: ChoiceChip.elevated(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    label: Text(category),
                    selected: selected,
                    onSelected: (value) => context.read<HomeBloc>().add(OnSelectCategoryEvent(category)),
                    showCheckmark: false,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                    labelStyle: themeData.textTheme.labelMedium!.copyWith(
                      color: selected ? Colors.white : themeData.colorScheme.onBackground,
                    ),
                    color: selected
                        ? const MaterialStatePropertyAll(AppColors.primary)
                        : MaterialStatePropertyAll(themeData.colorScheme.background),
                    elevation: 2,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
