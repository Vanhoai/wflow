import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/state.dart';
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
              BlocProvider(lazy: true, create: (_) => HeaderRoomsBloc())
            ],
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const HeaderRooms(),
                    Expanded(
                        child: Stack(
                      children: [
                        const ListRoom(),
                        BlocBuilder<HeaderRoomsBloc, HeaderRoomState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: context
                                  .read<HeaderRoomsBloc>()
                                  .state
                                  .showSearch,
                              child: Listener(
                                onPointerDown: (PointerDownEvent event) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  if (!context
                                      .read<HeaderRoomsBloc>()
                                      .state
                                      .showSearch) return;
                                  context
                                      .read<HeaderRoomsBloc>()
                                      .add(ShowSearchEvent(show: false));
                                },
                                child: Container(
                                  color: Colors.black12,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ))
                  ],
                )),
          )),
    );
  }
}
