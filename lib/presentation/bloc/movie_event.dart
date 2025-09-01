import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllMovies extends MovieEvent {
  const LoadAllMovies();
}

class LoadTrendingMovies extends MovieEvent {
  const LoadTrendingMovies();
}

class LoadNowPlayingMovies extends MovieEvent {
  const LoadNowPlayingMovies();
}

class LoadPopularMovies extends MovieEvent {
  const LoadPopularMovies();
}

class LoadTopRatedMovies extends MovieEvent {
  const LoadTopRatedMovies();
}

class LoadUpcomingMovies extends MovieEvent {
  const LoadUpcomingMovies();
}

class RefreshAllMovies extends MovieEvent {
  const RefreshAllMovies();
}
