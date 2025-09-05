import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/genre_model.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({super.key, required this.genre});

  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent.withValues(alpha: 0.1),
        borderRadius: AppStyles.smallRadius,
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Text(
        genre.name,
        style: AppStyles.bodyText.copyWith(color: AppColors.primaryAccent),
      ),
    );
  }
}
