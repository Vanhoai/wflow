class ServerException implements Exception {
  ServerException(dynamic data) {
    if (data is String) {
      message = data;
    } else if (data is Map) {
      message = data.toString();
    }
  }

  String message = 'Có lỗi xảy ra, vui lòng thử lại sau';

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {}
