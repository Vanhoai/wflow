part of "bloc.dart";

abstract class AppLoadingState extends Equatable {
  @override
  List<Object> get props => [];
}

class HideLoadingState extends AppLoadingState {}

class ShowLoadingState extends AppLoadingState {}
