import 'package:wflow/core/models/models.dart';

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
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'],
    );
  }

  @override
  String toString() {
    return 'HttpResponse(statusCode: $statusCode, message: $message, data: $data)';
  }
}

class HttpResponseWithPagination<T> {
  final int statusCode;
  final String message;
  final Meta meta;
  final List<T> data;

  HttpResponseWithPagination({
    required this.statusCode,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory HttpResponseWithPagination.fromJson(Map<String, dynamic> json) {
    return HttpResponseWithPagination(
      statusCode: json['statusCode'],
      message: json['message'],
      meta: Meta.fromJson(json['meta']),
      data: json['data'],
    );
  }

  factory HttpResponseWithPagination.empty() {
    return HttpResponseWithPagination(
      statusCode: 200,
      message: '',
      meta: const Meta(currentPage: 0, totalPage: 0, totalRecord: 0, pageSize: 0),
      data: [],
    );
  }

  HttpResponseWithPagination copyWith({
    int? statusCode,
    String? message,
    Meta? meta,
    List<T>? data,
  }) {
    return HttpResponseWithPagination(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }
}
