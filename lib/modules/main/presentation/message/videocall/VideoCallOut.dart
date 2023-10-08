import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';


import 'bloc/bloc.dart';
import 'bloc/event.dart';

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
        create: (_) =>
            instance.get<VideoCallBloc>(),
        child: BlocBuilder(
            bloc: instance.get<VideoCallBloc>()..add(const VideoCallConnectEvent()),
            builder: (BuildContext context, state) => const Placeholder()));
  }
}
