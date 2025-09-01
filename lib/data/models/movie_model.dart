import 'package:json_annotation/json_annotation.dart';
import 'package:movie_verse/data/datasources/tmdb_config.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class Movie {
  Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.voteAverage,
    required this.voteCount,
    this.popularity,
    required this.genreIds,
    required this.isAdult,
    required this.originalLanguage,
    required this.originalTitle,
    required this.hasVideo,
  });

  final int id;
  final String title;
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  final double? popularity;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  @JsonKey(name: 'adult')
  final bool isAdult;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  @JsonKey(name: 'video')
  final bool hasVideo;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String? getPosterUrl(String size) =>
      posterPath != null ? '${TMDBConfig.imageBaseUrl}$size$posterPath' : null;

  String? getBackdropUrl(String size) => backdropPath != null
      ? '${TMDBConfig.imageBaseUrl}$size$backdropPath'
      : null;
}
