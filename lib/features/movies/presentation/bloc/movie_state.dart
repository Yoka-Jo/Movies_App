part of 'movie_bloc.dart';

@immutable
abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class LoadingMoviesState extends MovieState {}

class LoadedMoviesState extends MovieState {}

class LoadedFilteredMoviesState extends MovieState {}

class ErrorMoviesState extends MovieState {
  final String message;

  ErrorMoviesState(this.message);
  @override
  List<Object?> get props => [message];
}

class ClearSearchedListState extends MovieState {}
