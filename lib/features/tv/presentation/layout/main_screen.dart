import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/presentation/widgets/movies_search_screen.dart';
import 'package:movie_app/features/tv/presentation/layout/cubit/main_cubit.dart';
import 'package:movie_app/features/tv/presentation/widgets/tv_search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = MainCubit.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.navIndex],
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
            ),
            actions: cubit.navIndex == 2
                ? []
                : [
                    IconButton(
                      onPressed: () {
                        if (cubit.navIndex == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const MoviesSearchScreen()));
                        } else if (cubit.navIndex == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TvSearchScreen()));
                        }
                      },
                      icon: const Icon(Icons.search, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 15.0,
                    )
                  ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.navIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.deepOrange,
              iconSize: 30.0,
              onTap: (index) {
                cubit.changeNavBarScreen(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.movie), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.tv), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
              ]),
          body: cubit.screens[cubit.navIndex],
        );
      },
    );
  }
}
