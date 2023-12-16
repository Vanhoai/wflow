part of 'bloc.dart';

class MyCompanyEvent extends Equatable {
  const MyCompanyEvent();

  @override
  List<Object> get props => [];
}

class GetMyCompanyEvent extends MyCompanyEvent {
  final bool isLoading;
  final String message;
  final String id;
  const GetMyCompanyEvent({required this.isLoading, required this.message, required this.id});

  @override
  List<Object> get props => [isLoading, message];
}

class GetMyMemberCompanyEvent extends MyCompanyEvent {
  final bool isLoading;
  final String message;
  final int page;
  final int pageSize;
  const GetMyMemberCompanyEvent({
    required this.page,
    required this.pageSize,
    required this.isLoading,
    required this.message,
  });

  @override
  List<Object> get props => [isLoading, page, pageSize, message];
}

class GetMyPostCompanyEvent extends MyCompanyEvent {
  final bool isLoading;
  final String message;
  final int page;
  final int pageSize;
  final String id;

  const GetMyPostCompanyEvent({
    required this.page,
    required this.pageSize,
    required this.isLoading,
    required this.message,
    required this.id,
  });

  @override
  List<Object> get props => [isLoading, page, pageSize, message, id];
}
