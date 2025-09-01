import 'package:equatable/equatable.dart';
import 'package:movie_verse/data/models/movie_model.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.trendingStatus = MovieStatus.initial,
    this.nowPlayingStatus = MovieStatus.initial,
    this.popularStatus = MovieStatus.initial,
    this.topRatedStatus = MovieStatus.initial,
    this.upcomingStatus = MovieStatus.initial,
    this.trendingMovies = const [],
    this.nowPlayingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.nowPlayingError,
    this.popularError,
    this.topRatedError,
    this.upcomingError,
    this.trendingError,
  });

  final MovieStatus trendingStatus;
  final MovieStatus nowPlayingStatus;
  final MovieStatus popularStatus;
  final MovieStatus topRatedStatus;
  final MovieStatus upcomingStatus;

  final List<Movie> trendingMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  final String? trendingError;
  final String? nowPlayingError;
  final String? popularError;
  final String? topRatedError;
  final String? upcomingError;

  MovieState copyWith({
    MovieStatus? trendingStatus,
    MovieStatus? nowPlayingStatus,
    MovieStatus? popularStatus,
    MovieStatus? topRatedStatus,
    MovieStatus? upcomingStatus,
    List<Movie>? trendingMovies,
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    String? trendingError,
    String? nowPlayingError,
    String? popularError,
    String? topRatedError,
    String? upcomingError,
  }) {
    return MovieState(
      trendingStatus: trendingStatus ?? this.trendingStatus,
      nowPlayingStatus: nowPlayingStatus ?? this.nowPlayingStatus,
      popularStatus: popularStatus ?? this.popularStatus,
      topRatedStatus: topRatedStatus ?? this.topRatedStatus,
      upcomingStatus: upcomingStatus ?? this.upcomingStatus,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      trendingError: trendingError,
      nowPlayingError: nowPlayingError,
      popularError: popularError,
      topRatedError: topRatedError,
      upcomingError: upcomingError,
    );
  }

  @override
  List<Object?> get props => [
    trendingStatus,
    nowPlayingStatus,
    popularStatus,
    topRatedStatus,
    upcomingStatus,
    trendingMovies,
    nowPlayingMovies,
    popularMovies,
    topRatedMovies,
    upcomingMovies,
    trendingError,
    nowPlayingError,
    popularError,
    topRatedError,
    upcomingError,
  ];
}
