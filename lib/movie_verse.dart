import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/theme/dark_theme.dart';
import 'package:movie_verse/core/theme/light_theme.dart';
import 'package:movie_verse/presentation/screens/main_screen.dart';

class MovieVerse extends StatelessWidget {
  const MovieVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) => MaterialApp(
        home: const MainScreen(),
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
