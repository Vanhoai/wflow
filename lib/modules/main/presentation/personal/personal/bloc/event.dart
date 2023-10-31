part of 'bloc.dart';

class PersonalEvent extends Equatable {
  const PersonalEvent();

  @override
  List<Object> get props => [];
}

class SignOutEvent extends PersonalEvent {
  const SignOutEvent();

  @override
  List<Object> get props => [];
}

class GetPersonalInformationEvent extends PersonalEvent {
  final String message;
  final bool isLoading;
  const GetPersonalInformationEvent({
    required this.message,
    required this.isLoading,
  });

  @override
  List<Object> get props => [message, isLoading];
}

class RefreshPersonalInformationEvent extends PersonalEvent {
  final String message;
  final bool isLoading;
  const RefreshPersonalInformationEvent({
    required this.message,
    required this.isLoading,
  });

  @override
  List<Object> get props => [message, isLoading];
}
