import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/event.dart';
import 'package:wflow/modules/main/presentation/personal/remove_collaborator/bloc/state.dart';

class RemoveCollaboratorBloc
    extends Bloc<RemoveCollaboratorEvent, RemoveCollaboratorState> {
  RemoveCollaboratorBloc() : super(const RemoveCollaboratorState());
}
