
import 'package:equatable/equatable.dart';

//De tam
class Message {
  final String id;
  final String content;
  final String type;
  String? createAt;
  Message({required this.id, required this.content, required this.type,this.createAt});
}

class MainChatState extends Equatable{
  final List<Message> listChat;

  const MainChatState({required this.listChat});


  MainChatState copyWith({
    List<Message>? listChat
  }){
    return MainChatState(listChat: listChat ?? this.listChat);
  }


  @override
  // TODO: implement props
  List<Object?> get props => [listChat];

}



