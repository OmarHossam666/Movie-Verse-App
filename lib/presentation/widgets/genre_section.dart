import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/genre_model.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';
import 'package:movie_verse/presentation/widgets/genre_chip.dart';
import 'package:movie_verse/presentation/widgets/shimmer_genre_chips.dart';

class GenreSection extends StatelessWidget {
  const GenreSection({
    super.key,
    required this.genres,
    required this.status,
    this.error,
    this.onRetry,
  });

  final List<Genre> genres;
  final MovieStatus status;
  final String? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.horizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Text('Genres', style: AppStyles.sectionHeader),
          SizedBox(height: 12.h),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (status) {
      case MovieStatus.initial:
      case MovieStatus.loading:
        return const ShimmerGenreChips();
      case MovieStatus.success:
        if (genres.isEmpty) {
          return const SizedBox.shrink();
        }
        return Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: genres.map((genre) => GenreChip(genre: genre)).toList(),
        );
      case MovieStatus.failure:
        return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Column(
      children: [
        Text('Failed to load genres', style: AppStyles.bodyText),
        if (onRetry != null) ...[
          SizedBox(height: 8.h),
          TextButton(
            style: AppStyles.genreTagStyle,
            onPressed: onRetry,
            child: Text('Retry', style: AppStyles.genreTagText),
          ),
        ],
      ],
    );
  }
}