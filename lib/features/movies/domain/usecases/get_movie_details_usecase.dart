import 'package:movie_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/repositories/movies_app_repository.dart';

class GetMovieDetailsUseCase extends UseCase<Movie, Params> {
  final MoviesAppRepository moviesAppRepository;

  GetMovieDetailsUseCase(this.moviesAppRepository);
  @override
  Future<Either<Failure, Movie>> call(Params params) async {
    return moviesAppRepository.getMovieDetails(params.id);
  }
}
