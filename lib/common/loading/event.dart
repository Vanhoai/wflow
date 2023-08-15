part of "bloc.dart";

class AppLoadingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppShowLoadingEvent extends AppLoadingEvent {}

class AppHideLoadingEvent extends AppLoadingEvent {}
