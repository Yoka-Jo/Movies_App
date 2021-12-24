import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/domain/repositories/tv_show_app_repository.dart';

class GetPopularTvShwosUseCase extends UseCase<List<TvShow>,NoParams>{
  final TvShowAppRepository tvShowAppRepository;

  GetPopularTvShwosUseCase(this.tvShowAppRepository);
  @override
  Future<Either<Failure, List<TvShow>>> call(NoParams params) async{
    return await tvShowAppRepository.getPopularShows();
  }
  
}