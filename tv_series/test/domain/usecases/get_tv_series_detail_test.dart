import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_object.dart';

void main() {
  late GetTVSeriesDetail usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesDetail(mockTVSeriesRepository);
  });

  const tId = 1;

  test('should get TVSeries detail from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTVSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVSeriesDetail));
  });
}
