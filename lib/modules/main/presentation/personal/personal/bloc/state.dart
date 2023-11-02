part of 'bloc.dart';

class PersonalState extends Equatable {
  final String message;
  final bool isLoading;
  final UserEntity userEntity;
  final bool isSignOut;

  const PersonalState({
    required this.message,
    required this.isLoading,
    required this.userEntity,
    required this.isSignOut,
  });

  PersonalState copyWith({
    String? message,
    bool? isLoading,
    UserEntity? userEntity,
    bool? isSignOut,
  }) {
    return PersonalState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      userEntity: userEntity ?? this.userEntity,
      isSignOut: isSignOut ?? this.isSignOut,
    );
  }

  @override
  List<Object> get props => [
        message,
        isLoading,
        userEntity,
      ];
}
