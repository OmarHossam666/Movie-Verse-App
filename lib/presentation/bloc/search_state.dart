import 'package:equatable/equatable.dart';
import 'package:movie_verse/data/models/movie_model.dart';

enum SearchStatus { initial, loading, success, failure, loadingMore }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.movies = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalResults = 0,
    this.hasReachedMax = false,
    this.error,
  });

  final SearchStatus status;
  final String query;
  final List<Movie> movies;
  final int currentPage;
  final int totalPages;
  final int totalResults;
  final bool hasReachedMax;
  final String? error;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<Movie>? movies,
    int? currentPage,
    int? totalPages,
    int? totalResults,
    bool? hasReachedMax,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    query,
    movies,
    currentPage,
    totalPages,
    totalResults,
    hasReachedMax,
    error,
  ];
}
