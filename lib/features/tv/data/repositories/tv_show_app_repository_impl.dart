import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/tv/data/datasources/tv_show_remote_data_source.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/domain/repositories/tv_show_app_repository.dart';

// ignore: prefer_generic_function_type_aliases
typedef Future<List<TvShow>> _WhichShowsToGet();

class TvShowsAppRepositoryImpl extends TvShowAppRepository {
  final TvShowsRemoteDataSource tvShowsRemoteDataSource;

  TvShowsAppRepositoryImpl(this.tvShowsRemoteDataSource);

  @override
  Future<Either<Failure, List<TvShow>>> getLatestShows() async {
    return _getShows(() => tvShowsRemoteDataSource.getLatestShows());
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularShows() {
    return _getShows(() => tvShowsRemoteDataSource.getPopularShows());
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedShows() {
    return _getShows(() => tvShowsRemoteDataSource.getTopRatedShows());
  }

  @override
  Future<Either<Failure, List<TvShow>>> getUpcomingShowsEpisodes() {
    return _getShows(() => tvShowsRemoteDataSource.getUpcomingShowsEpisodes());
  }

  @override
  Future<Either<Failure, List<TvShow>>> getShowsPlayingToday() {
    return _getShows(() => tvShowsRemoteDataSource.getShowsPlayingToday());
  }

  @override
  Future<Either<Failure, List<TvShow>>> getShowsBySearch(String query) {
    return _getShows(() => tvShowsRemoteDataSource.getShowsBySearch(query));
  }

  @override
  Future<Either<Failure, TvShow>> getShowDetails(int id) async {
    try {
      final show = await tvShowsRemoteDataSource.getShowDetails(id);
      return Right(show);
    } on ServerExceptoin {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TvShow>>> _getShows(
      _WhichShowsToGet whatShows) async {
    try {
      final shows = await whatShows();
      return Right(shows);
    } on ServerExceptoin {
      return Left(ServerFailure());
    }
  }
}
