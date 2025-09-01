import 'package:equatable/equatable.dart';
import 'package:movie_verse/data/models/movie_model.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.nowPlayingStatus = MovieStatus.initial,
    this.popularStatus = MovieStatus.initial,
    this.topRatedStatus = MovieStatus.initial,
    this.upcomingStatus = MovieStatus.initial,
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.nowPlayingError,
    this.popularError,
    this.topRatedError,
    this.upcomingError,
  });

  final MovieStatus nowPlayingStatus;
  final MovieStatus popularStatus;
  final MovieStatus topRatedStatus;
  final MovieStatus upcomingStatus;

  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  final String? nowPlayingError;
  final String? popularError;
  final String? topRatedError;
  final String? upcomingError;

  MovieState copyWith({
    MovieStatus? nowPlayingStatus,
    MovieStatus? popularStatus,
    MovieStatus? topRatedStatus,
    MovieStatus? upcomingStatus,
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    String? nowPlayingError,
    String? popularError,
    String? topRatedError,
    String? upcomingError,
  }) {
    return MovieState(
      nowPlayingStatus: nowPlayingStatus ?? this.nowPlayingStatus,
      popularStatus: popularStatus ?? this.popularStatus,
      topRatedStatus: topRatedStatus ?? this.topRatedStatus,
      upcomingStatus: upcomingStatus ?? this.upcomingStatus,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      nowPlayingError: nowPlayingError,
      popularError: popularError,
      topRatedError: topRatedError,
      upcomingError: upcomingError,
    );
  }

  @override
  List<Object?> get props => [
    nowPlayingStatus,
    popularStatus,
    topRatedStatus,
    upcomingStatus,
    nowPlayingMovies,
    popularMovies,
    topRatedMovies,
    upcomingMovies,
    nowPlayingError,
    popularError,
    topRatedError,
    upcomingError,
  ];
}
