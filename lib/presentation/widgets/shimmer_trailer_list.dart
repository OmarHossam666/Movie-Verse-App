import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';

class ShimmerTrailerList extends StatelessWidget {
  const ShimmerTrailerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 200.w,
            margin: EdgeInsets.only(right: 12.w),
            child: Shimmer.fromColors(
              baseColor: AppColors.cardBackground,
              highlightColor: AppColors.borderLight,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: AppStyles.mediumRadius,
                ),
                child: Column(
                  children: [
                    // Thumbnail shimmer
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.vertical(
                            top: AppStyles.mediumRadius.topLeft,
                          ),
                        ),
                      ),
                    ),
                    // Title shimmer
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 120.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
