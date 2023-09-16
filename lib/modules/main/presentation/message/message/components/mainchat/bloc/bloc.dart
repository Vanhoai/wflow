


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/message/components/mainchat/bloc/state.dart';

class MainChatBloc extends Bloc<MainChatEvent,MainChatState>{
  MainChatBloc() : super(initState());



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
}