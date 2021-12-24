import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/tv/presentation/bloc/show_bloc.dart';
import 'package:movie_app/features/tv/presentation/widgets/tv_list.dart';
import 'package:movie_app/features/tv/presentation/widgets/vertical_tv_list.dart';

// ignore: must_be_immutable
class TvScreen extends StatefulWidget {
  const TvScreen({Key? key}) : super(key: key);

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  String filteredListName = '';

  @override
  void initState() {
    super.initState();
    if (ShowBloc.of(context).nowPlayingTvShows.isEmpty &&
        ShowBloc.of(context).popularTvShows.isEmpty) {
      ShowBloc.of(context)
        ..add(GetShowsPlayingTodayEvent())
        ..add(GetPopularShowsEvent());
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
                            ShowBloc.of(context).add(GetMainScreenShowsEvent());
                          }),
                      filterItem(
                          itemName: 'Top Rated',
                          onTap: () {
                            filteredListName = 'Top Rated';

                            ShowBloc.of(context).add(GetTopRatedShowsEvent());
                          }),
                      filterItem(
                          itemName: 'Upcoming',
                          onTap: () {
                            filteredListName = 'Upcoming';

                            ShowBloc.of(context)
                                .add(GetUpcomingShowsEpisodesEvent());
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
            child: BlocBuilder<ShowBloc, ShowState>(
              builder: (context, state) {
                if (state is ErrorShowsState) {
                  return const Center(child: Text("Error"));
                }
                if (state is LoadedShowState) {
                  return TvList(
                    nowTvShows: ShowBloc.of(context).nowPlayingTvShows,
                    popularTvShows: ShowBloc.of(context).popularTvShows,
                  );
                } else if (state is LoadedFilteredShowState) {
                  return VerticalTvList(
                    tvShows: ShowBloc.of(context).filteredTvShows,
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
