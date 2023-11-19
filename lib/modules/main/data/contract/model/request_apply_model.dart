class RequestApplyModel {
  final int page;
  final int pageSize;
  final String search;

  RequestApplyModel({
    required this.page,
    required this.pageSize,
    required this.search,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'pageSize': pageSize,
        'search': search,
      };
}
