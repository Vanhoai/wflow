part of 'bloc.dart';

class BalanceState extends Equatable {
  final bool isLoading;
  final BalanceEntity balanceEntity;
  final List<TrackingEntity> trackingEntities;

  const BalanceState({required this.balanceEntity, required this.isLoading, required this.trackingEntities});

  BalanceState copyWith({
    bool? isLoading,
    BalanceEntity? balanceEntity,
    List<TrackingEntity>? trackingEntities,
  }) {
    return BalanceState(
      isLoading: isLoading ?? this.isLoading,
      balanceEntity: balanceEntity ?? this.balanceEntity,
      trackingEntities: trackingEntities ?? this.trackingEntities,
    );
  }

  @override
  List<Object> get props => [isLoading, balanceEntity, trackingEntities];
}
