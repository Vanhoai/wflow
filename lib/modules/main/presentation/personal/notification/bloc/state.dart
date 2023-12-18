part of 'bloc.dart';

class NotificationState extends Equatable {
  final List<NotificationEntity> notifications;

  const NotificationState({required this.notifications});

  NotificationState copyWith({List<NotificationEntity>? notifications}) {
    return NotificationState(notifications: notifications ?? this.notifications);
  }

  @override
  List<Object> get props => [notifications];
}
