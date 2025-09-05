import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/core/routing/app_routes.dart';
import 'package:movie_verse/data/datasources/tmdb_api_service.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/movie_list_bloc.dart';
import 'package:movie_verse/presentation/bloc/movie_list_event.dart';
import 'package:movie_verse/presentation/bloc/movie_list_state.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_grid.dart';
import 'package:movie_verse/presentation/widgets/shimmer_movie_card.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieListBloc(movieRepository: MovieRepository(TMDBApiService()))
            ..add(LoadMovieList(category: title)),
      child: SeeAllView(title: title),
    );
  }
}

class SeeAllView extends StatefulWidget {
  const SeeAllView({super.key, required this.title});

  final String title;

  @override
  State<SeeAllView> createState() => _SeeAllViewState();
}

class _SeeAllViewState extends State<SeeAllView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MovieListBloc>().add(const LoadMoreMovies());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onMovieTap(movie) {
    context.push(AppRoutes.movieDetailsScreen, extra: movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          switch (state.status) {
            case MovieListStatus.loading:
              return const ShimmerGrid();

            case MovieListStatus.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.sp,
                      color: AppColors.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      state.error ?? 'Something went wrong',
                      style: AppStyles.bodyText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MovieListBloc>().add(
                          const RefreshMovieList(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case MovieListStatus.success:
            case MovieListStatus.loadingMore:
              return RefreshIndicator(
                color: AppColors.primaryAccent,
                backgroundColor: AppColors.primaryBackground,
                onRefresh: () async {
                  context.read<MovieListBloc>().add(const RefreshMovieList());
                },
                child: GridView.builder(
                  controller: _scrollController,
                  padding: AppStyles.largePadding,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemCount: state.hasReachedMax
                      ? state.movies.length
                      : state.movies.length +
                            2, // Add shimmer cards for loading more
                  itemBuilder: (context, index) {
                    if (index >= state.movies.length) {
                      return const ShimmerMovieCard(showDetails: true);
                    }

                    final movie = state.movies[index];
                    return MovieCard(
                      movie: movie,
                      size: MovieCardSize.medium,
                      onMovieTap: () => _onMovieTap(movie),
                    );
                  },
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
