import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/presentation/widgets/efficient_shimmer.dart';

class PosterShimmer extends StatelessWidget {
  const PosterShimmer({super.key, this.borderRadius});

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return EfficientShimmer(
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: borderRadius,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main shimmer background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cardBackground,
                    AppColors.borderLight.withValues(alpha: 0.2),
                    AppColors.cardBackground,
                  ],
                ),
                borderRadius: borderRadius,
              ),
            ),

            // Movie icon placeholder
            Icon(
              Icons.movie_outlined,
              size: 28.sp,
              color: AppColors.mutedText.withValues(alpha: 0.4),
            ),

            // Bottom shimmer elements
            Positioned(
              bottom: 12.h,
              left: 8.w,
              right: 8.w,
              child: Column(
                children: [
                  ShimmerBox(
                    height: 6.h,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  SizedBox(height: 4.h),
                  ShimmerBox(
                    height: 6.h,
                    width: 60.w,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
