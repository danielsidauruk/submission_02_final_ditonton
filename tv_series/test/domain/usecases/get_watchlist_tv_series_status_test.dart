import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTVSeriesStatus usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchlistTVSeriesStatus(mockTVSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
