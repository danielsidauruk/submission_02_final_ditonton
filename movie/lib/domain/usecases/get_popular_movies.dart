import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
