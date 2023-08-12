import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;
  final dynamic data;

  const Failure({this.message = "", this.statusCode = 200, this.data});

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = "", int statusCode = 200, dynamic data})
      : super(message: message, statusCode: statusCode, data: data);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = "", int statusCode = 200, dynamic data})
      : super(message: message, statusCode: statusCode, data: data);
}
