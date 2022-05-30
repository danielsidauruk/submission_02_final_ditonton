import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../test/dummy_data/dummy_object.dart';

void main() {
  late GetWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchlistTVSeries(mockTVSeriesRepository);
  });

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getWatchlistTVSeries())
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
