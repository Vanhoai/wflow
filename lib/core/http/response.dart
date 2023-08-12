class HttpResponse<T> {
  final int statusCode;
  final String message;
  final T data;

  HttpResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory HttpResponse.fromJson(Map<String, dynamic> json) {
    return HttpResponse(
      statusCode: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}
