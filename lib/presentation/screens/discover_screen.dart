import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/core/routing/app_routes.dart';
import 'package:movie_verse/data/datasources/tmdb_api_service.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/search_bloc.dart';
import 'package:movie_verse/presentation/bloc/search_event.dart';
import 'package:movie_verse/presentation/bloc/search_state.dart';
import 'package:movie_verse/presentation/widgets/search_results_grid.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(movieRepository: MovieRepository(TMDBApiService())),
      child: const DiscoverView(),
    );
  }
}

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onMovieTap(Movie movie) {
    context.push(AppRoutes.movieDetailsScreen, extra: movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.discover), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: AppStyles.largePadding,
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.findMoviesTvSeriesAndMore,
                    style: AppStyles.movieTitleLarge,
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      return TextField(
                        controller: _searchController,
                        decoration: AppStyles.searchInputDecoration.copyWith(
                          hintText: AppStrings.searchHint,
                          suffixIcon: state.query.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    context.read<SearchBloc>().add(
                                      const SearchCleared(),
                                    );
                                  },
                                )
                              : null,
                        ),
                        cursorColor: AppColors.primaryAccent,
                        cursorErrorColor: AppColors.error,
                        onChanged: (query) {
                          context.read<SearchBloc>().add(
                            SearchQueryChanged(query),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.query.isEmpty) {
                  return _buildInitialContent();
                }

                return Expanded(
                  child: Column(
                    children: [
                      // Search results header
                      Container(
                        width: double.infinity,
                        padding: AppStyles.horizontalPadding,
                        child: Text(
                          state.totalResults > 0
                              ? '${AppStrings.searchResultsFor} "${state.query}" (${state.totalResults} results)'
                              : '${AppStrings.searchNoResultsFor} "${state.query}"',
                          style: AppStyles.searchHeaderText,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Tab bar for filtering results
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: AppStrings.all),
                          Tab(text: AppStrings.movies),
                          Tab(text: AppStrings.tvShows),
                          Tab(text: AppStrings.people),
                        ],
                      ),

                      // Search results
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildSearchResults(state, 'all'),
                            _buildSearchResults(state, 'movies'),
                            _buildSearchResults(state, 'tv'),
                            _buildSearchResults(state, 'people'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: AppStrings.all),
              Tab(text: AppStrings.movies),
              Tab(text: AppStrings.tvShows),
              Tab(text: AppStrings.people),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmptyState(
                  'Start typing to search for movies, TV shows, and people',
                ),
                _buildEmptyState('Search for your favorite movies'),
                _buildEmptyState('Discover amazing TV shows'),
                _buildEmptyState('Find actors, directors, and crew members'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchState state, String contentType) {
    List<Movie> filteredMovies = state.movies;

    // For now, we'll show all movies in each tab since the API returns movies
    // In a real app, you'd have separate search endpoints for TV shows and people
    switch (contentType) {
      case 'movies':
        // Already movies, no filtering needed
        break;
      case 'tv':
        // In a real implementation, you'd call a separate TV search API
        filteredMovies = [];
        break;
      case 'people':
        // In a real implementation, you'd call a separate people search API
        filteredMovies = [];
        break;
      case 'all':
      default:
        // Show all results
        break;
    }

    return SearchResultsGrid(
      movies: filteredMovies,
      isLoading: state.status == SearchStatus.loading,
      isLoadingMore: state.status == SearchStatus.loadingMore,
      hasError: state.status == SearchStatus.failure,
      errorMessage: state.error,
      hasReachedMax: state.hasReachedMax,
      onMovieTap: _onMovieTap,
      onLoadMore: () {
        context.read<SearchBloc>().add(const LoadMoreSearchResults());
      },
      onRetry: () {
        context.read<SearchBloc>().add(SearchQueryChanged(state.query));
      },
      emptyMessage: _getEmptyMessage(contentType),
    );
  }

  String _getEmptyMessage(String contentType) {
    switch (contentType) {
      case 'movies':
        return 'No movies found';
      case 'tv':
        return 'No TV shows found';
      case 'people':
        return 'No people found';
      default:
        return AppStrings.searchNoResults;
    }
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: AppStyles.allPadding,
        child: Column(
          spacing: 16.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64.sp, color: AppColors.mutedText),
            Text(
              message,
              style: AppStyles.movieTitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}