import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required int id,
    required String title,
    required String description,
    required String posterImage,
    required String releaseDate,
    required num rate,
    required int voteCount,
  }) : super(
          id: id,
          description: description,
          posterImage: posterImage,
          rate: rate,
          releaseDate: releaseDate,
          title: title,
          voteCount: voteCount,
        );

  factory MovieModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ServerExceptoin();
    }
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['overview'] ?? '',
      posterImage: json['poster_path'] == null
          ? NO_IMAGE_PROVIDED
          : PATH_TO_GET_IMAGES + json['poster_path'],
      releaseDate: json['release_date'] ?? '',
      rate: json['vote_average'] ?? '',
      voteCount: json['vote_count'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "overview": description,
      "poster_path": posterImage,
      "release_date": releaseDate,
      "title": title,
      "vote_average": rate,
      "vote_count": voteCount
    };
  }
}
