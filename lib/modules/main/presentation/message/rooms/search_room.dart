import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/room/room_usecase.dart';
import 'package:wflow/modules/main/presentation/message/rooms/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/rooms/bloc/state.dart';
import 'package:wflow/modules/main/presentation/message/rooms/listroom/listroom.dart';

class SearchRoomsScreen extends StatefulWidget {
  const SearchRoomsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchRoomsScreenState();
  }
}

class _SearchRoomsScreenState extends State<SearchRoomsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomBloc(roomUseCase: instance.get<RoomUseCase>())..add(GetListRoomEvent()),
      child: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          return CommonScaffold(
            isSafe: true,
            hideKeyboardWhenTouchOutside: true,
            appBar: AppHeader(
              text: Text(
                'Search',
                style: themeData.textTheme.displayMedium,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<RoomBloc>().add(GetListRoomEvent());
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: SharedSearchBar(
                      placeHolder: 'Search',
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.background,
                      ),
                      onClear: () {
                        context.read<RoomBloc>().add(GetListRoomSearchEvent(search: ''));
                      },
                      onSearch: (value) {
                        context.read<RoomBloc>().add(GetListRoomSearchEvent(search: value));
                      },
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Builder(
                          builder: (context) {
                            if (state is GetListRoomSuccess) {
                              if (state.roomEntities.isEmpty) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      context.read<RoomBloc>().add(GetListRoomEvent());
                                    },
                                    child: Text(
                                      'You do not have message \n Tap to reload',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                );
                              }
                              return ListRoom(listRoom: state.roomEntities);
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Positioned(
                          child: Visibility(
                            visible: state.isLoading,
                            child: const LoadingWithWhite(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}