import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetOnAirTVSeries(mockTVSeriesRepository);
  });

  final tTVSeries = <TVSeries>[];

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getOnAirTVSeries())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}
