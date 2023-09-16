
import 'package:equatable/equatable.dart';


class Message extends Equatable {
  final String id;
  final String content;
  final String type;

  const Message({required this.id, required this.content, required this.type});


  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class MainChatState extends Equatable{
  final List<Message> listChat;

  const MainChatState({required this.listChat});





  @override
  // TODO: implement props
  List<Object?> get props => [listChat];

}

