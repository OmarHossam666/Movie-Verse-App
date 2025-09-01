import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';
import 'package:movie_verse/presentation/widgets/horizontal_movie_list.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_movie_list.dart';

class MovieSection extends StatelessWidget {
  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.status,
    this.error,
    this.onRetry,
    this.cardWidth,
    this.cardHeight,
    this.showDetails = true,
    this.onSeeAllTap,
    this.size = MovieCardSize.medium,
  });

  final String title;
  final List<Movie> movies;
  final MovieStatus status;
  final String? error;
  final VoidCallback? onRetry;
  final double? cardWidth;
  final double? cardHeight;
  final bool showDetails;
  final VoidCallback? onSeeAllTap;
  final MovieCardSize size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: AppStyles.horizontalPadding,
          child: Text(title, style: AppStyles.sectionHeader),
        ),

        SizedBox(height: 12.h),

        // Content
        if (status == MovieStatus.loading)
          ShimmerMovieList(
            cardWidth: cardWidth,
            cardHeight: cardHeight,
            showDetails: showDetails,
          )
        else if (status == MovieStatus.failure)
          SizedBox(
            height: cardHeight ?? 280.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    error ?? 'Something went wrong',
                    style: AppStyles.labelText,
                    textAlign: TextAlign.center,
                  ),
                  if (onRetry != null) ...[
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: onRetry,
                      child: Text('Retry', style: AppStyles.bodyText),
                    ),
                  ],
                ],
              ),
            ),
          )
        else
          HorizontalMovieList(
            movies: movies,
            cardWidth: cardWidth,
            cardHeight: cardHeight,
            showDetails: showDetails,
            size: size,
          ),
      ],
    );
  }
}
