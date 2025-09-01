import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';
import 'package:movie_verse/presentation/widgets/shimmer_movie_card.dart';

class ShimmerMovieList extends StatelessWidget {
  const ShimmerMovieList({
    super.key,
    this.cardWidth,
    this.cardHeight,
    this.showDetails = true,
    this.itemCount = 5,
    this.size = MovieCardSize.medium,
    this.scrollDirection = Axis.horizontal,
  });

  final double? cardWidth;
  final double? cardHeight;
  final bool showDetails;
  final int itemCount;
  final MovieCardSize size;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    if (scrollDirection == Axis.vertical) {
      return GridView.builder(
        padding: AppStyles.allPadding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ShimmerMovieCard(showDetails: showDetails, size: size);
        },
      );
    }

    return SizedBox(
      height: cardHeight ?? _getDefaultHeight(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ShimmerMovieCard(
            width: cardWidth ?? _getDefaultWidth(),
            height: cardHeight ?? _getDefaultHeight(),
            showDetails: showDetails,
            size: size,
          );
        },
      ),
    );
  }

  double _getDefaultWidth() {
    return switch (size) {
      MovieCardSize.small => 150.w,
      MovieCardSize.medium => 200.w,
      MovieCardSize.large => 250.w,
    };
  }

  double _getDefaultHeight() {
    return switch (size) {
      MovieCardSize.small => showDetails ? 200.h : 140.h,
      MovieCardSize.medium => showDetails ? 300.h : 210.h,
      MovieCardSize.large => showDetails ? 400.h : 280.h,
    };
  }
}
