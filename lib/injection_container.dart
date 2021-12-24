import 'package:get_it/get_it.dart';
import 'package:movie_app/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:movie_app/features/movies/data/repositories/movies_app_repository_impl.dart';
import 'package:movie_app/features/movies/domain/repositories/movies_app_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/get_latest_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movies_by_search_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movie_app/features/movies/domain/usecases/get_upcoming_movies_usecase.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:movie_app/features/tv/presentation/bloc/show_bloc.dart';
import 'features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'features/tv/data/datasources/tv_show_remote_data_source.dart';
import 'features/tv/data/repositories/tv_show_app_repository_impl.dart';
import 'features/tv/domain/repositories/tv_show_app_repository.dart';
import 'features/tv/domain/usecases/get_latest_tv_shows_usecase.dart';
import 'features/tv/domain/usecases/get_tv_shows_playing_today_usecase.dart';
import 'features/tv/domain/usecases/get_popular_tv_show_usecase.dart';
import 'features/tv/domain/usecases/get_top_rated_tv_show_usecase.dart';
import 'features/tv/domain/usecases/get_tv_shows_by_search_usecase.dart';
import 'features/tv/domain/usecases/get_tv_show_details_usecase.dart';
import 'features/tv/domain/usecases/get_upcoming_tv_shows_episodes_usecase.dart';

final sl = GetIt.instance;

Future<void> init()async{
 initMovies();
 initTvShows();

}

void initMovies(){
 sl.registerFactory(() =>
     MovieBloc(getLatestMoviesUseCase: sl(),
      getMovieDetailsUseCase: sl(),
      getPopularMoviesUseCase: sl(),
      getTopRatedMovieUseCase: sl(),
      getUpcomingMoviesUseCase: sl(),
      getNowPlayingMoviesUseCase: sl(),
      getMoviesBySearchUseCase: sl(),
     ));

 sl.registerLazySingleton(() => GetLatestMoviesUseCase(sl()));
 sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
 sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
 sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
 sl.registerLazySingleton(() => GetUpcomingMoviesUseCase(sl()));
 sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
 sl.registerLazySingleton(() => GetMoviesBySearchUseCase(sl()));

 sl.registerLazySingleton<MoviesAppRepository>(() => MoviesAppRepositoryImpl(sl()));
 sl.registerLazySingleton<MoviesRemoteDataSource>(() => MoviesRemoteDataSourceImpl(sl()));

 sl.registerLazySingleton(() => http.Client());
}

void initTvShows(){
 sl.registerFactory(() =>
     ShowBloc(
      getLatestShowsUseCase: sl(),
      getTvShowsPlayingTodayUseCase: sl(),
      getPopularShowsUseCase: sl(),
      getShowDetailsUseCase: sl(),
      getShowsBySearchUseCase: sl(),
      getTopRatedShowsUseCase: sl(),
      getUpcomingTvShowsEpisodesUseCase: sl(),
     ));

 sl.registerLazySingleton(() => GetLatestTvShowsUseCase(sl()));
 sl.registerLazySingleton(() => GetTvShowDetailsUseCase(sl()));
 sl.registerLazySingleton(() => GetPopularTvShwosUseCase(sl()));
 sl.registerLazySingleton(() => GetTopRatedTvShowsUseCase(sl()));
 sl.registerLazySingleton(() => GetUpcomingTvShowsEpisodesUseCase(sl()));
 sl.registerLazySingleton(() => GetTvShowsPlayingTodayUseCase(sl()));
 sl.registerLazySingleton(() => GetTvShowsBySearchUseCase(sl()));

 sl.registerLazySingleton<TvShowAppRepository>(() => TvShowsAppRepositoryImpl(sl()));
 sl.registerLazySingleton<TvShowsRemoteDataSource>(() => TvShowsRemoteDataSourceImpl(sl()));

  
}