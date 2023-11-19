part of 'bloc.dart';

abstract class PersonalEvent {}

class SignOutEvent extends PersonalEvent {}

class GetPersonalInformationEvent extends PersonalEvent {}

class RefreshPersonalInformationEvent extends PersonalEvent {}
