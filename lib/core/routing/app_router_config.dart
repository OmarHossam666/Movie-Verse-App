import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';
import 'package:movie_verse/core/routing/app_routes.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/presentation/screens/main_screen.dart';
import 'package:movie_verse/presentation/screens/movie_details_screen.dart';
import 'package:movie_verse/presentation/screens/see_all_screen.dart';

class AppRouterConfig {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.mainScreen,
    routes: [
      GoRoute(
        path: AppRoutes.mainScreen,
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.movieDetailsScreen,
        name: 'movieDetails',
        builder: (context, state) {
          final movie = state.extra as Movie;
          return MovieDetailsScreen(movie: movie);
        },
      ),
      GoRoute(
        path: AppRoutes.seeAllScreen,
        name: 'seeAll',
        builder: (context, state) {
          final title = state.extra as String;
          return SeeAllScreen(title: title);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          spacing: 16.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: AppColors.error),
            Text(
              'Page not found: ${state.uri.toString()}',
              style: AppStyles.movieTitle,
            ),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.homeScreen),
              child: Text('Go Home', style: AppStyles.movieSubtitle),
            ),
          ],
        ),
      ),
    ),
  );
}
