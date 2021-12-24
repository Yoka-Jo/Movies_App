import 'dart:convert';

import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:http/http.dart' as http;

abstract class MoviesRemoteDataSource {
  Future<List<Movie>> getLatestMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getMoviesBySearch(String query);
  Future<Movie> getMovieDetails(int id);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  final http.Client client;

  MoviesRemoteDataSourceImpl(this.client);

  @override
  Future<List<Movie>> getLatestMovies() =>
      _getMoviesFromUrl('$API_URL/movie/$GET_LATEST?api_key=$API_KEY');

  @override
  Future<List<Movie>> getPopularMovies() =>
      _getMoviesFromUrl('$API_URL/movie/$GET_POPULAR?api_key=$API_KEY');

  @override
  Future<List<Movie>> getTopRatedMovies() =>
      _getMoviesFromUrl('$API_URL/movie/$GET_TOP_RATED?api_key=$API_KEY');

  @override
  Future<List<Movie>> getUpcomingMovies() =>
      _getMoviesFromUrl('$API_URL/movie/$GET_UPCOMING_MOVIES?api_key=$API_KEY');

  @override
  Future<List<Movie>> getNowPlayingMovies() => _getMoviesFromUrl(
      '$API_URL/movie/$GET_NOW_PLAYING_MOVIES?api_key=$API_KEY');

  @override
  Future<List<Movie>> getMoviesBySearch(String query) =>
      _getMoviesFromUrl('$API_URL/search/movie?api_key=$API_KEY&query=$query');

  @override
  Future<Movie> getMovieDetails(int id) async {
    final response =
        await client.get(Uri.parse('$API_URL/movie/$id?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      final movie = MovieModel.fromJson(json.decode(response.body));
      return movie;
    } else {
      throw ServerExceptoin();
    }
  }

  Future<List<Movie>> _getMoviesFromUrl(String url) async {
    final response = await client.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Movie> movies = [];
    if (response.statusCode == 200) {
      extractedData['results'].forEach((value) {
        movies.add(MovieModel.fromJson(value));
      });
      return movies;
    } else {
      throw ServerExceptoin();
    }
  }
}
