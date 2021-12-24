import 'package:movie_app/core/constants.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';

class TvShowModel extends TvShow {
  const TvShowModel({
    required int id,
    required String title,
    required String description,
    required String posterImage,
    required num rate,
    required int voteCount,
  }) : super(
          id: id,
          description: description,
          posterImage: posterImage,
          rate: rate,
          title: title,
          voteCount: voteCount,
        );

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
        id: json['id'] ?? 0,
        title: json['name'] ?? '',
        description: json['overview'] ?? '',
        posterImage: json['poster_path'] == null
            ? NO_IMAGE_PROVIDED
            : PATH_TO_GET_IMAGES + json['poster_path'],
        rate: json['vote_average'] ?? '',
        voteCount: json['vote_count'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "overview": description,
      "poster_path": posterImage,
      "title": title,
      "vote_average": rate,
      "vote_count": voteCount
    };
  }
}
