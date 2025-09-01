import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_movie_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_movie_list.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({
    super.key,
    required this.movies,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasError,
    required this.errorMessage,
    required this.hasReachedMax,
    required this.onMovieTap,
    required this.onLoadMore,
    required this.onRetry,
    this.emptyMessage = AppStrings.searchNoResults,
  });

  final List<Movie> movies;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasError;
  final String? errorMessage;
  final bool hasReachedMax;
  final Function(Movie) onMovieTap;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading && movies.isEmpty) {
      return const ShimmerMovieList(
        itemCount: 6,
        size: MovieCardSize.medium,
        scrollDirection: Axis.vertical,
      );
    }

    if (hasError && movies.isEmpty) {
      return _buildErrorWidget();
    }

    if (movies.isEmpty) {
      return _buildEmptyWidget();
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!hasReachedMax &&
            !isLoadingMore &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          onLoadMore();
        }
        return false;
      },
      child: GridView.builder(
        padding: AppStyles.allPadding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: movies.length + (isLoadingMore ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return const ShimmerMovieCard(size: MovieCardSize.medium);
          }

          final movie = movies[index];
          return MovieCard(
            movie: movie,
            size: MovieCardSize.medium,
            onMovieTap: () => onMovieTap(movie),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: AppStyles.allPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: AppColors.error),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: AppStyles.movieTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              errorMessage ?? 'Please try again',
              style: AppStyles.bodyText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: onRetry,
              style: AppStyles.playButtonStyle,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: AppStyles.allPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64.sp, color: AppColors.mutedText),
            SizedBox(height: 16.h),
            Text(
              emptyMessage,
              style: AppStyles.movieTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Try searching for something else',
              style: AppStyles.bodyText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
