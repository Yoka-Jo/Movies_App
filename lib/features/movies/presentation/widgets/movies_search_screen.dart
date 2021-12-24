import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/views/movie_details_screen.dart';

class MoviesSearchScreen extends StatefulWidget {
  const MoviesSearchScreen({Key? key}) : super(key: key);

  @override
  State<MoviesSearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<MoviesSearchScreen> {
  late TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      textController.clear();
                      MovieBloc.of(context).add(GetMainScreenMoviesEvent());
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        controller: textController,
                        onChanged: (query) {
                          if (query.isNotEmpty) {
                            MovieBloc.of(context)
                                .add(GetMovieBySearchEvent(query: query));
                          } else {
                            MovieBloc.of(context).add(ClearSearchedListEvent());
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
                final movies = MovieBloc.of(context).filteredMovies;
                if (state is ErrorMoviesState) {
                  return const Center(child: Text("Error"));
                } else if (state is LoadedFilteredMoviesState) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            trailing: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                movies[index].posterImage,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(
                                        movie: movies[index],
                                      )));
                            },
                            title: Text(movies[index].title)),
                      );
                    },
                    itemCount: textController.text.isEmpty
                        ? 0
                        : MovieBloc.of(context).filteredMovies.length,
                    //  query.length == 0 ? names.length : suggestionList == null ? 0 :  suggestionList.length,
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: textController.text.isEmpty
                          ? const Text('Please Enter Something',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                          : const CircularProgressIndicator(),
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
