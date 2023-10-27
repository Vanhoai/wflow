part of 'bloc.dart';

class UpPostState extends Equatable {
  final List<String> tasks;

  const UpPostState({
    required this.tasks,
  });

  UpPostState copyWith({
    List<String>? tasks,
  }) {
    return UpPostState(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [tasks];
}
