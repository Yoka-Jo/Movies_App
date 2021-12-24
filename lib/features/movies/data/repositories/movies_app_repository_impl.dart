import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/movies/domain/repositories/movies_app_repository.dart';

// ignore: prefer_generic_function_type_aliases
typedef Future<List<Movie>> _WhichMoviesToGet();

class MoviesAppRepositoryImpl extends MoviesAppRepository {
  final MoviesRemoteDataSource moviesRemoteDataSource;

  MoviesAppRepositoryImpl(this.moviesRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getLatestMovies() async {
    return _getMovies(() => moviesRemoteDataSource.getLatestMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() {
    return _getMovies(() => moviesRemoteDataSource.getPopularMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() {
    return _getMovies(() => moviesRemoteDataSource.getTopRatedMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() {
    return _getMovies(() => moviesRemoteDataSource.getUpcomingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() {
    return _getMovies(() => moviesRemoteDataSource.getNowPlayingMovies());
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesBySearch(String query) {
    return _getMovies(() => moviesRemoteDataSource.getMoviesBySearch(query));
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(int id) async {
    try {
      final movie = await moviesRemoteDataSource.getMovieDetails(id);
      return Right(movie);
    } on ServerExceptoin {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Movie>>> _getMovies(
      _WhichMoviesToGet whatMovies) async {
    try {
      final movies = await whatMovies();
      return Right(movies);
    } on ServerExceptoin {
      return Left(ServerFailure());
    }
  }
}
