import 'package:tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
