import 'package:equatable/equatable.dart';
import 'package:movie_verse/data/models/movie_model.dart';
import 'package:movie_verse/data/models/cast_model.dart';
import 'package:movie_verse/data/models/video_model.dart';
import 'package:movie_verse/presentation/bloc/movie_state.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState({
    this.detailsStatus = MovieStatus.initial,
    this.creditsStatus = MovieStatus.initial,
    this.videosStatus = MovieStatus.initial,
    this.movieDetails,
    this.movieCredits,
    this.movieVideos,
    this.detailsError,
    this.creditsError,
    this.videosError,
  });

  final MovieStatus detailsStatus;
  final MovieStatus creditsStatus;
  final MovieStatus videosStatus;

  final Movie? movieDetails;
  final MovieCredits? movieCredits;
  final MovieVideos? movieVideos;

  final String? detailsError;
  final String? creditsError;
  final String? videosError;

  MovieDetailsState copyWith({
    MovieStatus? detailsStatus,
    MovieStatus? creditsStatus,
    MovieStatus? videosStatus,
    Movie? movieDetails,
    MovieCredits? movieCredits,
    MovieVideos? movieVideos,
    String? detailsError,
    String? creditsError,
    String? videosError,
  }) {
    return MovieDetailsState(
      detailsStatus: detailsStatus ?? this.detailsStatus,
      creditsStatus: creditsStatus ?? this.creditsStatus,
      videosStatus: videosStatus ?? this.videosStatus,
      movieDetails: movieDetails ?? this.movieDetails,
      movieCredits: movieCredits ?? this.movieCredits,
      movieVideos: movieVideos ?? this.movieVideos,
      detailsError: detailsError,
      creditsError: creditsError,
      videosError: videosError,
    );
  }

  @override
  List<Object?> get props => [
    detailsStatus,
    creditsStatus,
    videosStatus,
    movieDetails,
    movieCredits,
    movieVideos,
    detailsError,
    creditsError,
    videosError,
  ];
}
