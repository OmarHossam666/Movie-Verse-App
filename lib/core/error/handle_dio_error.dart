import 'package:dio/dio.dart';
import 'package:movie_verse/core/error/tmdb_exception.dart';

TMDBException handleDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return TMDBException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.receiveTimeout:
        return TMDBException('Receive timeout. Please try again.');
      case DioExceptionType.sendTimeout:
        return TMDBException('Send timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final message = exception.response?.data?['status_message'] ?? 'Unknown error occurred';
        return TMDBException('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return TMDBException('Request was cancelled.');
      case DioExceptionType.unknown:
        return TMDBException('Network error. Please check your internet connection.');
      default:
        return TMDBException('An unexpected error occurred.');
    }
  }