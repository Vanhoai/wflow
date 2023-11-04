part of 'bloc.dart';

abstract class BalanceEvent {}

class BalanceEventFetch extends BalanceEvent {}

class BalanceTopUpEvent extends BalanceEvent {
  final num amount;
  BalanceTopUpEvent(this.amount);
}
