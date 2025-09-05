import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/datasources/tmdb_config.dart';
import 'package:movie_verse/data/datasources/tmdb_api_service.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/presentation/bloc/movie_details_bloc.dart';
import 'package:movie_verse/presentation/bloc/movie_details_event.dart';
import 'package:movie_verse/presentation/bloc/movie_details_state.dart';
import 'package:movie_verse/presentation/widgets/poster_shimmer.dart';
import 'package:movie_verse/presentation/widgets/genre_section.dart';
import 'package:movie_verse/presentation/widgets/cast_section.dart';
import 'package:movie_verse/presentation/widgets/trailer_section.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieDetailsBloc(movieRepository: MovieRepository(TMDBApiService()))
            ..add(LoadAllMovieDetails(movie.id)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // App Bar with Backdrop
            _buildSliverAppBar(context),

            // Movie Content
            SliverToBoxAdapter(
              child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                builder: (context, state) {
                  final detailedMovie = state.movieDetails ?? movie;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Header Section
                      _buildMovieHeader(context, detailedMovie),

                      // Movie Details Section
                      _buildMovieDetails(context, detailedMovie),

                      // Genres Section
                      Builder(
                        builder: (context) {
                          return GenreSection(
                            genres: state.movieDetails?.genres ?? [],
                            status: state.detailsStatus,
                            error: state.detailsError,
                            onRetry: () => context.read<MovieDetailsBloc>().add(
                              LoadMovieDetails(movie.id),
                            ),
                          );
                        },
                      ),

                      // Overview Section
                      _buildOverviewSection(context, detailedMovie),

                      // Trailers Section
                      TrailerSection(
                        videos: state.movieVideos?.results ?? [],
                        status: state.videosStatus,
                        error: state.videosError,
                        onRetry: () => context.read<MovieDetailsBloc>().add(
                          LoadMovieVideos(movie.id),
                        ),
                      ),

                      // Cast Section
                      CastSection(
                        cast: state.movieCredits?.cast ?? [],
                        status: state.creditsStatus,
                        error: state.creditsError,
                        onRetry: () => context.read<MovieDetailsBloc>().add(
                          LoadMovieCredits(movie.id),
                        ),
                      ),

                      // Additional Info Section
                      _buildAdditionalInfoSection(context, detailedMovie),

                      // Bottom Padding
                      SizedBox(height: 32.h),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: AppColors.primaryBackground,
      leading: IconButton(
        icon: Container(
          padding: AppStyles.smallPadding,
          decoration: BoxDecoration(
            color: AppColors.overlayBackground,
            borderRadius: AppStyles.xLargeRadius,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryText,
            size: AppStyles.iconLarge,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: AppStyles.smallPadding,
            decoration: BoxDecoration(
              color: AppColors.overlayBackground,
              borderRadius: AppStyles.xLargeRadius,
            ),
            child: Icon(
              Icons.favorite_border,
              color: AppColors.primaryText,
              size: AppStyles.iconLarge,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(width: 16.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Backdrop Image
            CachedNetworkImage(
              imageUrl: movie.getBackdropUrl(TMDBConfig.backdropLarge) ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.cardBackground,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryAccent,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.cardBackground,
                child: Center(
                  child: Icon(
                    Icons.movie_outlined,
                    size: 64.sp,
                    color: AppColors.mutedText,
                  ),
                ),
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.primaryBackground.withValues(alpha: 0.7),
                    AppColors.primaryBackground,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieHeader(BuildContext context, Movie movie) {
    return Padding(
      padding: AppStyles.horizontalPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          Container(
            width: 120.w,
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: AppStyles.mediumRadius,
              boxShadow: AppStyles.getMovieCardShadow('medium'),
            ),
            child: ClipRRect(
              borderRadius: AppStyles.mediumRadius,
              child: CachedNetworkImage(
                imageUrl: movie.getPosterUrl(TMDBConfig.posterMedium) ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    PosterShimmer(borderRadius: AppStyles.mediumRadius),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.cardBackground,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: AppStyles.iconXLarge,
                    color: AppColors.mutedText,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 16.w),

          // Movie Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  movie.title,
                  style: AppStyles.movieTitleLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8.h),

                // Original Title (if different)
                if (movie.originalTitle != movie.title) ...[
                  Text(
                    movie.originalTitle,
                    style: AppStyles.movieSubtitle.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                ],

                // Rating and Release Date
                Row(
                  children: [
                    // Rating
                    if (movie.voteAverage != null &&
                        movie.voteAverage! > 0) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.ratingBackground,
                          borderRadius: AppStyles.smallRadius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: AppStyles.iconLarge,
                              color: AppColors.ratingYellow,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              movie.voteAverage!.toStringAsFixed(1),
                              style: AppStyles.ratingText,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],

                    // Release Date
                    if (movie.releaseDate != null &&
                        movie.releaseDate!.isNotEmpty)
                      Text(
                        movie.releaseDate!.split('-')[0],
                        style: AppStyles.bodyText,
                      ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Vote Count
                if (movie.voteCount > 0)
                  Text('${movie.voteCount} votes', style: AppStyles.detailText),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context, Movie movie) {
    return Padding(
      padding: AppStyles.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),

          // Quick Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Popularity',
                movie.popularity?.toStringAsFixed(0) ?? 'N/A',
                Icons.trending_up,
              ),
              _buildStatItem(
                'Language',
                movie.originalLanguage.toUpperCase(),
                Icons.language,
              ),
              _buildStatItem(
                'Adult',
                movie.isAdult ? 'Yes' : 'No',
                movie.isAdult ? Icons.warning : Icons.check_circle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: AppStyles.allPadding,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: AppStyles.mediumRadius,
          ),
          child: Icon(
            icon,
            size: AppStyles.iconXLarge,
            color: AppColors.primaryAccent,
          ),
        ),
        SizedBox(height: 8.h),
        Text(value, style: AppStyles.valueText),
        Text(label, style: AppStyles.labelText),
      ],
    );
  }

  Widget _buildOverviewSection(BuildContext context, Movie movie) {
    if (movie.overview == null || movie.overview!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: AppStyles.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Text('Overview', style: AppStyles.sectionHeader),
          SizedBox(height: 12.h),
          Text(
            movie.overview!,
            style: AppStyles.bodyText.copyWith(height: 1.6.h),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection(BuildContext context, Movie movie) {
    return Padding(
      padding: AppStyles.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Text('Additional Information', style: AppStyles.sectionHeader),
          SizedBox(height: 16.h),

          // Info Cards
          _buildInfoCard(
            'Original Language',
            movie.originalLanguage.toUpperCase(),
          ),
          _buildInfoCard('Original Title', movie.originalTitle),
          if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty)
            _buildInfoCard('Release Date', _formatDate(movie.releaseDate!)),
          if (movie.popularity != null)
            _buildInfoCard(
              'Popularity Score',
              movie.popularity!.toStringAsFixed(2),
            ),
          if (movie.voteAverage != null)
            _buildInfoCard(
              'Average Rating',
              '${movie.voteAverage!.toStringAsFixed(1)}/10',
            ),
          _buildInfoCard('Total Votes', movie.voteCount.toString()),
          _buildInfoCard('Adult Content', movie.isAdult ? 'Yes' : 'No'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppStyles.mediumRadius,
        border: Border.all(
          color: AppColors.borderLight.withValues(alpha: 0.1),
          width: 1.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(label, style: AppStyles.labelText)),
          SizedBox(width: 16.w),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.valueText,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
