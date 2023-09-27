
import 'package:equatable/equatable.dart';

//De tam
class Message extends Equatable {
  final String id;
  final String content;
  final String type;
  String? createAt;
  Message({required this.id, required this.content, required this.type,this.createAt});


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

