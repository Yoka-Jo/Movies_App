import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/domain/usecases/get_latest_tv_shows_usecase.dart';
import 'package:movie_app/features/tv/domain/usecases/get_tv_shows_playing_today_usecase.dart';
import 'package:movie_app/features/tv/domain/usecases/get_popular_tv_show_usecase.dart';
import 'package:movie_app/features/tv/domain/usecases/get_top_rated_tv_show_usecase.dart';
import 'package:movie_app/features/tv/domain/usecases/get_tv_shows_by_search_usecase.dart';
import 'package:movie_app/features/tv/domain/usecases/get_tv_show_details_usecase.dart';
import 'package:movie_app/features/tv/domain/usecases/get_upcoming_tv_shows_episodes_usecase.dart';
part 'show_event.dart';
part 'show_states.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  static ShowBloc of(BuildContext context) => BlocProvider.of(context);

  final GetLatestTvShowsUseCase getLatestShowsUseCase;
  final GetTvShowDetailsUseCase getShowDetailsUseCase;
  final GetPopularTvShwosUseCase getPopularShowsUseCase;
  final GetTopRatedTvShowsUseCase getTopRatedShowsUseCase;
  final GetUpcomingTvShowsEpisodesUseCase getUpcomingTvShowsEpisodesUseCase;
  final GetTvShowsPlayingTodayUseCase getTvShowsPlayingTodayUseCase;
  final GetTvShowsBySearchUseCase getShowsBySearchUseCase;

  ShowBloc({
    required this.getLatestShowsUseCase,
    required this.getShowDetailsUseCase,
    required this.getPopularShowsUseCase,
    required this.getTopRatedShowsUseCase,
    required this.getUpcomingTvShowsEpisodesUseCase,
    required this.getTvShowsPlayingTodayUseCase,
    required this.getShowsBySearchUseCase,
  }) : super(ShowInitial()) {
    on<GetMainScreenShowsEvent>((event, emit) => emit(LoadedShowState()));

    on<GetLatestShowsEvent>((event, emit) async {
      await _getShows(emit, getLatestShowsUseCase);
    });

    on<GetPopularShowsEvent>((event, emit) async {
      await _getShows(emit, getPopularShowsUseCase);
    });
    on<GetTopRatedShowsEvent>((event, emit) async {
      await _getShows(emit, getTopRatedShowsUseCase);
    });

    on<GetUpcomingShowsEpisodesEvent>((event, emit) async {
      await _getShows(emit, getUpcomingTvShowsEpisodesUseCase);
    });

    on<GetShowsPlayingTodayEvent>((event, emit) async {
      await _getShows(emit, getTvShowsPlayingTodayUseCase);
    });

    on<GetShowsBySearchEvent>((event, emit) async {
      await _getShows(emit, getShowsBySearchUseCase, search: event.query);
    });

    on<GetShowDetailsEvent>((event, emit) async {
      emit(LoadingShowState());
      final failureOrShows = await getShowDetailsUseCase(Params(event.id));
      failureOrShows.fold((left) => emit(ErrorShowsState("Server Failure")),
          (shows) => emit(LoadedShowState()));
    });
    on<ClearSearchedListEvent>((event, emit) {
      filteredTvShows = [];
      emit(ClearSearchedListState());
    });
  }

  TvShow? tvShowDetails;
  List<TvShow> nowPlayingTvShows = [];
  List<TvShow> popularTvShows = [];
  List<TvShow> filteredTvShows = [];

  Future<void> _getShows(Emitter<ShowState> emit, UseCase usecase,
      {String? search}) async {
    emit(LoadingShowState());
    final Either<Failure, dynamic> failureOrMovies;
    if (usecase is GetTvShowsBySearchUseCase) {
      failureOrMovies = await usecase(search!);
    } else {
      failureOrMovies = await usecase(NoParams());
    }
    failureOrMovies.fold((left) => emit(ErrorShowsState("Server Failure")),
        (tvShows) {
      switch (usecase.runtimeType) {
        case GetTvShowsPlayingTodayUseCase:
          nowPlayingTvShows = tvShows;
          break;
        case GetPopularTvShwosUseCase:
          popularTvShows = tvShows;
          break;
        case GetLatestTvShowsUseCase:
          filteredTvShows = tvShows;
          break;
        case GetTopRatedTvShowsUseCase:
          filteredTvShows = tvShows;
          break;
        case GetUpcomingTvShowsEpisodesUseCase:
          filteredTvShows = tvShows;
          break;
        case GetTvShowsBySearchUseCase:
          filteredTvShows = tvShows;
          break;
        default:
      }
    });

    if ((usecase is GetPopularTvShwosUseCase ||
            usecase is GetTvShowsPlayingTodayUseCase) &&
        popularTvShows.isNotEmpty &&
        nowPlayingTvShows.isNotEmpty) {
      emit(LoadedShowState());
    } else if (usecase is! GetPopularTvShwosUseCase &&
        usecase is! GetTvShowsPlayingTodayUseCase) {
      emit(LoadedFilteredShowState());
    }
  }
}
