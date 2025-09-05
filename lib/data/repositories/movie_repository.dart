import 'package:movie_verse/data/datasources/tmdb_api_service.dart';
import 'package:movie_verse/data/models/cached_data.dart';
import 'package:movie_verse/data/models/paginated_movie_response.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/data/models/cast_model.dart';
import 'package:movie_verse/data/models/video_model.dart';

class MovieRepository {
  MovieRepository(this._apiService);

  final TMDBApiService _apiService;
  final Map<String, CachedData<PaginatedMovieResponse>> _cache = {};
  final Duration _cacheDuration = const Duration(minutes: 15);

  Future<PaginatedMovieResponse> getNowPlayingMovies({
    int page = 1,
    String region = 'US',
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'now_playing_${page}_$region';

    if (!forceRefresh && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    final response = await _apiService.getNowPlayingMovies(
      page: page,
      region: region,
    );

    return response;
  }

  Future<PaginatedMovieResponse> getPopularMovies({
    int page = 1,
    String region = 'US',
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'popular_${page}_$region';

    if (!forceRefresh && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    final response = await _apiService.getPopularMovies(
      page: page,
      region: region,
    );

    return response;
  }

  Future<PaginatedMovieResponse> getTopRatedMovies({
    int page = 1,
    String region = 'US',
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'top_rated_${page}_$region';

    if (!forceRefresh && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    final response = await _apiService.getTopRatedMovies(
      page: page,
      region: region,
    );

    return response;
  }

  Future<PaginatedMovieResponse> getUpcomingMovies({
    int page = 1,
    String region = 'US',
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'upcoming_${page}_$region';

    if (!forceRefresh && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    final response = await _apiService.getUpcomingMovies(
      page: page,
      region: region,
    );

    return response;
  }

  Future<PaginatedMovieResponse> getTrendingMovies({
    int page = 1,
    String timeWindow = 'day',
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'trending_${page}_$timeWindow';

    if (!forceRefresh && _isCacheValid(cacheKey)) {
      return _cache[cacheKey]!.data;
    }

    final response = await _apiService.getTrendingMovies(
      page: page,
      timeWindow: timeWindow,
    );

    return response;
  }

  Future<PaginatedMovieResponse> searchMovies({
    required String query,
    int page = 1,
    bool includeAdult = false,
    String? region,
    int? year,
  }) async {
    return await _apiService.searchMovies(
      query: query,
      page: page,
      region: region,
      year: year,
      includeAdult: includeAdult,
    );
  }

  Future<Movie> getMovieDetails(int movieId) async {
    return await _apiService.getMovieDetails(movieId);
  }

  Future<MovieCredits> getMovieCredits(int movieId) async {
    return await _apiService.getMovieCredits(movieId);
  }

  Future<MovieVideos> getMovieVideos(int movieId) async {
    return await _apiService.getMovieVideos(movieId);
  }

  bool _isCacheValid(String cacheKey) {
    if (!_cache.containsKey(cacheKey)) return false;

    final cachedData = _cache[cacheKey]!;
    final now = DateTime.now();

    return now.difference(cachedData.timeStamp) < _cacheDuration;
  }
}
