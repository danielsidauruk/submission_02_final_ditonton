import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../test/dummy_data/dummy_object.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockTVSeriesDatabaseHelper;

  setUp(() {
    mockTVSeriesDatabaseHelper = MockDatabaseHelper();
    dataSource =
        MovieLocalDataSourceImpl(databaseHelper: mockTVSeriesDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.removeWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockTVSeriesDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
