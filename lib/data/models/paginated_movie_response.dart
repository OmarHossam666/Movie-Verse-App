import 'package:json_annotation/json_annotation.dart';
import 'package:movie_verse/data/models/movie_model.dart';

part 'paginated_movie_response.g.dart';

@JsonSerializable()
class PaginatedMovieResponse {
  PaginatedMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;

  final List<Movie> results;

  @JsonKey(name: 'total_page')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  factory PaginatedMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedMovieResponseToJson(this);

  bool get hasNextPage => page < totalPages;

  bool get hasPreviousPage => page > 1;
}
