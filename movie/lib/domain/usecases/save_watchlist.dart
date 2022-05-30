import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
