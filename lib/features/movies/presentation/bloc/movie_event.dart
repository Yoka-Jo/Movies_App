part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMainScreenMoviesEvent extends MovieEvent {}

class GetLatestMoviesEvent extends MovieEvent {}

class GetPopularMoviesEvent extends MovieEvent {}

class GetTopRatedMoviesEvent extends MovieEvent {}

class GetUpcomingMoviesEvent extends MovieEvent {}

class GetNowPlayingMoviesEvent extends MovieEvent {}

class GetMovieBySearchEvent extends MovieEvent {
  final String query;

  GetMovieBySearchEvent({required this.query});
  @override
  List<Object?> get props => [query];
}

class GetMovieDetailsEvent extends MovieEvent {
  final int id;

  GetMovieDetailsEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ClearSearchedListEvent extends MovieEvent {}
