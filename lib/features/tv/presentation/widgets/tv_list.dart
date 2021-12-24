import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';
import 'package:movie_app/features/tv/presentation/views/tv_details_screen.dart';
import 'package:movie_app/features/tv/presentation/widgets/vertical_tv_list.dart';

class TvList extends StatelessWidget {
  final List<TvShow> nowTvShows;
  final List<TvShow> popularTvShows;
  const TvList({
    Key? key,
    required this.nowTvShows,
    required this.popularTvShows,
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
                                    builder: (context) => TvDetailsScreen(
                                          tvShow: nowTvShows[i],
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
                                    nowTvShows[i].posterImage,
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
                                nowTvShows[i].title,
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
                    itemCount: nowTvShows.length),
              ),
            ],
          ),
        ),
        VerticalTvList(
          tvShows: popularTvShows,
          name: "Popular",
        )
      ],
    );
  }
}
