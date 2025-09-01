class TMDBException implements Exception {
  final String message;
  final int? statusCode;

  const TMDBException(this.message, [this.statusCode]);

  @override
  String toString() {
    return 'TMDBException: $message, statusCode: $statusCode';
  }
}
