import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/domain/repositories/tv_show_app_repository.dart';

class GetTvShowsBySearchUseCase extends UseCase<List<TvShow>,String>{
   final TvShowAppRepository tvShowAppRepository;

  GetTvShowsBySearchUseCase(this.tvShowAppRepository);
  @override
  Future<Either<Failure, List<TvShow>>> call(String params) async{
    return await tvShowAppRepository.getShowsBySearch(params);
  }
  
}