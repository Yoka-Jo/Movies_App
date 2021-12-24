import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Back",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.network(
                movie.posterImage,
                height: 400,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black38,
                      child: Text(movie.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0))))
            ]),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "${movie.voteCount > 1000 ? getVoteCount() : movie.voteCount}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange)),
                    const TextSpan(
                        text: " People Voted",
                        style: TextStyle(color: Colors.black))
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "With Rate ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: movie.rate.toString().split('.').first,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                            fontSize: 20.0)),
                    TextSpan(
                        text: ".${movie.rate.toString().split('.').last}",
                        style: const TextStyle(color: Colors.deepOrange)),
                  ])),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(movie.description,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black87)),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  String getVoteCount() {
    String rateNumbers = movie.voteCount.toString();
    List<String> rateNumbersConverted = [];
    for (int i = 0; i < rateNumbers.length; i++) {
      if (i == 1) {
        rateNumbersConverted.add(',');
      }
      rateNumbersConverted.add(rateNumbers[i]);
    }
    return rateNumbersConverted.join();
  }
}
