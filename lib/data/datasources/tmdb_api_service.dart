import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_verse/core/error/handle_dio_error.dart';
import 'package:movie_verse/core/error/tmdb_exception.dart';
import 'package:movie_verse/data/datasources/tmdb_config.dart';
import 'package:movie_verse/data/models/paginated_movie_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TMDBApiService {
  late final Dio _dio;

  TMDBApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: TMDBConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['api_key'] = TMDBConfig.apiKey;
          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 429) {
            throw TMDBException('Rate limit exceeded. Please try again later.');
          } else if (error.response?.statusCode == 401) {
            throw TMDBException('Invalid API key. Please check your API key.');
          } else if (error.response?.statusCode == 404) {
            throw TMDBException('The requested resource was not found.');
          } else {
            throw TMDBException(
              'An unexpected error occurred. Please try again later.',
            );
          }
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
    ]);
  }

  Future<PaginatedMovieResponse> getNowPlayingMovies({
    int page = 1,
    String region = 'US',
  }) async {
    try {
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page, 'region': region},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<PaginatedMovieResponse> getPopularMovies({
    int page = 1,
    String region = 'US',
  }) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page, 'region': region},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<PaginatedMovieResponse> getTopRatedMovies({
    int page = 1,
    String region = 'US',
  }) async {
    try {
      final response = await _dio.get(
        'movie/top_rated',
        queryParameters: {'page': page, 'region': region},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<PaginatedMovieResponse> getUpcomingMovies({
    int page = 1,
    String region = 'US',
  }) async {
    try {
      final response = await _dio.get(
        'movie/upcoming',
        queryParameters: {'page': page, 'region': region},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<PaginatedMovieResponse> getTrendingMovies({
    int page = 1,
    String region = 'US',
  }) async {
    try {
      final response = await _dio.get(
        'movie/trending',
        queryParameters: {'page': page, 'region': region},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  // This function should be modified if you want to implement live search functionality
  Future<PaginatedMovieResponse> searchMovies({
    required String query,
    int page = 1,
    bool includeAdult = false,
    String? region,
    int? year,
  }) async {
    try {
      final queryParameters = {
        'page': page,
        'include_adult': includeAdult,
        'query': query,
      };

      if (region != null) queryParameters['region'] = region;
      if (year != null) queryParameters['year'] = year;

      final response = await _dio.get(
        '/search/movie',
        queryParameters: queryParameters,
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }
}
