import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({
    Key? key,
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return HorizontalCardList(
            posterPath: movie.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                detailMovieRoute,
                arguments: movie.id,
              );
            },
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
