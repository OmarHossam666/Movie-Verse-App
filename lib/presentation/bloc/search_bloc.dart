import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/search_event.dart';
import 'package:movie_verse/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.movieRepository}) : super(const SearchState()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchCleared>(_onSearchCleared);
    on<LoadMoreSearchResults>(_onLoadMoreSearchResults);
  }

  final MovieRepository movieRepository;
  Timer? _debounceTimer;

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      emit(const SearchState());
      return;
    }

    // Create a completer to properly handle the debounced operation
    final completer = Completer<void>();

    // Debounce search requests
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      completer.complete();
    });

    // Wait for the debounce timer to complete
    await completer.future;

    // Check if the emitter is still active and perform search
    if (!emit.isDone) {
      await _performSearch(query, emit);
    }
  }

  Future<void> _performSearch(String query, Emitter<SearchState> emit) async {
    try {
      if (emit.isDone) return;

      emit(
        state.copyWith(status: SearchStatus.loading, query: query, error: null),
      );

      final response = await movieRepository.searchMovies(
        query: query,
        page: 1,
      );

      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: SearchStatus.success,
          movies: response.results,
          currentPage: response.page,
          totalPages: response.totalPages,
          totalResults: response.totalResults,
          hasReachedMax: response.page >= response.totalPages,
        ),
      );
    } catch (error) {
      if (!emit.isDone) {
        emit(
          state.copyWith(status: SearchStatus.failure, error: error.toString()),
        );
      }
    }
  }

  Future<void> _onSearchCleared(
    SearchCleared event,
    Emitter<SearchState> emit,
  ) async {
    _debounceTimer?.cancel();
    emit(const SearchState());
  }

  Future<void> _onLoadMoreSearchResults(
    LoadMoreSearchResults event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachedMax || state.status == SearchStatus.loadingMore) {
      return;
    }

    try {
      if (emit.isDone) return;

      emit(state.copyWith(status: SearchStatus.loadingMore));

      final nextPage = state.currentPage + 1;
      final response = await movieRepository.searchMovies(
        query: state.query,
        page: nextPage,
      );

      if (emit.isDone) return;

      final updatedMovies = List.of(state.movies)..addAll(response.results);

      emit(
        state.copyWith(
          status: SearchStatus.success,
          movies: updatedMovies,
          currentPage: response.page,
          hasReachedMax: response.page >= response.totalPages,
        ),
      );
    } catch (error) {
      if (!emit.isDone) {
        emit(
          state.copyWith(status: SearchStatus.failure, error: error.toString()),
        );
      }
    }
  }
}
