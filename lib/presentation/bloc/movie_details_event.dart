import 'package:equatable/equatable.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieDetails extends MovieDetailsEvent {
  const LoadMovieDetails(this.movieId);

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

class LoadMovieGenres extends MovieDetailsEvent {
  const LoadMovieGenres(this.movieId);

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

class LoadMovieCredits extends MovieDetailsEvent {
  const LoadMovieCredits(this.movieId);

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

class LoadMovieVideos extends MovieDetailsEvent {
  const LoadMovieVideos(this.movieId);

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

class LoadAllMovieDetails extends MovieDetailsEvent {
  const LoadAllMovieDetails(this.movieId);

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}
