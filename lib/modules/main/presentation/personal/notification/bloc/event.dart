part of 'bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotification extends NotificationEvent {
  final int page;
  final int pageSize;

  const GetNotification({required this.page, required this.pageSize});

  @override
  List<Object> get props => [page, pageSize];
}

class RefreshNotification extends NotificationEvent {
  const RefreshNotification();

  @override
  List<Object> get props => [];
}
