import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';

class ShimmerMovieCard extends StatelessWidget {
  const ShimmerMovieCard({
    super.key,
    this.width,
    this.height,
    this.showDetails = true,
    this.size = MovieCardSize.medium,
  });

  final double? width;
  final double? height;
  final bool showDetails;
  final MovieCardSize size;

  @override
  Widget build(BuildContext context) {
    final cardDimensions = _getCardDimensions();

    return Container(
      width: width ?? cardDimensions.width,
      height: height ?? cardDimensions.height,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: _getBorderRadius(),
        boxShadow: _getBoxShadow(),
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.cardBackground,
        highlightColor: AppColors.borderLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster shimmer
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                ),
              ),
            ),

            if (showDetails) ...[
              // Details shimmer
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title shimmer
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 0.7.sw,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ],
                      ),

                      // Rating and year shimmer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Container(
                            width: 30.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

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
