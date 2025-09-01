// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedMovieResponse _$PaginatedMovieResponseFromJson(
  Map<String, dynamic> json,
) => PaginatedMovieResponse(
  page: (json['page'] as num).toInt(),
  results: (json['results'] as List<dynamic>)
      .map((e) => Movie.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: (json['total_page'] as num).toInt(),
  totalResults: (json['total_results'] as num).toInt(),
);

Map<String, dynamic> _$PaginatedMovieResponseToJson(
  PaginatedMovieResponse instance,
) => <String, dynamic>{
  'page': instance.page,
  'results': instance.results,
  'total_page': instance.totalPages,
  'total_results': instance.totalResults,
};
