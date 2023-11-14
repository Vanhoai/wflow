part of 'bloc.dart';

abstract class AppLoadingState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppHideLoadingState extends AppLoadingState {}

class AppShowLoadingState extends AppLoadingState {
  final String message;

  AppShowLoadingState({required this.message});
}
