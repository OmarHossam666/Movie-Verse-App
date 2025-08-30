import 'package:flutter/material.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_styles.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.primaryBackground,
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: AppStyles.appBarTheme,
  bottomNavigationBarTheme: AppStyles.bottomNavigationBarTheme,
  cardTheme: AppStyles.cardTheme,
  tabBarTheme: AppStyles.tabBarTheme,
);
