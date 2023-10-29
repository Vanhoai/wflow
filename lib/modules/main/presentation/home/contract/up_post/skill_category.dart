import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/presentation/home/contract/up_post/bloc/bloc.dart';

class SkillAndCategory extends StatefulWidget {
  const SkillAndCategory({super.key});

  @override
  State<SkillAndCategory> createState() => _SkillAndCategoryState();
}

class _SkillAndCategoryState extends State<SkillAndCategory> {
  late final TextfieldTagsController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  onTap: () {},
                  borderRadius: BorderRadius.circular(4),
                  child: Text(
                    'Add Skills',
                    style: themeData.textTheme.displayMedium!.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Autocomplete(
              optionsViewBuilder: (context, onSelected, options) {
                return Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      elevation: 4.0,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final dynamic option = options.elementAt(index);
                            return TextButton(
                              onPressed: () {
                                onSelected(option);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text(
                                    '# $option',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.primary.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return state.skills.map((e) => e.name).where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selectedTag) {
                _controller.addTag = selectedTag;
              },
              fieldViewBuilder: (context, textEditingController, tfn, onFieldSubmitted) {
                return TextFieldTags(
                  textEditingController: textEditingController,
                  focusNode: tfn,
                  textfieldTagsController: _controller,
                  initialTags: const [],
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (!state.skills.map((e) => e.name).contains(tag)) {
                      return "Skill doesn't exist";
                    }

                    return null;
                  },
                  inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
                    return (context, scrollController, tags, onTagDelete) {
                      return TextField(
                        controller: tec,
                        focusNode: fn,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          fillColor: Colors.grey[100],
                          filled: true,
                          hintText: _controller.hasTags ? '' : 'Enter skills required',
                          errorText: error,
                          errorStyle: const TextStyle(fontSize: 12.0),
                          prefixIconConstraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                          prefixIcon: tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: scrollController,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tags.map((String tag) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '# $tag',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            onTap: () {},
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: onChanged,
                        onSubmitted: onSubmitted,
                      );
                    };
                  },
                );
              },
            )
          ],
        );
      },
    );
  }
}
