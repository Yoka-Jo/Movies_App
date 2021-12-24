import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/tv/presentation/bloc/show_bloc.dart';
import 'package:movie_app/features/tv/presentation/views/tv_details_screen.dart';

class TvSearchScreen extends StatefulWidget {
  const TvSearchScreen({Key? key}) : super(key: key);

  @override
  State<TvSearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<TvSearchScreen> {
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
                      ShowBloc.of(context).add(GetMainScreenShowsEvent());
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
                            ShowBloc.of(context)
                                .add(GetShowsBySearchEvent(query: query));
                          } else {
                            ShowBloc.of(context).add(ClearSearchedListEvent());
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
              BlocBuilder<ShowBloc, ShowState>(builder: (context, state) {
                if (state is ErrorShowsState) {
                  return const Center(child: Text("Error"));
                } else if (state is LoadedFilteredShowState) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final tvShows = ShowBloc.of(context).filteredTvShows;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            trailing: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                tvShows[index].posterImage,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TvDetailsScreen(
                                        tvShow: tvShows[index],
                                      )));
                            },
                            title: Text(tvShows[index].title)),
                      );
                    },
                    itemCount: textController.text.isEmpty
                        ? 0
                        : ShowBloc.of(context).filteredTvShows.length,
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
