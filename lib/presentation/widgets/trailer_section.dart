import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/video_model.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';
import 'package:movie_verse/presentation/widgets/trailer_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_trailer_list.dart';

class TrailerSection extends StatelessWidget {
  const TrailerSection({
    super.key,
    required this.videos,
    required this.status,
    this.error,
    this.onRetry,
  });

  final List<Video> videos;
  final MovieStatus status;
  final String? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppStyles.horizontalPadding,
            child: Text('Trailers', style: AppStyles.sectionHeader),
          ),
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
        return const ShimmerTrailerList();
      case MovieStatus.success:
        final trailers = videos.where((video) => video.isTrailer).toList();
        if (trailers.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: 140.h,
          child: ListView.builder(
            padding: AppStyles.horizontalPadding,
            scrollDirection: Axis.horizontal,
            itemCount: trailers.take(5).length,
            itemBuilder: (context, index) {
              return TrailerCard(video: trailers[index]);
            },
          ),
        );
      case MovieStatus.failure:
        return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Padding(
      padding: AppStyles.horizontalPadding,
      child: Column(
        children: [
          Text('Failed to load trailers', style: AppStyles.bodyText),
          if (onRetry != null) ...[
            SizedBox(height: 8.h),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
