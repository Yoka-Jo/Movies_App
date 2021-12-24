import 'package:flutter/material.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/presentation/views/tv_details_screen.dart';

class VerticalTvList extends StatelessWidget {
  const VerticalTvList({Key? key, required this.tvShows, required this.name})
      : super(key: key);

  final List<TvShow> tvShows;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0),
            )),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, i) => InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TvDetailsScreen(
                        tvShow: tvShows[i],
                      )));
            },
            child: Stack(children: [
              FadeInImage(
                placeholder:
                    const AssetImage('assets/images/poster-placeholder.png'),
                image: NetworkImage(
                  tvShows[i].posterImage,
                ),
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 50.0,
                      width: 150.0,
                      color: Colors.black45,
                      child: Center(
                        child: Text(tvShows[i].title,
                            style: const TextStyle(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold)),
                      )))
            ]),
          ),
          itemCount: tvShows.length,
        ),
      ],
    );
  }
}
