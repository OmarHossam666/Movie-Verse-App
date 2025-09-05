import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_verse/core/constants/app_colors.dart';

class ShimmerCastList extends StatelessWidget {
  const ShimmerCastList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 100.w,
            margin: EdgeInsets.only(right: 12.w),
            child: Shimmer.fromColors(
              baseColor: AppColors.cardBackground,
              highlightColor: AppColors.borderLight,
              child: Column(
                children: [
                  // Profile shimmer
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Name shimmer
                  Container(
                    width: 80.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Character shimmer
                  Container(
                    width: 60.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
