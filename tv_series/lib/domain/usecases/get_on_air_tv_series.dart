import 'package:tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetOnAirTVSeries {
  final TVSeriesRepository repository;

  GetOnAirTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getOnAirTVSeries();
  }
}
