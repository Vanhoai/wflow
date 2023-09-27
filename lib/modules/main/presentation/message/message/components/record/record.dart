


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/configuration.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/record/bloc/state.dart';

class Record extends StatefulWidget{
  const Record({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecordState();
  }

}

class _RecordState extends State<Record>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<RecordBloc, RecordState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          height: 250,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: state.file != null,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, right: 5, left: 5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              context.read<RecordBloc>().add(HandleRemoveRecordEvent());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                AppConstants.trash,
                                height: 30,
                                width: 30,
                                colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                              ),
                            ),
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (!state.isRecord) {
                          context.read<RecordBloc>().add(HandleStartRecordEvent());
                        } else {
                          context.read<RecordBloc>().add(HandleStopRecordEvent());
                        }
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: state.isRecord ? Colors.red : AppColors.primary),
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppConstants.mic,
                          height: 40,
                          width: 40,
                          colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.file != null,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, right: 5, left: 5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                AppConstants.send,
                                height: 30,
                                width: 30,

                              ),
                            ),
                          )
                      ),
                    ),
                  ]
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    state.timeRecord,
                    style: TextTitle(
                        size: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ]
          ),
        );
      },
    );
  }

}