import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/widgets/movies_list.dart';
import 'package:movie_app/features/movies/presentation/widgets/vertical_movie_list.dart';

// ignore: must_be_immutable
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  String filteredListName = '';

  @override
  void initState() {
    super.initState();
    if (MovieBloc.of(context).nowPlayingMovies.isEmpty &&
        MovieBloc.of(context).popularMovies.isEmpty) {
      MovieBloc.of(context)
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Filter',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            PopupMenuButton(
                elevation: 20.0,
                color: Colors.black87,
                icon: const Icon(
                  Icons.more_vert,
                  size: 25.0,
                ),
                itemBuilder: (_) => [
                      filterItem(
                          itemName: 'Main Screen',
                          onTap: () {
                            MovieBloc.of(context)
                                .add(GetMainScreenMoviesEvent());
                          }),
                      filterItem(
                          itemName: 'Top Rated',
                          onTap: () {
                            filteredListName = 'Top Rated';
                            MovieBloc.of(context).add(GetTopRatedMoviesEvent());
                          }),
                      filterItem(
                          itemName: 'Upcoming',
                          onTap: () {
                            filteredListName = 'Upcoming';
                            MovieBloc.of(context).add(GetUpcomingMoviesEvent());
                          }),
                    ]),
            const SizedBox(
              width: 15.0,
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is ErrorMoviesState) {
                  return const Center(child: Text("Error"));
                }
                if (state is LoadedMoviesState) {
                  return MoviesList(
                    nowMovies: MovieBloc.of(context).nowPlayingMovies,
                    popularMovies: MovieBloc.of(context).popularMovies,
                  );
                } else if (state is LoadedFilteredMoviesState) {
                  return VerticalMovieList(
                    movies: MovieBloc.of(context).filteredMovies,
                    name: filteredListName,
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<dynamic> filterItem(
      {required void Function() onTap, required String itemName}) {
    return PopupMenuItem(
      onTap: () {
        onTap();
      },
      padding: EdgeInsets.zero,
      child: Center(
        child: Text(
          itemName,
          style: const TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
