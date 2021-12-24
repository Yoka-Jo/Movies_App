import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

abstract class MoviesAppRepository {
  Future<Either<Failure,List<Movie>>> getLatestMovies();
  Future<Either<Failure,List<Movie>>> getPopularMovies();
  Future<Either<Failure,List<Movie>>> getTopRatedMovies();
  Future<Either<Failure,List<Movie>>> getUpcomingMovies();
  Future<Either<Failure,List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure,List<Movie>>> getMoviesBySearch(String query);
  Future<Either<Failure,Movie>> getMovieDetails(int id );
}