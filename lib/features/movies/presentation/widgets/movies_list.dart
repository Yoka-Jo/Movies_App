import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/presentation/views/movie_details_screen.dart';
import 'package:movie_app/features/movies/presentation/widgets/vertical_movie_list.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> nowMovies;
  final List<Movie> popularMovies;
  const MoviesList({
    Key? key,
    required this.nowMovies,
    required this.popularMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 290,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Now",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0),
                  )),
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (context, i) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                          movie: nowMovies[i],
                                        )));
                              },
                              child: Container(
                                decoration: const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 20))
                                ]),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/images/poster-placeholder.png'),
                                  image: NetworkImage(
                                    nowMovies[i].posterImage,
                                  ),
                                  height: 200,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.0,
                              child: Text(
                                nowMovies[i].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                    separatorBuilder: (context, i) => const SizedBox(
                          width: 20.0,
                        ),
                    itemCount: nowMovies.length),
              ),
            ],
          ),
        ),
        VerticalMovieList(
          movies: popularMovies,
          name: "Popular",
        )
      ],
    );
  }
}
