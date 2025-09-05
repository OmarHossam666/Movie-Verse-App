// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
  id: json['id'] as String,
  key: json['key'] as String,
  name: json['name'] as String,
  site: json['site'] as String,
  type: json['type'] as String,
  official: json['official'] as bool?,
  publishedAt: json['published_at'] as String?,
);

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
  'name': instance.name,
  'site': instance.site,
  'type': instance.type,
  'official': instance.official,
  'published_at': instance.publishedAt,
};

MovieVideos _$MovieVideosFromJson(Map<String, dynamic> json) => MovieVideos(
  results: (json['results'] as List<dynamic>)
      .map((e) => Video.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieVideosToJson(MovieVideos instance) =>
    <String, dynamic>{'results': instance.results};
