// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastMember _$CastMemberFromJson(Map<String, dynamic> json) => CastMember(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  character: json['character'] as String,
  profilePath: json['profile_path'] as String?,
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$CastMemberToJson(CastMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.profilePath,
      'order': instance.order,
    };

MovieCredits _$MovieCreditsFromJson(Map<String, dynamic> json) => MovieCredits(
  cast: (json['cast'] as List<dynamic>)
      .map((e) => CastMember.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieCreditsToJson(MovieCredits instance) =>
    <String, dynamic>{'cast': instance.cast};
