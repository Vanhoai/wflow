import 'package:flutter/material.dart';

class ChipCustom extends StatelessWidget {
  const ChipCustom({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(title),
      focusNode: FocusNode(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      labelStyle:
          Theme.of(context).textTheme.displayMedium!.merge(TextStyle(color: Theme.of(context).colorScheme.background)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 1,
      labelPadding: const EdgeInsets.all(0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.comfortable,
      avatar: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: Text(title.substring(0, 1),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .merge(TextStyle(color: Theme.of(context).colorScheme.primary)))),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.primary,
      onPressed: onTap,
      pressElevation: 1,
    );
  }
}
