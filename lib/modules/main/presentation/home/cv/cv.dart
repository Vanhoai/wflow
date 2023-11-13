import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/cv/bloc/state.dart';

class CVScreen extends StatefulWidget {
  const CVScreen({super.key});

  @override
  State<CVScreen> createState() => _CVScreenState();
}

class _CVScreenState extends State<CVScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CVBloc(cvUseCase: instance.get<CVUseCase>())..add(GetMyCVEvent()),
      child: BlocBuilder<CVBloc, CVSate>(
        builder: (context, state) {
          return CommonScaffold(
            hideKeyboardWhenTouchOutside: true,
            appBar: AppHeader(text: 'My CV', actions: [
              Builder(
                builder: (context) {
                  if (state.selectCvEntities.isEmpty) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () => Navigator.of(context).pushNamed(RouteKeys.addCVScreen),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Text(
                          'Add',
                          style: themeData.textTheme.displayMedium!
                              .copyWith(color: AppColors.primary, fontWeight: FontWeight.normal),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {},
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text(
                        'Remove',
                        style: themeData.textTheme.displayMedium!
                            .copyWith(color: AppColors.primary, fontWeight: FontWeight.normal),
                      ),
                    ),
                  );
                },
              )
            ]),
            body: RefreshIndicator(
              onRefresh: () async {},
              child: Visibility(
                visible: !state.isLoading,
                replacement: const Loading(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (state.cvEntities.isEmpty) {
                      return Center(
                        child: Text(
                          'No candidates have applied yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }
                    return ListView.builder(
                        padding: const EdgeInsets.all(20),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.cvEntities.length,
                        itemBuilder: (context, index) {
                          return _cv(context, state.cvEntities[index], state);
                        });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _cv(BuildContext context, CVEntity cvEntity, CVSate state) {
    bool isCheck = false;
    isCheck = state.selectCvEntities.indexWhere((element) => element.id == cvEntity.id) != -1 ? true : false;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.fade)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/cv.svg',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                cvEntity.title,
                style: themeData.textTheme.displaySmall!.merge(
                  TextStyle(
                    color: themeData.colorScheme.onBackground,
                    fontSize: 14,
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  final String content = cvEntity.url;
                  if (content.length > 25) {
                    return Text(
                      '${content.substring(0, 19)}...pdf',
                      style: themeData.textTheme.displaySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  } else {
                    return Text(
                      content,
                      style: themeData.textTheme.displaySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                },
              ),
            ]),
          ),
          _buildCheckbox(context, cvEntity.id, isCheck),
        ],
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context, num id, bool isCheck) {
    return Container(
      width: ((MediaQuery.sizeOf(context).width) / 100) * 7.14,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 3.41,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: ((MediaQuery.sizeOf(context).width) / 100) * 0.51,
          style: BorderStyle.solid,
          color: isCheck ? AppColors.primary : const Color(0XFFD9D9D9),
        ),
        borderRadius: BorderRadius.circular(AppSize.borderSmall),
      ),
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: isCheck,
          onChanged: (value) {
            BlocProvider.of<CVBloc>(context).add(OnSelectedCVEVent(id: id, state: isCheck));
          },
          checkColor: AppColors.primary,
          side: const BorderSide(
            color: Colors.transparent,
          ),
          fillColor: const MaterialStatePropertyAll(Colors.white),
        ),
      ),
    );
  }
}
