import 'package:equatable/equatable.dart';

class DetailUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserInfo extends DetailUserEvent {
  final num id;

  GetUserInfo({required this.id});

  @override
  List<Object?> get props => [id];
}
