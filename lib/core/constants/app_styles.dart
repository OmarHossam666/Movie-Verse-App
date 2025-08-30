import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  static const String fontFamily = 'Bebas Neue';

  // Text Styles
  static TextStyle get heroTitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryAccent,
    letterSpacing: 1.2.w,
  );

  static TextStyle get streamTitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.brandRed,
    letterSpacing: 2.0.w,
  );

  static TextStyle get movieTitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 0.5.w,
  );

  static TextStyle get movieTitleLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 0.8.w,
  );

  static TextStyle get sectionHeader => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 1.0.w,
  );

  static TextStyle get continueWatchingLabel => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    letterSpacing: 0.3.w,
  );

  static TextStyle get movieSubtitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.4.w,
  );

  static TextStyle get bodyText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    letterSpacing: 0.2.w,
    height: 1.4.h,
  );

  static TextStyle get detailText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.tertiaryText,
    letterSpacing: 0.1.w,
  );

  static TextStyle get ratingText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    letterSpacing: 0.2.w,
  );

  static TextStyle get durationText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    letterSpacing: 0.1.w,
  );

  static TextStyle get genreTagText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.genreTagText,
    letterSpacing: 0.3.w,
  );

  static TextStyle get tabTextActive => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.activeTab,
    letterSpacing: 0.5.w,
  );

  static TextStyle get tabTextInactive => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.inactiveTab,
    letterSpacing: 0.3.w,
  );

  static TextStyle get searchPlaceholder => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.placeholderText,
    letterSpacing: 0.2.w,
  );

  static TextStyle get searchHeaderText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    letterSpacing: 0.3.w,
    height: 1.3.h,
  );

  static TextStyle get labelText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryText,
    letterSpacing: 0.4.w,
  );

  static TextStyle get valueText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
    letterSpacing: 0.1.w,
  );

  // Button Styles
  static ButtonStyle get playButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.playButton,
    foregroundColor: AppColors.primaryText,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
    textStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3.w,
    ),
  );

  static ButtonStyle get secondaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonBackground,
    foregroundColor: AppColors.primaryText,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    textStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2.w,
    ),
  );

  static ButtonStyle get genreTagStyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.genreTagBackground,
    foregroundColor: AppColors.genreTagText,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    textStyle: genreTagText,
  );

  // Container Styles
  static BoxDecoration get movieCardDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
    boxShadow: [
      BoxShadow(
        color: AppColors.cardShadow,
        blurRadius: 8.r,
        offset: Offset(0, 4.h),
      ),
    ],
  );

  static BoxDecoration get continueWatchingCardDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: AppColors.overlayGradient,
    ),
  );

  static BoxDecoration get searchBarDecoration => BoxDecoration(
    color: AppColors.searchBackground,
    borderRadius: BorderRadius.circular(25.r),
    border: Border.all(color: AppColors.searchBorder, width: 1.w),
  );

  static BoxDecoration get ratingContainerDecoration => BoxDecoration(
    color: AppColors.ratingBackground,
    borderRadius: BorderRadius.circular(8.r),
  );

  static BoxDecoration get overlayDecoration => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: AppColors.overlayGradient,
    ),
  );

  // Input Decoration
  static InputDecoration get searchInputDecoration => InputDecoration(
    hintText: 'Search...',
    hintStyle: searchPlaceholder,
    hoverColor: AppColors.primaryBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.searchBorder),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.searchBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(width: 2.w, color: AppColors.searchBorder),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(width: 1.w, color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(width: 2.w, color: AppColors.error),
    ),
    focusColor: AppColors.searchBorder,
    fillColor: AppColors.searchBackground,
    filled: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
    prefixIcon: Icon(
      Icons.search,
      color: AppColors.placeholderText,
      size: 20.sp,
    ),
  );

  // App Bar Styles
  static AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: AppColors.transparent,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: heroTitle,
    iconTheme: IconThemeData(color: AppColors.primaryText, size: 24.sp),
  );

  // Bottom Navigation Styles
  static BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBackground,
        selectedItemColor: AppColors.navSelected,
        unselectedItemColor: AppColors.navUnselected,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2.w,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.1.w,
        ),
      );

  // Tab Bar Styles
  static TabBarThemeData get tabBarTheme => TabBarThemeData(
    labelColor: AppColors.activeTab,
    unselectedLabelColor: AppColors.inactiveTab,
    labelStyle: tabTextActive,
    unselectedLabelStyle: tabTextInactive,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.activeTab, width: 2.w),
    ),
  );

  // Card Styles
  static CardThemeData get cardTheme => CardThemeData(
    color: AppColors.cardBackground,
    elevation: 4.h,
    shadowColor: AppColors.cardShadow,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  );

  // Spacing and Sizing
  static EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsets get allPadding => EdgeInsets.all(16.r);
  static EdgeInsets get smallPadding => EdgeInsets.all(8.r);
  static EdgeInsets get largePadding => EdgeInsets.all(24.r);

  static SizedBox get verticalSpaceSmall => SizedBox(height: 8.h);
  static SizedBox get verticalSpaceMedium => SizedBox(height: 16.h);
  static SizedBox get verticalSpaceLarge => SizedBox(height: 24.h);
  static SizedBox get verticalSpaceXLarge => SizedBox(height: 32.h);

  static SizedBox get horizontalSpaceSmall => SizedBox(width: 8.w);
  static SizedBox get horizontalSpaceMedium => SizedBox(width: 16.w);
  static SizedBox get horizontalSpaceLarge => SizedBox(width: 24.w);

  // Border Radius
  static BorderRadius get smallRadius => BorderRadius.circular(8.r);
  static BorderRadius get mediumRadius => BorderRadius.circular(12.r);
  static BorderRadius get largeRadius => BorderRadius.circular(16.r);
  static BorderRadius get xLargeRadius => BorderRadius.circular(20.r);
  static BorderRadius get circularRadius => BorderRadius.circular(25.r);

  // Icon Sizes
  static double get iconSmall => 16.sp;
  static double get iconMedium => 20.sp;
  static double get iconLarge => 24.sp;
  static double get iconXLarge => 32.sp;

  // Movie Card Dimensions
  static double get movieCardLargeWidth => 260.w;
  static double get movieCardLargeHeight => 340.h;
  static double get movieCardMediumWidth => 155.w;
  static double get movieCardMediumHeight => 185.h;
  static double get movieCardSmallWidth => 150.w;
  static double get movieCardSmallHeight => 160.h;

  // Continue Watching Card
  static double get continueWatchingHeight => 200.h;
  static EdgeInsets get continueWatchingPadding => EdgeInsets.all(16.r);

  // Search Bar
  static double get searchBarHeight => 48.h;
  static EdgeInsets get searchBarPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);

  // Rating Container
  static EdgeInsets get ratingPadding =>
      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h);

  // Tab Bar
  static double get tabBarHeight => 48.h;
  static EdgeInsets get tabPadding => EdgeInsets.symmetric(horizontal: 16.w);

  // Navigation Bar
  static double get navigationBarHeight => 84.h;
  static EdgeInsets get navigationBarPadding =>
      EdgeInsets.symmetric(vertical: 8.h);
}
