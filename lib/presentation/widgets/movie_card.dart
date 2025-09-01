import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/presentation/widgets/poster_shimmer.dart';

enum MovieCardSize { small, medium, large }

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    this.width,
    this.height,
    this.showDetails = true,
    this.size = MovieCardSize.medium,
    this.aspectRatio = 0.67,
    required this.onMovieTap,
  });

  final Movie movie;
  final double? width;
  final double? height;
  final bool showDetails;
  final MovieCardSize size;
  final double aspectRatio;
  final VoidCallback onMovieTap;

  @override
  Widget build(BuildContext context) {
    final cardDimensions = _getCardDimensions();
    final posterSize = _getPosterSize();

    return Container(
      width: width ?? cardDimensions.width,
      height: height ?? cardDimensions.height,
      margin: EdgeInsets.only(right: 12.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: _getBorderRadius(),
          onTap: onMovieTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: _getBorderRadius(),
              boxShadow: _getBoxShadow(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster Section
                Expanded(
                  flex: showDetails ? 7 : 10,
                  child: _buildPosterSection(posterSize),
                ),

                if (showDetails) ...[
                  // Movie Details Section
                  Expanded(flex: 3, child: _buildDetailsSection()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPosterSection(String posterSize) {
    final borderRadius = _getBorderRadius();
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: borderRadius.topLeft,
        bottom: showDetails ? Radius.zero : borderRadius.bottomLeft,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Main poster image
          CachedNetworkImage(
            imageUrl: movie.getPosterUrl(posterSize) ?? '',
            fit: BoxFit.fill,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 100),
            placeholder: (context, url) => PosterShimmer(
              borderRadius: BorderRadius.vertical(
                top: borderRadius.topLeft,
                bottom: showDetails ? Radius.zero : borderRadius.bottomLeft,
              ),
            ),
            errorWidget: (context, url, error) => _buildErrorWidget(),
            memCacheWidth: _getCacheWidth(),
            memCacheHeight: _getCacheHeight(),
          ),

          // Gradient overlay for better text readability
          if (showDetails)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40.h,
              child: Container(decoration: AppStyles.overlayDecoration),
            ),

          // Rating badge (only for medium and large cards)
          if (movie.voteAverage != null &&
              movie.voteAverage! > 0 &&
              size != MovieCardSize.small)
            Positioned(top: 8.h, right: 8.w, child: _buildRatingBadge()),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Expanded(
            child: Text(
              movie.title,
              style: _getTitleStyle(),
              maxLines: size == MovieCardSize.small ? 1 : 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(height: 4.h),

          // Bottom row with rating and year
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Rating (only show if not already shown as badge)
              if (movie.voteAverage != null &&
                  movie.voteAverage! > 0 &&
                  size == MovieCardSize.small)
                _buildInlineRating(),

              // Release year
              if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty)
                Text(movie.releaseDate!.split('-')[0], style: _getYearStyle()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.ratingBackground,
        borderRadius: AppStyles.smallRadius,
        border: Border.all(
          color: AppColors.ratingYellow.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: AppStyles.iconLarge,
            color: AppColors.ratingYellow,
          ),
          SizedBox(width: 2.w),
          Text(
            movie.voteAverage!.toStringAsFixed(1),
            style: AppStyles.ratingText,
          ),
        ],
      ),
    );
  }

  Widget _buildInlineRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          size: AppStyles.iconMedium,
          color: AppColors.ratingYellow,
        ),
        SizedBox(width: 2.w),
        Text(
          movie.voteAverage!.toStringAsFixed(1),
          style: AppStyles.ratingText,
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    final borderRadius = _getBorderRadius();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(
          top: borderRadius.topLeft,
          bottom: showDetails ? Radius.zero : borderRadius.bottomLeft,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_outlined,
              size: _getErrorIconSize(),
              color: AppColors.mutedText,
            ),
            if (size != MovieCardSize.small) ...[
              SizedBox(height: 4.h),
              Text(
                'No Image',
                style: AppStyles.bodyText.copyWith(color: AppColors.mutedText),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper methods for responsive sizing
  ({double width, double height}) _getCardDimensions() {
    final sizeString = switch (size) {
      MovieCardSize.small => 'small',
      MovieCardSize.medium => 'medium',
      MovieCardSize.large => 'large',
    };

    return AppStyles.getMovieCardDimensions(
      size: sizeString,
      withDetails: showDetails,
      responsive: false,
    );
  }

  String _getPosterSize() {
    final cardWidth = _getCardDimensions().width;
    return AppStyles.getPosterSizeForWidth(cardWidth);
  }

  TextStyle _getTitleStyle() {
    return switch (size) {
      MovieCardSize.small => AppStyles.bodyText.copyWith(
        color: AppColors.primaryText,
      ),
      MovieCardSize.medium => AppStyles.movieSubtitle,
      MovieCardSize.large => AppStyles.movieTitle,
    };
  }

  TextStyle _getYearStyle() {
    return switch (size) {
      MovieCardSize.small => AppStyles.detailText.copyWith(fontSize: 14.sp),
      MovieCardSize.medium => AppStyles.detailText,
      MovieCardSize.large => AppStyles.bodyText.copyWith(fontSize: 18.sp),
    };
  }

  double _getErrorIconSize() {
    return switch (size) {
      MovieCardSize.small => 20.sp,
      MovieCardSize.medium => 28.sp,
      MovieCardSize.large => 36.sp,
    };
  }

  int? _getCacheWidth() {
    final cardWidth = _getCardDimensions().width;
    final cacheDimensions = AppStyles.getCacheDimensions(cardWidth);
    return cacheDimensions.width;
  }

  int? _getCacheHeight() {
    final cardWidth = _getCardDimensions().width;
    final cacheDimensions = AppStyles.getCacheDimensions(cardWidth);
    return cacheDimensions.height;
  }

  BorderRadius _getBorderRadius() {
    final sizeString = switch (size) {
      MovieCardSize.small => 'small',
      MovieCardSize.medium => 'medium',
      MovieCardSize.large => 'large',
    };
    return AppStyles.getMovieCardRadius(sizeString);
  }

  List<BoxShadow> _getBoxShadow() {
    final sizeString = switch (size) {
      MovieCardSize.small => 'small',
      MovieCardSize.medium => 'medium',
      MovieCardSize.large => 'large',
    };
    return AppStyles.getMovieCardShadow(sizeString);
  }
}
