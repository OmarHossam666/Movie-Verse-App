import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_verse/core/constants/app_colors.dart';

class ShimmerGenreChips extends StatelessWidget {
  const ShimmerGenreChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardBackground,
      highlightColor: AppColors.borderLight,
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: List.generate(4, (index) {
          final widths = [60.w, 80.w, 70.w, 90.w];
          return Container(
            width: widths[index],
            height: 28.h,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(14.r),
            ),
          );
        }),
      ),
    );
  }
}
