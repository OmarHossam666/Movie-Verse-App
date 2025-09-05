import 'package:equatable/equatable.dart';
import 'package:movie_verse/data/models/movie_model.dart';

enum MovieListStatus { initial, loading, loadingMore, success, failure }

class MovieListState extends Equatable {
  const MovieListState({
    this.status = MovieListStatus.initial,
    this.movies = const [],
    this.currentPage = 0,
    this.totalPages = 0,
    this.hasReachedMax = false,
    this.category = '',
    this.error,
  });

  final MovieListStatus status;
  final List<Movie> movies;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;
  final String category;
  final String? error;

  MovieListState copyWith({
    MovieListStatus? status,
    List<Movie>? movies,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
    String? category,
    String? error,
  }) {
    return MovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      category: category ?? this.category,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    movies,
    currentPage,
    totalPages,
    hasReachedMax,
    category,
    error,
  ];
}
