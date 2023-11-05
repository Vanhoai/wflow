import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/chat_business/bloc/state.dart';

class ChatBusinessBloc extends Bloc<ChatBusinessEvent, ChatBusinessState> {
  ChatBusinessBloc() : super(const ChatBusinessState());
}
