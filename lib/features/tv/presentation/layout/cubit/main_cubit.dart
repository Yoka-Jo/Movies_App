import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/presentation/views/movies_screen.dart';
import 'package:movie_app/features/tv/presentation/views/tv_screen.dart';
import '../settings_screen.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit of(BuildContext context) => BlocProvider.of(context);

  List<Widget> screens = const [MoviesScreen(), TvScreen(), SettingsScreen()];
  List<String> titles = const ['MOVIES', 'TV', 'SETTINGS'];

  int navIndex = 0;

  void changeNavBarScreen(int index) {
    navIndex = index;
    emit(ChangeNavBarScreenState());
  }
}
