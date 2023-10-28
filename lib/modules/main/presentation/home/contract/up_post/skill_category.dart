import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';

class SkillAndCategory extends StatefulWidget {
  const SkillAndCategory({super.key});

  @override
  State<SkillAndCategory> createState() => _SkillAndCategoryState();
}

class _SkillAndCategoryState extends State<SkillAndCategory> {
  void addSkill() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container();
      },
    );
  }

  void addCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<UpPostBloc, UpPostState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Skills',
                  style: themeData.textTheme.displayMedium!.merge(
                    TextStyle(
                      color: themeData.colorScheme.onBackground,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => addSkill(),
                  borderRadius: BorderRadius.circular(4),
                  child: Text(
                    'Add',
                    style: themeData.textTheme.displayMedium!.merge(
                      TextStyle(
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(31, 167, 167, 167),
              ),
              child: ListView.separated(
                itemCount: state.skillSelected.length,
                separatorBuilder: (context, index) => const SizedBox(width: 3),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          state.skillSelected[index].name,
                          style: themeData.textTheme.labelMedium!.merge(
                            const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(4),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: themeData.textTheme.displayMedium!.merge(
                    TextStyle(
                      color: themeData.colorScheme.onBackground,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => addCategory(),
                  borderRadius: BorderRadius.circular(4),
                  child: Text(
                    'Add',
                    style: themeData.textTheme.displayMedium!.merge(
                      TextStyle(
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(31, 167, 167, 167),
              ),
              child: ListView.separated(
                itemCount: state.categorySelected.length,
                separatorBuilder: (context, index) => const SizedBox(width: 3),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          state.categorySelected[index].name,
                          style: themeData.textTheme.labelMedium!.merge(
                            const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(4),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
