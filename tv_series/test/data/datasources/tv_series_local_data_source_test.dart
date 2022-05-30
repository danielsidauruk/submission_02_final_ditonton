import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesLocalDataSourceImpl dataSource;
  late MockTVSeriesDatabaseHelper mockTVSeriesDatabaseHelper;

  setUp(() {
    mockTVSeriesDatabaseHelper = MockTVSeriesDatabaseHelper();
    dataSource =
        TVSeriesLocalDataSourceImpl(databaseHelper: mockTVSeriesDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.insertWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTVSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.insertWatchlist(testTVSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTVSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.removeWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTVSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.removeWatchlist(testTVSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTVSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TVSeries Detail By Id', () {
    const tId = 1;

    test('should return TVSeries Detail Table when data is found', () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.getTVSeriesById(tId))
          .thenAnswer((_) async => testTVSeriesMap);
      // act
      final result = await dataSource.getTVSeriesById(tId);
      // assert
      expect(result, testTVSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.getTVSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist TVSeries', () {
    test('should return list of TVSeriesTable from database', () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTVSeriesMap]);
      // act
      final result = await dataSource.getWatchlistTVSeries();
      // assert
      expect(result, [testTVSeriesTable]);
    });
  });
}
