import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/cast_model.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';
import 'package:movie_verse/presentation/widgets/cast_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_cast_list.dart';

class CastSection extends StatelessWidget {
  const CastSection({
    super.key,
    required this.cast,
    required this.status,
    this.error,
    this.onRetry,
  });

  final List<CastMember> cast;
  final MovieStatus status;
  final String? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppStyles.horizontalPadding,
            child: Text('Cast', style: AppStyles.sectionHeader),
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
        return const ShimmerCastList();
      case MovieStatus.success:
        if (cast.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: 140.h,
          child: ListView.builder(
            padding: AppStyles.horizontalPadding,
            scrollDirection: Axis.horizontal,
            itemCount: cast.take(10).length,
            itemBuilder: (context, index) {
              return CastCard(castMember: cast[index]);
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
          Text('Failed to load cast', style: AppStyles.bodyText),
          if (onRetry != null) ...[
            SizedBox(height: 8.h),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
