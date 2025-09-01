import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_verse/core/constants/app_colors.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/data/datasources/tmdb_api_service.dart';
import 'package:movie_verse/data/repositories/movie_repository.dart';
import 'package:movie_verse/presentation/bloc/movie_bloc.dart';
import 'package:movie_verse/presentation/bloc/movie_event.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';
import 'package:movie_verse/presentation/widgets/movie_card.dart';
import 'package:movie_verse/presentation/widgets/movie_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieBloc(movieRepository: MovieRepository(TMDBApiService()))
            ..add(const LoadAllMovies()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.home), centerTitle: true),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.primaryAccent,
            backgroundColor: AppColors.primaryBackground,
            onRefresh: () async {
              context.read<MovieBloc>().add(const RefreshAllMovies());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Now Playing Section
                  MovieSection(
                    title: AppStrings.nowPlaying,
                    movies: state.nowPlayingMovies,
                    status: state.nowPlayingStatus,
                    error: state.nowPlayingError,
                    onRetry: () => context.read<MovieBloc>().add(
                      const LoadNowPlayingMovies(),
                    ),
                    size: MovieCardSize.large,
                  ),

                  // Popular Section
                  MovieSection(
                    title: AppStrings.popular,
                    movies: state.popularMovies,
                    status: state.popularStatus,
                    error: state.popularError,
                    onRetry: () => context.read<MovieBloc>().add(
                      const LoadPopularMovies(),
                    ),
                    size: MovieCardSize.medium,
                  ),

                  // Top Rated Section
                  MovieSection(
                    title: AppStrings.topRated,
                    movies: state.topRatedMovies,
                    status: state.topRatedStatus,
                    error: state.topRatedError,
                    onRetry: () => context.read<MovieBloc>().add(
                      const LoadTopRatedMovies(),
                    ),
                    size: MovieCardSize.small,
                  ),

                  // Upcoming Section
                  MovieSection(
                    title: AppStrings.upcoming,
                    movies: state.upcomingMovies,
                    status: state.upcomingStatus,
                    error: state.upcomingError,
                    onRetry: () => context.read<MovieBloc>().add(
                      const LoadUpcomingMovies(),
                    ),
                    size: MovieCardSize.medium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
