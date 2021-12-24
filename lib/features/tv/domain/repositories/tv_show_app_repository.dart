import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';

abstract class TvShowAppRepository {
  Future<Either<Failure,List<TvShow>>> getLatestShows();
  Future<Either<Failure,List<TvShow>>> getPopularShows();
  Future<Either<Failure,List<TvShow>>> getTopRatedShows();
  Future<Either<Failure,List<TvShow>>> getUpcomingShowsEpisodes();
  Future<Either<Failure,List<TvShow>>> getShowsPlayingToday();
  Future<Either<Failure,List<TvShow>>> getShowsBySearch(String query);
  Future<Either<Failure,TvShow>> getShowDetails(int id );
}