import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_assets.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/core/constants/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.home), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppStyles.largePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24.h,
              children: [
                Text(AppStrings.nowPlaying, style: AppStyles.sectionHeader),
                Container(
                  width: AppStyles.movieCardLargeWidth,
                  height: AppStyles.movieCardLargeHeight,
                  decoration: AppStyles.movieCardDecoration,
                  child: Image.asset(AppAssets.moviePoster, fit: BoxFit.fill),
                ),
                Text(AppStrings.popular, style: AppStyles.sectionHeader),
                Container(
                  width: AppStyles.movieCardMediumWidth,
                  height: AppStyles.movieCardMediumHeight,
                  decoration: AppStyles.movieCardDecoration,
                  child: Image.asset(
                    AppAssets.moviePoster,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(AppStrings.topRated, style: AppStyles.sectionHeader),
                Container(
                  width: AppStyles.movieCardSmallWidth,
                  height: AppStyles.movieCardSmallHeight,
                  decoration: AppStyles.movieCardDecoration,
                  child: Image.asset(
                    AppAssets.moviePoster,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(AppStrings.upcoming, style: AppStyles.sectionHeader),
                Container(
                  width: AppStyles.movieCardMediumWidth,
                  height: AppStyles.movieCardMediumHeight,
                  decoration: AppStyles.movieCardDecoration,
                  child: Image.asset(
                    AppAssets.moviePoster,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
