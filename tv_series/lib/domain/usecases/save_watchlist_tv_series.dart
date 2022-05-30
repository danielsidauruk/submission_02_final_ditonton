import 'package:tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SaveWatchlistTVSeries {
  final TVSeriesRepository repository;

  SaveWatchlistTVSeries(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail id) {
    return repository.saveWatchlist(id);
  }
}
