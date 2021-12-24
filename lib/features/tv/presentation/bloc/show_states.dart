part of 'show_bloc.dart';

@immutable
abstract class ShowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowInitial extends ShowState {}

class LoadingShowState extends ShowState {}

class LoadedShowState extends ShowState {}

class LoadedFilteredShowState extends ShowState {}

class ErrorShowsState extends ShowState {
  final String message;

  ErrorShowsState(this.message);
  @override
  List<Object?> get props => [message];
}

class ClearSearchedListState extends ShowState {}
