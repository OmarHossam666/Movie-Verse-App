import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_verse/core/constants/app_assets.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/presentation/screens/discover_screen.dart';
import 'package:movie_verse/presentation/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final items = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(AppAssets.homeIcon, width: 30.w, height: 30.h),
        activeIcon: SvgPicture.asset(
          AppAssets.activeHomeIcon,
          width: 30.w,
          height: 30.h,
        ),
        label: AppStrings.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AppAssets.discoverIcon,
          width: 30.w,
          height: 30.h,
        ),
        activeIcon: SvgPicture.asset(
          AppAssets.activeDiscoverIcon,
          width: 30.w,
          height: 30.h,
        ),
        label: AppStrings.discover,
      ),
    ];

    final screens = [const HomeScreen(), const DiscoverScreen()];

    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
