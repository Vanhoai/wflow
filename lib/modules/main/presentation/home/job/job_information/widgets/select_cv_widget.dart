import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/loading/loading.dart';
import 'package:wflow/modules/main/domain/cv/cv_entity.dart';
import 'package:wflow/modules/main/domain/cv/cv_usercase.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/select_cv_bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/select_cv_bloc/event.dart';
import 'package:wflow/modules/main/presentation/home/job/job_information/bloc/select_cv_bloc/state.dart';

class SelectCVWidget extends StatefulWidget {
  final num work;
  const SelectCVWidget({required this.work, super.key});

  @override
  State<StatefulWidget> createState() => _SelectCVWidgetState();
}

class _SelectCVWidgetState extends State<SelectCVWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectCVBloc(cvUseCase: instance.get<CVUseCase>())..add(GetMyCVEvent()),
      lazy: true,
      child: BlocBuilder<SelectCVBloc, SelectCVSate>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Visibility(
                visible: !state.isLoading,
                replacement: const Loading(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (state.cvEntities.isEmpty) {
                      return Center(
                        child: Text('Bạn chưa có CV nào', style: Theme.of(context).textTheme.bodyLarge),
                      );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: state.cvEntities.length,
                          itemBuilder: (context, index) {
                            return _cv(context, state.cvEntities[index], state.selectID);
                          },
                        )),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                      border: Border.all(color: Theme.of(context).primaryColor)),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Đóng',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context, state.selectID);
                                      },
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Chọn CV',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                )),
          );
        },
      ),
    );
  }

  Widget _cv(BuildContext context, CVEntity cvEntity, num idSelect) {
    final selected = idSelect == cvEntity.id;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? themeData.primaryColor : AppColors.fade)),
      child: InkWell(
        onTap: () {
          BlocProvider.of<SelectCVBloc>(context).add(OnSelectedCVEVent(id: cvEntity.id));
        },
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
            const SizedBox(width: 5),
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
            Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(9),
              child: Container(
                decoration: BoxDecoration(
                    color: selected ? themeData.primaryColor : Colors.black12,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.fade, width: 1.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
