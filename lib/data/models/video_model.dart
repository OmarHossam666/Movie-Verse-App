import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class Video {
  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    this.official,
    this.publishedAt,
  });

  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final bool? official;

  @JsonKey(name: 'published_at')
  final String? publishedAt;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);

  String? getYouTubeUrl() {
    if (site.toLowerCase() == 'youtube') {
      return 'https://www.youtube.com/watch?v=$key';
    }
    return null;
  }

  String? getYouTubeThumbnailUrl() {
    if (site.toLowerCase() == 'youtube') {
      return 'https://img.youtube.com/vi/$key/hqdefault.jpg';
    }
    return null;
  }

  bool get isTrailer => type.toLowerCase() == 'trailer';
}

@JsonSerializable()
class MovieVideos {
  MovieVideos({required this.results});

  final List<Video> results;

  factory MovieVideos.fromJson(Map<String, dynamic> json) =>
      _$MovieVideosFromJson(json);
  Map<String, dynamic> toJson() => _$MovieVideosToJson(this);

  List<Video> get trailers =>
      results.where((video) => video.isTrailer).toList();
}
