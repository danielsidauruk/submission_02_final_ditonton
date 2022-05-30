import 'package:tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SearchTVSeries {
  final TVSeriesRepository repository;

  SearchTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(String query) {
    return repository.searchTVSeries(query);
  }
}
