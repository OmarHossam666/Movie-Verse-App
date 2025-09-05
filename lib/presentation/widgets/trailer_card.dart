import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_verse/core/constants/app_assets.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/data/models/video_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerCard extends StatelessWidget {
  const TrailerCard({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppStyles.mediumRadius,
          onTap: () => _launchTrailer(),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: AppStyles.mediumRadius,
              boxShadow: AppStyles.getMovieCardShadow('medium'),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: AppStyles.mediumRadius.topLeft,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: video.getYouTubeThumbnailUrl() ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.cardBackground,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryAccent,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.cardBackground,
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 48.sp,
                              color: AppColors.mutedText,
                            ),
                          ),
                        ),

                        // Play button overlay
                        Center(
                          child: SvgPicture.asset(AppAssets.playButtonIcon),
                        ),
                      ],
                    ),
                  ),
                ),

                // Video Info
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          video.name,
                          style: AppStyles.bodyText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchTrailer() async {
    final url = video.getYouTubeUrl();
    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    }
  }
}
