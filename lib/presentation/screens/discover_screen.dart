import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/core/constants/app_styles.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.discover), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: AppStyles.largePadding,
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.findMoviesTvSeriesAndMore,
                    style: AppStyles.movieTitleLarge,
                  ),
                  TextField(
                    decoration: AppStyles.searchInputDecoration,
                    cursorColor: AppColors.primaryAccent,
                    cursorErrorColor: AppColors.error,
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: AppStrings.all),
                Tab(text: AppStrings.movies),
                Tab(text: AppStrings.tvShows),
                Tab(text: AppStrings.people),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAllTab(),
                  _buildMoviesTab(),
                  _buildTvShowsTab(),
                  _buildPeopleTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllTab() {
    return Center(child: Text('All Content', style: AppStyles.movieTitleLarge));
  }

  Widget _buildMoviesTab() {
    return Center(child: Text('Movies', style: AppStyles.movieTitleLarge));
  }

  Widget _buildTvShowsTab() {
    return Center(child: Text('TV Shows', style: AppStyles.movieTitleLarge));
  }

  Widget _buildPeopleTab() {
    return Center(child: Text('People', style: AppStyles.movieTitleLarge));
  }
}
