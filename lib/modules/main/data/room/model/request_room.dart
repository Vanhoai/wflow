class PaginationModel {
  final int page;
  final int pageSize;
  final String search;

  const PaginationModel({
    required this.page,
    required this.pageSize,
    required this.search,
  });
}
