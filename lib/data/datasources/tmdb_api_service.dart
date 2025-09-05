import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_verse/core/error/handle_dio_error.dart';
import 'package:movie_verse/data/datasources/tmdb_config.dart';
import 'package:movie_verse/data/models/paginated_movie_response.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/data/models/cast_model.dart';
import 'package:movie_verse/data/models/video_model.dart';
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
          // Let the error pass through to be handled by the individual methods
          handler.next(error);
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
        '/movie/top_rated',
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
        '/movie/upcoming',
        queryParameters: {'page': page, 'region': region},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<PaginatedMovieResponse> getTrendingMovies({
    int page = 1,
    String timeWindow = 'day', // it takes day or week only
  }) async {
    try {
      final response = await _dio.get(
        '/trending/movie/$timeWindow',
        queryParameters: {'page': page},
      );

      return PaginatedMovieResponse.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

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

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId');

      final genresData = response.data['genres'];

      if (genresData != null) {
        if (genresData is List) {
        } else {
        }
      } else {
      }

      try {
        final movie = Movie.fromJson(response.data);
        return movie;
      } catch (e) {
        rethrow;
      }
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<MovieCredits> getMovieCredits(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/credits');
      return MovieCredits.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }

  Future<MovieVideos> getMovieVideos(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId/videos');
      return MovieVideos.fromJson(response.data);
    } on DioException catch (exception) {
      throw handleDioError(exception);
    }
  }
}
