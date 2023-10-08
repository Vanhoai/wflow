import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/headerrooms.dart';
import 'package:wflow/modules/main/presentation/message/rooms/listroom/listroom.dart';










class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RoomsScreenState();
  }
}

class _RoomsScreenState extends State<RoomsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                  lazy: true,
                  create: (_) => HeaderRoomsBloc()
              )
            ],
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  children: [
                      HeaderRooms(),
                      Expanded(
                        child: ListRoom()
                    )
                  ],
                )
            ),
          )
      ),
    );
  }

}
