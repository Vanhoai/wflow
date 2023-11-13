part of 'bloc.dart';

class AddCVEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddMyCVEvent extends AddCVEvent {
  final RequestAddCV requestAddCV;

  AddMyCVEvent({required this.requestAddCV});
  @override
  List<Object?> get props => [requestAddCV];
}
