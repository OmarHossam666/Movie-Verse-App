import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/core/routing/app_routes.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';

class HorizontalMovieList extends StatelessWidget {
  const HorizontalMovieList({
    super.key,
    required this.movies,
    this.cardWidth,
    this.cardHeight,
    this.showDetails = true,
    this.size = MovieCardSize.medium,
  });

  final List<Movie> movies;
  final double? cardWidth;
  final double? cardHeight;
  final bool showDetails;
  final MovieCardSize size;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return SizedBox(
        height: cardHeight ?? _getDefaultHeight(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie_outlined,
                size: 48.sp,
                color: AppColors.mutedText,
              ),
              SizedBox(height: 8.h),
              Text(
                'No movies available',
                style: AppStyles.bodyText.copyWith(color: AppColors.mutedText),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: cardHeight ?? _getDefaultHeight(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            child: MovieCard(
              movie: movie,
              width: cardWidth,
              height: cardHeight,
              showDetails: showDetails,
              size: size,
              onMovieTap: () => context.push(AppRoutes.movieDetailsScreen, extra: movie),
            ),
          );
        },
      ),
    );
  }

  double _getDefaultHeight() {
    return switch (size) {
      MovieCardSize.small =>
        showDetails
            ? AppStyles.movieCardSmallHeight
            : AppStyles.movieCardSmallHeight * 0.7,
      MovieCardSize.medium =>
        showDetails
            ? AppStyles.movieCardMediumHeight
            : AppStyles.movieCardMediumHeight * 0.7,
      MovieCardSize.large =>
        showDetails
            ? AppStyles.movieCardLargeHeight
            : AppStyles.movieCardLargeHeight * 0.7,
    };
  }
}
