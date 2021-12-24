import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/usecases/get_latest_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movies_by_search_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  static MovieBloc of(BuildContext context) => BlocProvider.of(context);

  final GetLatestMoviesUseCase getLatestMoviesUseCase;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMovieUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetMoviesBySearchUseCase getMoviesBySearchUseCase;

  MovieBloc({
    required this.getLatestMoviesUseCase,
    required this.getMovieDetailsUseCase,
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMovieUseCase,
    required this.getUpcomingMoviesUseCase,
    required this.getNowPlayingMoviesUseCase,
    required this.getMoviesBySearchUseCase,
  }) : super(MovieInitial()) {
    on<GetMainScreenMoviesEvent>((event, emit) {
      emit(LoadedMoviesState());
    });

    on<GetLatestMoviesEvent>((event, emit) async {
      await _getMovies(emit, getLatestMoviesUseCase);
    });

    on<GetPopularMoviesEvent>((event, emit) async {
      popularMovies = [];
      await _getMovies(emit, getPopularMoviesUseCase);
    });
    on<GetTopRatedMoviesEvent>((event, emit) async {
      await _getMovies(emit, getTopRatedMovieUseCase);
    });

    on<GetUpcomingMoviesEvent>((event, emit) async {
      await _getMovies(emit, getUpcomingMoviesUseCase);
    });

    on<GetNowPlayingMoviesEvent>((event, emit) async {
      nowPlayingMovies = [];
      await _getMovies(emit, getNowPlayingMoviesUseCase);
    });

    on<GetMovieBySearchEvent>((event, emit) async {
      await _getMovies(emit, getMoviesBySearchUseCase, search: event.query);
    });

    on<GetMovieDetailsEvent>((event, emit) async {
      emit(LoadingMoviesState());
      final failureOrMovies = await getMovieDetailsUseCase(Params(event.id));
      failureOrMovies.fold((left) => emit(ErrorMoviesState("Server Failure")),
          (movie) {
        movieDetails = movie;
        emit(LoadedMoviesState());
      });
    });
    on<ClearSearchedListEvent>((event, emit) {
      filteredMovies = [];
      emit(ClearSearchedListState());
    });
  }

  Movie? movieDetails;
  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> filteredMovies = [];

  Future<void> _getMovies(Emitter<MovieState> emit, UseCase usecase,
      {String? search}) async {
    emit(LoadingMoviesState());
    late final Either<Failure, dynamic> failureOrMovies;
    if (usecase is GetMoviesBySearchUseCase) {
      failureOrMovies = await usecase(search!);
    } else {
      failureOrMovies = await usecase(NoParams());
    }
    failureOrMovies.fold((left) => emit(ErrorMoviesState("Server Failure")),
        (movies) {
      switch (usecase.runtimeType) {
        case GetNowPlayingMoviesUseCase:
          nowPlayingMovies = movies;
          break;
        case GetPopularMoviesUseCase:
          popularMovies = movies;
          break;
        case GetLatestMoviesUseCase:
          filteredMovies = movies;
          break;
        case GetTopRatedMoviesUseCase:
          filteredMovies = movies;
          break;
        case GetUpcomingMoviesUseCase:
          filteredMovies = movies;
          break;
        case GetMoviesBySearchUseCase:
          filteredMovies = movies;
          break;
      }
    });

    if ((usecase is GetPopularMoviesUseCase ||
            usecase is GetNowPlayingMoviesUseCase) &&
        nowPlayingMovies.isNotEmpty &&
        popularMovies.isNotEmpty) {
      emit(LoadedMoviesState());
    } else if (usecase is! GetPopularMoviesUseCase &&
        usecase is! GetNowPlayingMoviesUseCase) {
      emit(LoadedFilteredMoviesState());
    }
  }
}
