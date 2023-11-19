part of 'bloc.dart';

abstract class BalanceEvent {}

class BalanceEventFetch extends BalanceEvent {
  final String id;

  BalanceEventFetch({required this.id});
}

class BalanceTopUpEvent extends BalanceEvent {
  final num amount;
  BalanceTopUpEvent(this.amount);
}

class TrackingEventFetch extends BalanceEvent {
  final String id;
  TrackingEventFetch({required this.id});
}
