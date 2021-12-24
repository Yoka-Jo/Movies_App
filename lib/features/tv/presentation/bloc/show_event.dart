part of 'show_bloc.dart';

@immutable
abstract class ShowEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLatestShowsEvent extends ShowEvent {}

class GetMainScreenShowsEvent extends ShowEvent {}

class GetPopularShowsEvent extends ShowEvent {}

class GetTopRatedShowsEvent extends ShowEvent {}

class GetUpcomingShowsEpisodesEvent extends ShowEvent {}

class GetShowsPlayingTodayEvent extends ShowEvent {}

class GetShowsBySearchEvent extends ShowEvent {
  final String query;

  GetShowsBySearchEvent({required this.query});
  @override
  List<Object?> get props => [query];
}

class GetShowDetailsEvent extends ShowEvent {
  final int id;

  GetShowDetailsEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ClearSearchedListEvent extends ShowEvent {}
