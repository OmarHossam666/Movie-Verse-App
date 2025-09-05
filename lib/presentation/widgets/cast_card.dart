import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/datasources/tmdb_config.dart';
import 'package:movie_verse/data/models/cast_model.dart';

class CastCard extends StatelessWidget {
  const CastCard({super.key, required this.castMember});

  final CastMember castMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Column(
        spacing: 6.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          Expanded(
            flex: 3,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cardBackground,
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      castMember.getProfileUrl(TMDBConfig.profileMedium) ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.cardBackground,
                    child: Icon(
                      Icons.person,
                      size: 32.sp,
                      color: AppColors.mutedText,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.cardBackground,
                    child: Icon(
                      Icons.person,
                      size: 32.sp,
                      color: AppColors.mutedText,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Actor Name
          Expanded(
            flex: 1,
            child: Text(
              castMember.name,
              style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Character Name
          Expanded(
            flex: 1,
            child: Text(
              castMember.character,
              style: AppStyles.detailText,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
