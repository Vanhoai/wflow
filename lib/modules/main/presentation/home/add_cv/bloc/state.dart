part of 'bloc.dart';

class AddCVState extends Equatable {
  final bool isLoading;
  const AddCVState({this.isLoading = false});

  AddCVState copyWith({bool? isLoading}) {
    return AddCVState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}

class AddCVSuccessState extends AddCVState {
  const AddCVSuccessState({super.isLoading = false});
  @override
  List<Object?> get props => [];
}

class AddCVFailureState extends AddCVState {
  const AddCVFailureState({super.isLoading = false});
  @override
  List<Object?> get props => [isLoading];
}
