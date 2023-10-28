class ApplyPostRequest {
  final num post;
  final num cv;

  ApplyPostRequest({required this.post, required this.cv});
  Map<String, dynamic> toJson() => {
        'post': post,
        'cv': cv,
      };
}

class GetCandidateApplied {
  final num page;
  final num pageSize;
  final String search;

  const GetCandidateApplied({
    required this.page,
    required this.pageSize,
    required this.search,
  });
}
