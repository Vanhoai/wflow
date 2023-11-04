import 'package:equatable/equatable.dart';

class GetUserNotBusinessModel extends Equatable {
  final int page;
  final int pageSize;
  final String search;

  const GetUserNotBusinessModel({
    this.page = 1,
    this.pageSize = 10,
    this.search = '',
  });

  GetUserNotBusinessModel coppyWith(
      {int? page, int? pageSize, String? search}) {
    return GetUserNotBusinessModel(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
    );
  }

  @override
  List get props => [page, pageSize, search];
}
