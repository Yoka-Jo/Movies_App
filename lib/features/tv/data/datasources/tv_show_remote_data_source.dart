import 'dart:convert';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/tv/data/models/tv_show_model.dart';
import 'package:movie_app/features/tv/domain/entities/tv_show.dart';

abstract class TvShowsRemoteDataSource {
  Future<List<TvShow>> getLatestShows();
  Future<List<TvShow>> getPopularShows();
  Future<List<TvShow>> getTopRatedShows();
  Future<List<TvShow>> getUpcomingShowsEpisodes();
  Future<List<TvShow>> getShowsPlayingToday();
  Future<List<TvShow>> getShowsBySearch(String query);
  Future<TvShow> getShowDetails(int id);
}

class TvShowsRemoteDataSourceImpl extends TvShowsRemoteDataSource {
  final http.Client client;

  TvShowsRemoteDataSourceImpl(this.client);

  @override
  Future<List<TvShow>> getLatestShows() =>
      _getShowsFromUrl('$API_URL/tv/$GET_LATEST?api_key=$API_KEY');

  @override
  Future<List<TvShow>> getPopularShows() =>
      _getShowsFromUrl('$API_URL/tv/$GET_POPULAR?api_key=$API_KEY');

  @override
  Future<List<TvShow>> getTopRatedShows() =>
      _getShowsFromUrl('$API_URL/tv/$GET_TOP_RATED?api_key=$API_KEY');

  @override
  Future<List<TvShow>> getUpcomingShowsEpisodes() => _getShowsFromUrl(
      '$API_URL/tv/$GET_UPCOMING_TV_SHOWS_EPISODES?api_key=$API_KEY');

  @override
  Future<List<TvShow>> getShowsPlayingToday() =>
      _getShowsFromUrl('$API_URL/tv/$GET_NOW_PLAYING_TV_SHOW?api_key=$API_KEY');

  @override
  Future<List<TvShow>> getShowsBySearch(String query) =>
      _getShowsFromUrl('$API_URL/search/tv?api_key=$API_KEY&query=$query');

  @override
  Future<TvShow> getShowDetails(int id) async {
    final response =
        await client.get(Uri.parse('$API_URL/tv/$id?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      final show = TvShowModel.fromJson(json.decode(response.body));
      return show;
    } else {
      throw ServerExceptoin();
    }
  }

  Future<List<TvShow>> _getShowsFromUrl(String url) async {
    final response = await client.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<TvShow> shows = [];
    if (response.statusCode == 200) {
      extractedData['results'].forEach((value) {
        shows.add(TvShowModel.fromJson(value));
      });
      return shows;
    } else {
      throw ServerExceptoin();
    }
  }
}
