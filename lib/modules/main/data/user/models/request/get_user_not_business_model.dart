class GetUserNotBusinessModel {
  final int page;
  final int pageSize;
  final String search;

  const GetUserNotBusinessModel({
    this.page = 1,
    this.pageSize = 10,
    this.search = '',
  });
}
