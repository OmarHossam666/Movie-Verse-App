import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/movie_event.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(const MovieState()) {
    on<LoadAllMovies>(_onLoadAllMovies);
    on<LoadTrendingMovies>(_onLoadTrendingMovies);
    on<LoadNowPlayingMovies>(_onLoadNowPlayingMovies);
    on<LoadPopularMovies>(_onLoadPopularMovies);
    on<LoadTopRatedMovies>(_onLoadTopRatedMovies);
    on<LoadUpcomingMovies>(_onLoadUpcomingMovies);
    on<RefreshAllMovies>(_onRefreshAllMovies);
  }

  final MovieRepository _movieRepository;

  Future<void> _onLoadAllMovies(
    LoadAllMovies event,
    Emitter<MovieState> emit,
  ) async {
    await Future.wait([
      _loadTrendingMovies(emit),
      _loadNowPlayingMovies(emit),
      _loadPopularMovies(emit),
      _loadTopRatedMovies(emit),
      _loadUpcomingMovies(emit),
    ]);
  }

  Future<void> _onLoadTrendingMovies(
    LoadTrendingMovies event,
    Emitter<MovieState> emit,
  ) async {
    await _loadTrendingMovies(emit);
  }

  Future<void> _onLoadNowPlayingMovies(
    LoadNowPlayingMovies event,
    Emitter<MovieState> emit,
  ) async {
    await _loadNowPlayingMovies(emit);
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<MovieState> emit,
  ) async {
    await _loadPopularMovies(emit);
  }

  Future<void> _onLoadTopRatedMovies(
    LoadTopRatedMovies event,
    Emitter<MovieState> emit,
  ) async {
    await _loadTopRatedMovies(emit);
  }

  Future<void> _onLoadUpcomingMovies(
    LoadUpcomingMovies event,
    Emitter<MovieState> emit,
  ) async {
    await _loadUpcomingMovies(emit);
  }

  Future<void> _onRefreshAllMovies(
    RefreshAllMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(
      state.copyWith(
        trendingStatus: MovieStatus.loading,
        nowPlayingStatus: MovieStatus.loading,
        popularStatus: MovieStatus.loading,
        topRatedStatus: MovieStatus.loading,
        upcomingStatus: MovieStatus.loading,
      ),
    );

    await Future.wait([
      _loadTrendingMovies(emit, forceRefresh: true),
      _loadNowPlayingMovies(emit, forceRefresh: true),
      _loadPopularMovies(emit, forceRefresh: true),
      _loadTopRatedMovies(emit, forceRefresh: true),
      _loadUpcomingMovies(emit, forceRefresh: true),
    ]);
  }

  Future<void> _loadTrendingMovies(
    Emitter<MovieState> emit, {
    bool forceRefresh = false,
  }) async {
    if (state.trendingStatus != MovieStatus.loading) {
      emit(state.copyWith(trendingStatus: MovieStatus.loading));
    }

    try {
      final response = await _movieRepository.getTrendingMovies(
        forceRefresh: forceRefresh,
      );
      emit(
        state.copyWith(
          trendingStatus: MovieStatus.success,
          trendingMovies: response.results,
          trendingError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          trendingStatus: MovieStatus.failure,
          trendingError: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadNowPlayingMovies(
    Emitter<MovieState> emit, {
    bool forceRefresh = false,
  }) async {
    if (state.nowPlayingStatus != MovieStatus.loading) {
      emit(state.copyWith(nowPlayingStatus: MovieStatus.loading));
    }

    try {
      final response = await _movieRepository.getNowPlayingMovies(
        forceRefresh: forceRefresh,
      );
      emit(
        state.copyWith(
          nowPlayingStatus: MovieStatus.success,
          nowPlayingMovies: response.results,
          nowPlayingError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          nowPlayingStatus: MovieStatus.failure,
          nowPlayingError: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadPopularMovies(
    Emitter<MovieState> emit, {
    bool forceRefresh = false,
  }) async {
    if (state.popularStatus != MovieStatus.loading) {
      emit(state.copyWith(popularStatus: MovieStatus.loading));
    }

    try {
      final response = await _movieRepository.getPopularMovies(
        forceRefresh: forceRefresh,
      );
      emit(
        state.copyWith(
          popularStatus: MovieStatus.success,
          popularMovies: response.results,
          popularError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          popularStatus: MovieStatus.failure,
          popularError: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadTopRatedMovies(
    Emitter<MovieState> emit, {
    bool forceRefresh = false,
  }) async {
    if (state.topRatedStatus != MovieStatus.loading) {
      emit(state.copyWith(topRatedStatus: MovieStatus.loading));
    }

    try {
      final response = await _movieRepository.getTopRatedMovies(
        forceRefresh: forceRefresh,
      );
      emit(
        state.copyWith(
          topRatedStatus: MovieStatus.success,
          topRatedMovies: response.results,
          topRatedError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          topRatedStatus: MovieStatus.failure,
          topRatedError: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadUpcomingMovies(
    Emitter<MovieState> emit, {
    bool forceRefresh = false,
  }) async {
    if (state.upcomingStatus != MovieStatus.loading) {
      emit(state.copyWith(upcomingStatus: MovieStatus.loading));
    }

    try {
      final response = await _movieRepository.getUpcomingMovies(
        forceRefresh: forceRefresh,
      );
      emit(
        state.copyWith(
          upcomingStatus: MovieStatus.success,
          upcomingMovies: response.results,
          upcomingError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          upcomingStatus: MovieStatus.failure,
          upcomingError: error.toString(),
        ),
      );
    }
  }
}
