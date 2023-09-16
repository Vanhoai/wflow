


import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


const String  EM_Devi = 'http://10.0.2.2:4000/';
const String Real_Devi = 'http://192.168.1.202:4000/';
class MainChatBloc extends Bloc<MainChatEvent,MainChatState>{
  late final IO.Socket socket ;

  MainChatBloc() : super(initState()){
    socket = IO.io(Real_Devi, <String, dynamic>{
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
  }



  static MainChatState initState()
  {

    List<Message> chat = [
      const Message(id: "1", content: "Hello", type: "text"),
      const Message(id: "2", content: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3", type: "record"),
      const Message(id: "1", content: "https://vapa.vn/wp-content/uploads/2022/12/anh-3d-thien-nhien-003.jpg", type: "image"),
      const Message(id: "2", content: "Hello 2", type: "text"),
    ];
    return MainChatState(listChat: chat);
  }

  FutureOr<void> sendFiles(SendFilesEvent event, Emitter<MainChatState> emit) async {
    final bytes = await event.files.readAsBytes();
    Map<String, dynamic> data = {
      'id' : event.id,
      'content' : bytes,
      'type' : event.type
    };
    socket.emit("CHAT",bytes);
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
    print(event.chat);
    Message message = Message(
      id: event.chat["id"],
      content: event.chat["content"],
      type: event.chat["type"]
    );
    state.listChat.add(message);
    emit(MainChatState(listChat: state.listChat));
  }
}