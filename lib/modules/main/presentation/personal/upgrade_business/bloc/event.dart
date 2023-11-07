part of 'bloc.dart';

abstract class UpgradeBusinessEvent {}

class UpgradeBusinessSubmitEvent extends UpgradeBusinessEvent {
  final File logo;
  final String name;
  final String email;
  final String phone;
  final String overview;

  UpgradeBusinessSubmitEvent({
    required this.logo,
    required this.name,
    required this.email,
    required this.phone,
    required this.overview,
  });
}
