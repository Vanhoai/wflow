class ServerException implements Exception {
  ServerException({this.message = "Server Error"});

  final String message;
}

class CacheException implements Exception {}
