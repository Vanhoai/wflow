

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
  final bool scroll;
  const MainChatState({required this.listChat, this.scroll = false});


  MainChatState copyWith({
    List<Message>? listChat,
    bool? scroll
  }){
    return MainChatState(
        listChat: listChat ?? this.listChat,
        scroll: scroll ?? this.scroll,
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [listChat];

}

class Scroll extends MainChatState {
  const Scroll({required super.listChat, required super.scroll});

  @override
  // TODO: implement props
  List<Object?> get props => [scroll];
}

