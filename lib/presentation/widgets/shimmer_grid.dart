import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/presentation/widgets/shimmer_movie_card.dart';

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key, this.itemCount = 10});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppStyles.largePadding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.67,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ShimmerMovieCard(showDetails: true);
      },
    );
  }
}
