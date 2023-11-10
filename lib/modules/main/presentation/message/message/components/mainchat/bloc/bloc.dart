import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/configuration/environment.dart';
import 'package:wflow/core/agent/agent.dart';
import 'package:wflow/core/http/response.http.dart';
import 'package:wflow/modules/main/data/room/model/request_room.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';
import 'package:wflow/modules/main/domain/room/room_usecase.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainChatBloc extends Bloc<MainChatEvent, MainChatState> {
  late final IO.Socket socket;
  num? idRoom;
  final num idMember;
  final RoomUseCase roomUseCase;
  MainChatBloc({required this.idRoom, required this.idMember, required this.roomUseCase})
      : super(const MainChatState(listChat: [])) {
    socket = IO.io(EnvironmentConfiguration.urlSocket, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders': {HttpHeaders.authorizationHeader: instance.get<AppBloc>().state.authEntity.accessToken}
    });
    socket.connect();

    socket.onConnect((_) {
      print('connect');
      Map<String, dynamic> data = {'roomId': idRoom, 'memberId': idMember};
      socket.emit('join-room', data);
    });
    socket.onConnectError((data) {
      print('loi $data');
    });
    socket.on('message', (data) => add(GetMessageEvent(chat: data)));
    socket.on('join-room', (data) => add(JoinRoomEvent(roomID: data)));

    on<SendFilesEvent>(sendFiles);
    on<SendMessageEvent>(sendMessage);
    on<GetMessageEvent>(getChat);
    on<JoinRoomEvent>(joinRoom);
    on<ScrollEvent>(scroll);
    on<GetListMessage>(getListMessage);
    on<GetListMessageMore>(getListMessageMore);
  }

  FutureOr<void> joinRoom(JoinRoomEvent event, Emitter<MainChatState> emit) {
    idRoom ??= num.parse(event.roomID['idRoom']);
    add(GetListMessage());
  }

  FutureOr<void> sendFiles(SendFilesEvent event, Emitter<MainChatState> emit) async {
    String content = '';
    Agent agent = instance.get<Agent>();
    var formData = FormData();
    emit(state.copyWith(file: event.files[0]));
    for (int i = 0; i < event.files.length; i++) {
      formData.files.addAll([MapEntry('files', await MultipartFile.fromFile(event.files[i].path))]);
    }
    final response = await agent.dio.post(
      '/message',
      data: formData,
      onSendProgress: (count, total) {
        final progress = count / total;
        emit(state.copyWith(file: event.files[0], percent: double.tryParse(progress.toStringAsFixed(0))));
      },
    );
    final HttpResponse httpResponse = HttpResponse.fromJson(response.data);
    List<dynamic> list = httpResponse.data;
    for (int i = 0; i < list.length; i++) {
      content += list[i]['url'];
      if (i != list.length - 1) {
        content += '*****';
      }
    }
    emit(state.copyWith(percent: 0));
    add(SendMessageEvent(message: content, type: event.type));
  }

  FutureOr<void> sendMessage(SendMessageEvent event, Emitter<MainChatState> emit) async {
    if (idRoom == null) return;
    Map<String, dynamic> data = {'roomId': idRoom, 'message': event.message, 'type': event.type};
    socket.emit('send-message', data);
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }

  FutureOr<void> getChat(GetMessageEvent event, Emitter<MainChatState> emit) {
    MessagesEntity messagesEntity = MessagesEntity.fromJson(event.chat);
    emit(state.copyWith(listChat: [messagesEntity, ...state.listChat]));
  }

  FutureOr<void> scroll(ScrollEvent event, Emitter<MainChatState> emit) {
    emit(Scroll(
        listChat: state.listChat,
        scroll: !state.scroll,
        meta: state.meta,
        search: state.search,
        file: state.file,
        percent: state.percent));
  }

  FutureOr<void> getListMessage(GetListMessage event, Emitter<MainChatState> emit) async {
    if (idRoom == null) return;
    final messages =
        await roomUseCase.getListMessage(const PaginationModel(page: 1, pageSize: 10, search: ""), idRoom!);

    emit(state.copyWith(listChat: [...messages.data], meta: messages.meta));
  }

  FutureOr<void> getListMessageMore(GetListMessageMore event, Emitter<MainChatState> emit) async {
    if (idRoom == null) return;
    if (state.meta.currentPage >= state.meta.totalPage) {
      return;
    }
    final messages = await roomUseCase.getListMessage(
        PaginationModel(page: state.meta.currentPage + 1 as int, pageSize: 10, search: state.search), idRoom!);
    emit(state.copyWith(listChat: [...state.listChat, ...messages.data], meta: messages.meta));
  }
}
