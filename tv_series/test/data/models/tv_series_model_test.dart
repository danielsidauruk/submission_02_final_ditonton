import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  const tTVSeriesModel = TVSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = TVSeries(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of TVSeries entity', () async {
    final result = tTVSeriesModel.toEntity();
    expect(result, tTv);
  });
}
