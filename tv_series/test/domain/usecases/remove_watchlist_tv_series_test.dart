import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../test/dummy_data/dummy_object.dart';

void main() {
  late RemoveWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveWatchlistTVSeries(mockTVSeriesRepository);
  });

  test('should remove watchlist TVSeries from repository', () async {
    // arrange
    when(mockTVSeriesRepository.removeWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.removeWatchlist(testTVSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
