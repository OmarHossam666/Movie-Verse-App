import 'package:json_annotation/json_annotation.dart';
import 'package:movie_verse/data/datasources/tmdb_config.dart';

part 'cast_model.g.dart';

@JsonSerializable()
class CastMember {
  CastMember({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
    this.order,
  });

  final int id;
  final String name;
  final String character;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  final int? order;

  factory CastMember.fromJson(Map<String, dynamic> json) =>
      _$CastMemberFromJson(json);
  Map<String, dynamic> toJson() => _$CastMemberToJson(this);

  String? getProfileUrl(String size) => profilePath != null
      ? '${TMDBConfig.imageBaseUrl}$size$profilePath'
      : null;
}

@JsonSerializable()
class MovieCredits {
  MovieCredits({required this.cast});

  final List<CastMember> cast;

  factory MovieCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieCreditsToJson(this);
}
