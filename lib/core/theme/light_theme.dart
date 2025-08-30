import 'package:flutter/material.dart';
import 'package:movie_verse/core/constants/app_styles.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: AppStyles.appBarTheme,
  bottomNavigationBarTheme: AppStyles.bottomNavigationBarTheme,
  cardTheme: AppStyles.cardTheme,
  tabBarTheme: AppStyles.tabBarTheme,
);