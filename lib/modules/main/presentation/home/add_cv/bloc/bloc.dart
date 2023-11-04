import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'event.dart';
part 'state.dart';

class AddCVBloc extends Bloc<AddCVEvent, AddCVState> {
  AddCVBloc() : super(AddCVState());
}
