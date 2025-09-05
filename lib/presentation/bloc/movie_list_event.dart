import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieList extends MovieListEvent {
  const LoadMovieList({required this.category});

  final String category;

  @override
  List<Object?> get props => [category];
}

class LoadMoreMovies extends MovieListEvent {
  const LoadMoreMovies();
}

class RefreshMovieList extends MovieListEvent {
  const RefreshMovieList();
}
