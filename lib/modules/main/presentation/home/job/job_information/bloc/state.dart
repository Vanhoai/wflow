import 'package:equatable/equatable.dart';
import 'package:wflow/modules/main/domain/post/entities/post_entity.dart';

class JobInformationState extends Equatable {
  final bool isLoading;
  const JobInformationState({this.isLoading = false});

  JobInformationState copyWith({bool? isLoading}) {
    return JobInformationState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}

class GetJobInformationSuccessState extends JobInformationState {
  final PostEntity postEntity;
  const GetJobInformationSuccessState({required this.postEntity, required super.isLoading});
  @override
  GetJobInformationSuccessState copyWith({PostEntity? postEntity, bool? isLoading}) {
    return GetJobInformationSuccessState(
        postEntity: postEntity ?? this.postEntity, isLoading: isLoading ?? super.isLoading);
  }

  @override
  List<Object?> get props => [postEntity, isLoading];
}

class GetJobInformationFailureState extends JobInformationState {
  const GetJobInformationFailureState({super.isLoading = false});
}
