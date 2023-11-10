import 'package:equatable/equatable.dart';

class GetAllCollaboratorModel extends Equatable {
  final int page;
  final int pageSize;

  const GetAllCollaboratorModel({this.page = 1, this.pageSize = 10});

  @override
  List get props => [page, pageSize];
}
