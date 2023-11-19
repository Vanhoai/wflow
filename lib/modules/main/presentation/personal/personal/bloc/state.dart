part of 'bloc.dart';

class PersonalState extends Equatable {
  final bool isLoading;
  final UserEntity userEntity;

  const PersonalState({
    required this.isLoading,
    required this.userEntity,
  });

  PersonalState copyWith({
    bool? isLoading,
    UserEntity? userEntity,
  }) {
    return PersonalState(
      isLoading: isLoading ?? this.isLoading,
      userEntity: userEntity ?? this.userEntity,
    );
  }

  @override
  List<Object> get props => [isLoading, userEntity];
}
