import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/domain/repositories/tv_show_app_repository.dart';

class GetTvShowDetailsUseCase extends UseCase<TvShow,Params>{
  final TvShowAppRepository tvShowAppRepository;

  GetTvShowDetailsUseCase(this.tvShowAppRepository);
  @override
  Future<Either<Failure, TvShow>> call(Params params) async{
    return await tvShowAppRepository.getShowDetails(params.id);
  }
  
}