class ApplyPostRequest {
  final num post;
  final num cv;

  ApplyPostRequest({required this.post, required this.cv});
  Map<String, dynamic> toJson() => {
        'post': post,
        'cv': cv,
      };
}
