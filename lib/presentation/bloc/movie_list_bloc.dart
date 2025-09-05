import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/movie_list_event.dart';
import 'package:movie_verse/presentation/bloc/movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(const MovieListState()) {
    on<LoadMovieList>(_onLoadMovieList);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<RefreshMovieList>(_onRefreshMovieList);
  }

  final MovieRepository _movieRepository;

  Future<void> _onLoadMovieList(
    LoadMovieList event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(status: MovieListStatus.loading));

    try {
      final response = await _getMoviesByCategory(event.category, page: 1);

      emit(
        state.copyWith(
          status: MovieListStatus.success,
          movies: response.results,
          currentPage: response.page,
          totalPages: response.totalPages,
          hasReachedMax: response.page >= response.totalPages,
          category: event.category,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: MovieListStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.hasReachedMax || state.status == MovieListStatus.loading) {
      return;
    }

    emit(state.copyWith(status: MovieListStatus.loadingMore));

    try {
      final nextPage = state.currentPage + 1;
      final response = await _getMoviesByCategory(
        state.category,
        page: nextPage,
      );

      emit(
        state.copyWith(
          status: MovieListStatus.success,
          movies: [...state.movies, ...response.results],
          currentPage: response.page,
          hasReachedMax: response.page >= response.totalPages,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: MovieListStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshMovieList(
    RefreshMovieList event,
    Emitter<MovieListState> emit,
  ) async {
    emit(const MovieListState());
    add(LoadMovieList(category: state.category));
  }

  Future<dynamic> _getMoviesByCategory(String category, {int page = 1}) async {
    switch (category.toLowerCase()) {
      case 'trending':
        return await _movieRepository.getTrendingMovies(page: page);
      case 'now playing':
        return await _movieRepository.getNowPlayingMovies(page: page);
      case 'popular':
        return await _movieRepository.getPopularMovies(page: page);
      case 'top rated':
        return await _movieRepository.getTopRatedMovies(page: page);
      case 'upcoming':
        return await _movieRepository.getUpcomingMovies(page: page);
      default:
        throw Exception('Unknown category: $category');
    }
  }
}
