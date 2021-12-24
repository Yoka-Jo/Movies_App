import 'package:movie_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/repositories/movies_app_repository.dart';

class GetMoviesBySearchUseCase extends UseCase<List<Movie>, String> {
  final MoviesAppRepository moviesAppRepository;

  GetMoviesBySearchUseCase(this.moviesAppRepository);
  @override
  Future<Either<Failure, List<Movie>>> call(String params) async {
    return moviesAppRepository.getMoviesBySearch(params);
  }
}
