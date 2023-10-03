import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/videocall/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/videocall/bloc/state.dart';

class VideoCallOutScreen extends StatefulWidget {
  const VideoCallOutScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VideoCallOutScreenState();
  }
}

class _VideoCallOutScreenState extends State<VideoCallOutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (_) => VideoCallBloc(),
      child: BlocBuilder<VideoCallBloc, VideoCallState>(
        builder: (context, state) {
          return Placeholder();
        },
      ),
    );
  }
}
