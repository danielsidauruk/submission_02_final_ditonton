import 'package:tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetTVSeriesRecommendations {
  final TVSeriesRepository repository;

  GetTVSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute(int id) {
    return repository.getTVSeriesRecommendations(id);
  }
}
