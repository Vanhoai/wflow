part of 'bloc.dart';

abstract class AppLoadingEvent {}

class AppShowLoadingEvent extends AppLoadingEvent {
  final String message;

  AppShowLoadingEvent({this.message = 'Đang tải'});
}

class AppHideLoadingEvent extends AppLoadingEvent {}
