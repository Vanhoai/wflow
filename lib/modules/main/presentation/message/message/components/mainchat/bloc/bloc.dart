


import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


const String  EM_Devi = 'https://wflow.space';
const String Real_Devi = 'http://192.168.1.202:4000/';
class MainChatBloc extends Bloc<MainChatEvent,MainChatState>{
  late final IO.Socket socket ;
  MainChatBloc() : super(initState()){
    socket = IO.io(EM_Devi, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
    });
    socket.onConnectError((data){
      print('loi ${data}');
    });
    socket.on('CHAT', (data) => add(GetMessageEvent(chat: data)));
    on<SendFilesEvent>(sendFiles);
    on<SendMessageEvent>(sendMessage);
    on<GetMessageEvent>(getChat);
    on<SendRecordEvent>(sendRecord);
    on<ScrollEvent>(scroll);
  }



  static MainChatState initState()
  {

    List<Message> chat = [
      Message(id: "1", content: "Dear anh chị HR \n Em là sinh viên mới tốt nghiệp đang tìm kiếm cơ hội làm việc", type: "text", createAt: DateTime.now().toString()),
      Message(id: "2", content: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3", type: "record",createAt: DateTime.now().toString()),
      Message(id: "2", content: "Hello, cau the nao roi dạo này còn đập đá chơi đá gà không?", type: "text",createAt: DateTime.now().toString()),
      Message(id: "1", content: "Dear anh chị HR \n Em là sinh viên mới tốt nghiệp đang tìm kiếm cơ hội làm việc", type: "text", createAt: DateTime.now().toString()),
      Message(id: "1", content: "Dear anh chị HR \n Em là sinh viên mới tốt nghiệp đang tìm kiếm cơ hội làm việc", type: "text", createAt: DateTime.now().toString()),
      Message(id: "1", content: "Dear anh chị HR \n Em là sinh viên mới tốt nghiệp đang tìm kiếm cơ hội làm việc", type: "text", createAt: DateTime.now().toString()),

    ];
    return MainChatState(listChat: chat );
  }

  FutureOr<void> sendFiles(SendFilesEvent event, Emitter<MainChatState> emit) async {
    String content = "";
    for (int i = 0; i < event.files.length; i ++) {
      content += event.files[i].path;
      if(i != event.files.length-1)
      {
        content +='*****';
      }
    }
    Message message = Message(id: '1', content: content, type: 'multipleimage',createAt: DateTime.now().toString());
    final newState = state.copyWith(listChat: List.of(state.listChat)..add(message));
    emit(newState);
  }

  FutureOr<void> sendMessage(SendMessageEvent event, Emitter<MainChatState> emit) {
    Map<String, dynamic> data = {
      'id' : event.message.id,
      'content' : event.message.content,
      'type' : event.message.type
    };
    socket.emit("CHAT",data);
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }


  FutureOr<void> getChat(GetMessageEvent event, Emitter<MainChatState> emit) {
    Message message = Message(
      id: event.chat["id"],
      content: event.chat["content"],
      type: event.chat["type"],
      createAt: event.chat["createAt"].toString()
    );
    final newState = state.copyWith(listChat: List.of(state.listChat)..add(message));
    emit(newState);
  }

  FutureOr<void> sendRecord(SendRecordEvent event, Emitter<MainChatState> emit) {
    Message message = Message(id: '1', content: event.file.path, type: 'record',createAt: DateTime.now().toString());
    final newState = state.copyWith(listChat: List.of(state.listChat)..add(message));

    emit(newState);
  }




  FutureOr<void> scroll(ScrollEvent event, Emitter<MainChatState> emit) {
    emit(Scroll(listChat: state.listChat, scroll: !state.scroll));
  }
}