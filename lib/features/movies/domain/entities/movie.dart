import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int id;
  final String title;
  final String description;
  final String posterImage;
  final String releaseDate;
  final num rate;
  final int voteCount;

  const  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterImage,
    required this.releaseDate,
    required this.rate,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [id, title, description, posterImage, releaseDate, rate, voteCount];
}
