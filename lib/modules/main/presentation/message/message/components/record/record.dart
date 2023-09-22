


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
        return Offstage(
          offstage: !state.isShow,
          child: Container(
            alignment: Alignment.center,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
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
                      height: 20,
                      width: 20,
                      colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
                Text(
                  state.timeRecord,
                  style: TextTitle(
                    size: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ]
            ),
          ),
        );
      },
    );
  }

}