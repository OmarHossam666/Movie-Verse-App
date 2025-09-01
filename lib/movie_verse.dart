import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/routing/app_router_config.dart';
import 'package:movie_verse/core/theme/dark_theme.dart';
import 'package:movie_verse/core/theme/light_theme.dart';

class MovieVerse extends StatelessWidget {
  const MovieVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouterConfig.router,
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
