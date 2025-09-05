import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/movie_details_event.dart';
import 'package:movie_verse/presentation/bloc/movie_details_state.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(const MovieDetailsState()) {
    on<LoadAllMovieDetails>(_onLoadAllMovieDetails);
    on<LoadMovieDetails>(_onLoadMovieDetails);
    on<LoadMovieCredits>(_onLoadMovieCredits);
    on<LoadMovieVideos>(_onLoadMovieVideos);
  }

  final MovieRepository _movieRepository;

  Future<void> _onLoadAllMovieDetails(
    LoadAllMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    await Future.wait([
      _loadMovieDetails(event.movieId, emit),
      _loadMovieCredits(event.movieId, emit),
      _loadMovieVideos(event.movieId, emit),
    ]);
  }

  Future<void> _onLoadMovieDetails(
    LoadMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    await _loadMovieDetails(event.movieId, emit);
  }

  Future<void> _onLoadMovieCredits(
    LoadMovieCredits event,
    Emitter<MovieDetailsState> emit,
  ) async {
    await _loadMovieCredits(event.movieId, emit);
  }

  Future<void> _onLoadMovieVideos(
    LoadMovieVideos event,
    Emitter<MovieDetailsState> emit,
  ) async {
    await _loadMovieVideos(event.movieId, emit);
  }

  Future<void> _loadMovieDetails(
    int movieId,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (state.detailsStatus != MovieStatus.loading) {
      emit(state.copyWith(detailsStatus: MovieStatus.loading));
    }

    try {
      final movieDetails = await _movieRepository.getMovieDetails(movieId);
      if (movieDetails.genres != null && movieDetails.genres!.isNotEmpty) {
      } else {}

      emit(
        state.copyWith(
          detailsStatus: MovieStatus.success,
          movieDetails: movieDetails,
          detailsError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          detailsStatus: MovieStatus.failure,
          detailsError: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadMovieCredits(
    int movieId,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (state.creditsStatus != MovieStatus.loading) {
      emit(state.copyWith(creditsStatus: MovieStatus.loading));
    }

    try {
      final movieCredits = await _movieRepository.getMovieCredits(movieId);
      emit(
        state.copyWith(
          creditsStatus: MovieStatus.success,
          movieCredits: movieCredits,
          creditsError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          creditsStatus: MovieStatus.failure,
          creditsError: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadMovieVideos(
    int movieId,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (state.videosStatus != MovieStatus.loading) {
      emit(state.copyWith(videosStatus: MovieStatus.loading));
    }

    try {
      final movieVideos = await _movieRepository.getMovieVideos(movieId);
      emit(
        state.copyWith(
          videosStatus: MovieStatus.success,
          movieVideos: movieVideos,
          videosError: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          videosStatus: MovieStatus.failure,
          videosError: error.toString(),
        ),
      );
    }
  }
}
