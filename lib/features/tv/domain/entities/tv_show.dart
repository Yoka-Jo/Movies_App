import 'package:equatable/equatable.dart';

class TvShow extends Equatable{
  final int id;
  final String title;
  final String description;
  final String posterImage;
  final num rate;
  final int voteCount;

  const  TvShow({
    required this.id,
    required this.title,
    required this.description,
    required this.posterImage,
    required this.rate,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [id, title, description, posterImage, rate, voteCount];
}
