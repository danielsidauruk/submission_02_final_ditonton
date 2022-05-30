import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../test/dummy_data/dummy_object.dart';

void main() {
  late SaveWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveWatchlistTVSeries(mockTVSeriesRepository);
  });

  test('should save TVSeries to the repository', () async {
    // arrange
    when(mockTVSeriesRepository.saveWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.saveWatchlist(testTVSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
