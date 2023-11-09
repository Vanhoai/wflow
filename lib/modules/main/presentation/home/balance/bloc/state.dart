part of 'bloc.dart';

class BalanceState extends Equatable {
  final bool isLoading;
  final BalanceEntity balanceEntity;

  const BalanceState({required this.balanceEntity, required this.isLoading});

  BalanceState copyWith({
    bool? isLoading,
    BalanceEntity? balanceEntity,
  }) {
    return BalanceState(
      isLoading: isLoading ?? this.isLoading,
      balanceEntity: balanceEntity ?? this.balanceEntity,
    );
  }

  @override
  List<Object> get props => [isLoading, balanceEntity];
}
